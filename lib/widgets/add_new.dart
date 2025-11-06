import 'dart:ui';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:inventory_ms/class/connection.dart';
import 'package:inventory_ms/core/constants.dart';
// image picker
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// Use the kIsWeb constant from the flutter/foundation.dart library to conditionally render different image widgets based on the platform.

//for talking to python server
import 'package:inventory_ms/src/app.pb.dart'; // Import the message definitions
import 'package:grpc/grpc.dart';
import 'package:inventory_ms/src/app.pbgrpc.dart';
import 'package:protobuf/protobuf.dart'; // For making gRPC calls

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  // Product Data Variables
  File? _image;
  String _product = "";
  double _prize = 0.0;
  int _quantity = 0;
  String _category = "";
  String _discription = "";

  // use this controler to get what the user type

  final _productController = TextEditingController();
  final _prizeController = TextEditingController();
  final _quantityController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _productController.dispose();
    _prizeController.dispose();
    _quantityController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

// picking Image from Gallery
  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // You can also use ImageSource.camera to pick an image from the camera

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _sendDataToServer() async {
    // 1. Validate Form (Optional but recommended)
    final channel = GrpcClientService().createChannel();
    final stub = productServiceClient(channel);

    try {
      // Example gRPC call (replace with your actual call)
      final response = await stub.getCategories(Empty());
      print('gRPC response: $response');
    } catch (e) {
      print('gRPC error: $e');
      // Handle the error (e.g., display an error message)
    } finally {
      // await channel.shutdown();
    }
    print(_product);
    // 3. Prepare the gRPC Request
    final request =
        AddProductRequest(); // Replace AddProductRequest with your proto message
    request.name = _product; // Use the values from the variables
    request.category = _category;
    request.price = _prize;
    request.quantity = _quantity;

    // request.discription = _discription;

    // to de deleated

    if (_image != null) {
      final imageBytes = await _image!.readAsBytes();
      request.image = imageBytes;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
      return; // Prevent the gRPC call
    }
    print('Product Name: ${request.name}');

    try {
      // 4. Make the gRPC Call
      final response = await stub
          .addProduct(request); // Replace addProduct with your gRPC method

      // 5. Handle the Response
      print(
          'gRPC Response: ${response.message}'); // Process the response from the server
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
      // Clear the form after successful submission
      _productController.clear();
      _prizeController.clear();
      _quantityController.clear();
      _categoryController.clear();
      _descriptionController.clear();

      setState(() {
        _product = "";
        _prize = 0.0;
        _quantity = 0;
        _category = "";
        _discription = "";
        _image = null;
      });
    } catch (e) {
      print('gRPC Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding product: $e')),
      );
    } finally {
      channel.shutdown(); // Close the channel
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New product'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.dangerous),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image
            const Text("Image", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            InkWell(
              onTap: () {
                _pickImage();
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _image != null ? Colors.blue : Colors.blueGrey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _image != null
                    ? kIsWeb // Check if running on the web
                        ? Image.network(
                            _image!.path) // Use Image.network for web
                        : Image.file(_image!) // Use Image.file for mobile
                    : const Center(
                        child: Icon(
                          Icons.add,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 8),
            // Name
            const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _productController,
              decoration: InputDecoration(
                hintText: "Name",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                      _productController.clear();
                    },
                    icon: (const Icon(Icons.clear))),
              ),
              onChanged: (value) => _product = value,
            ),
            // prize
            Text("prize", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextFormField(
              controller: null,
              initialValue: '0',
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "IN Numbers ",
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _prize = double.tryParse(value) ?? 0.0,
            ),
            SizedBox(height: 16),
            // quantity
            Text("quantity", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextFormField(
                controller: null,
                initialValue: '0',
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "IN Numbers ",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _quantity = int.tryParse(value) ?? 0),
            SizedBox(height: 16),
            // category
            const Text('category',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                hintText: "category",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                      _categoryController.clear();
                    },
                    icon: (const Icon(Icons.clear))),
              ),
              onChanged: (value) => _category = value,
            ),
            SizedBox(height: 16),

            // Discription
            const Text('Discription',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              maxLength: 100,
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "About product",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                      _descriptionController.clear();
                    },
                    icon: (const Icon(Icons.clear))),
              ),
              onChanged: (value) => _discription = value,
            ),
            // cancel & continue
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    // Handle cancel
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 59, 158, 240)),
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _sendDataToServer,
                ),
              ],
            ),
          ],
        ),
      ),

      // Text('Product Name ')
    );
  }
}
