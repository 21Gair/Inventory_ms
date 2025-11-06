import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart';
import 'package:inventory_ms/class/connection.dart';
import 'package:inventory_ms/core/constants.dart';
import 'package:inventory_ms/src/app.pb.dart';
import 'package:inventory_ms/src/app.pbgrpc.dart';

class ItemP extends StatefulWidget {
  const ItemP({super.key, required this.products});

  final Product products;

  @override
  _ItemPState createState() => _ItemPState();
}

class _ItemPState extends State<ItemP> {
  // Sample data - replace with your actual product data
  var _selectedValue = 'new value 1'; // Initial dropdown value
  final _priceController = PriceController(); // Add PriceController
  final _quantityController = ValueChangerController();
  final List<String> _dropdownItems = [
    'new value 1',
    'new value 2',
    'new value 3'
  ]; // Dropdown items

  @override
  void initState() {
    super.initState();
    // Initialize the quantity controller with the product's quantity.
    _quantityController.setValue(widget.products.quantity);
    _priceController.setPrice(widget.products.price); // Initialize price
  }

  Future<void> _sendDataToServer(OperationType ok) async {
    final channel = GrpcClientService().createChannel();
    final stub = productServiceClient(channel);

    final request = UpdateProductRequest();
    request.name = widget.products.name;
    request.price = _priceController._price;
    request.quantity = _quantityController._value;
    request.operation = ok;
    print(request.operation);

    try {
      // Example gRPC call (replace with your actual call)
      final response = await stub.updateProduct(request);
      print('gRPC response: $response');
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully')),
      );

      // If it's a delete operation, navigate back
      if (ok == OperationType.DELETE) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('gRPC error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating product: $e')),
      );

      // Handle the error (e.g., display an error message)
    } finally {
      await channel.shutdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'), // Consistent AppBar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Make the page scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Product Image (Placeholder)
              Container(
                  height: 200,
                  color: Colors.grey[300], // Placeholder color
                  child: widget.products.image.isNotEmpty
                      ? // Check if image data is present
                      Image.memory(
                          widget.products.image as Uint8List,
                          height: 180,
                          fit: BoxFit.contain,
                        )
                      : const Text('No Image') //Basic Image PlaceHolder
                  ),
              const SizedBox(height: 16),

              // Product Name
              Text(
                widget.products.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Dropdown
              DropdownButtonFormField<String>(
                value: _selectedValue,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    // Null check
                    setState(() {
                      _selectedValue = newValue;
                    });
                  }
                },
                items: _dropdownItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Value', // Label for the dropdown
                  border: OutlineInputBorder(), //Added OutlineInputBorder
                ),
              ),
              const SizedBox(height: 16),

              // Price and Quantity Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Price:',
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextField(
                        controller: _priceController.controller,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onChanged: (text) {
                          setState(() {
                            _priceController.updatePrice(text);
                          });
                        }),
                  ),
                  //quantity
                  Row(
                    children: <Widget>[
                      const Text(
                        'Quantity:',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          // Prevent negative quantity
                          setState(() {
                            _quantityController.decrementValue();
                          });
                        },
                      ),
                      SizedBox(
                        width: 60, // Adjust as needed
                        child: TextField(
                          controller: _quantityController.controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                          onChanged: (text) {
                            setState(() {
                              _quantityController.updateValue(text);
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _quantityController.incrementValue();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Delete and Apply Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Implement delete functionality
                      print('Delete button pressed');
                      // Show a confirmation dialog before deleting.
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Item'),
                          content: const Text(
                              'Are you sure you want to delete this item?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //  Delete the item and navigate back.
                                _sendDataToServer(OperationType.DELETE);
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.of(context)
                                    .pop(); // Go back to the previous page
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Match the design
                    ),
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.white)),
                  ),
                  //Apply button
                  ElevatedButton(
                    onPressed: () {
                      _sendDataToServer(OperationType.UPDATE);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Apply',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ItemP extends StatefulWidget {
//   final image;
//   final String name;

//   ItemP({
//     required this.image,
//     required this.name,
//   });

//   @override
//   State<ItemP> createState() => _ItemPState();
// }

// class _ItemPState extends State<ItemP> {
//   final ValueChangerController _controller = ValueChangerController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.name),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.dangerous),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(kdouble10),
//           child: Column(
//             children: [
//               Image.memory(widget.image as Uint8List),
//               // +(price)-
//               Wrap(
//                 runAlignment: WrapAlignment.center,
//                 spacing: 10,
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         setState(() {
//                           _controller.incrementValue();
//                         });
//                       },
//                       child: const Text('+')),
//                   ConstrainedBox(
//                     constraints: const BoxConstraints(
//                       minWidth: 10,
//                       maxWidth: 40,
//                     ),
//                     child: TextField(
//                       controller: _controller.controller,
//                       keyboardType: TextInputType.number,
//                       onTap: () {
//                         _controller.controller.selection = TextSelection(
//                             baseOffset: 0,
//                             extentOffset:
//                                 _controller.controller.value.text.length);
//                       },
//                       onChanged: (text) {
//                         setState(() {
//                           _controller.updateValue(text);
//                         });
//                       },
//                     ),
//                   ),
//                   TextButton(
//                       onPressed: () {
//                         setState(() {
//                           _controller.decrementValue();
//                         });
//                       },
//                       child: const Text('-'))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// increment & dec value
class ValueChangerController {
  final TextEditingController _controller = TextEditingController();
  int _value = 0;

  ValueChangerController() {
    _controller.text = _value.toString();
  }

  TextEditingController get controller => _controller;

  int get value => _value;

  void incrementValue() {
    _value++;
    _controller.text = _value.toString();
  }

  void decrementValue() {
    if (_value > 0) {
      _value--;
      _controller.text = _value.toString();
    }
  }

  void updateValue(String text) {
    _value = int.tryParse(text) ?? 0;
    if (_value < 0) {
      _value = 0;
    }
    _controller.text = _value.toString();
  }

  void setValue(int newValue) {
    _value = newValue;
    _controller.text = _value.toString();
  }
}

class PriceController {
  final TextEditingController _controller = TextEditingController();
  double _price = 0.0;

  PriceController() {
    _controller.text = _price.toStringAsFixed(2); // Show 2 decimal places
  }

  TextEditingController get controller => _controller;

  double get price => _price;

  void updatePrice(String text) {
    _price = double.tryParse(text) ?? 0.0;
    if (_price < 0) {
      _price = 0.0;
    }
    final int? cursorPosition = _controller.selection.base.offset;
    _controller.text = _price.toStringAsFixed(2);
    if (cursorPosition != null) {
      _controller.selection = TextSelection.collapsed(offset: cursorPosition);
    }
  }

  void setPrice(double newPrice) {
    _price = newPrice;
    //  Preserve the cursor position:
    final int? cursorPosition = _controller.selection.base.offset;
    _controller.text = newPrice.toStringAsFixed(2);
    if (cursorPosition != null) {
      _controller.selection = TextSelection.collapsed(offset: cursorPosition);
    }
  }
}
