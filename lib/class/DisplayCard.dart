import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventory_ms/main.dart';
import 'package:inventory_ms/src/app.pb.dart';
import 'package:inventory_ms/widgets/Item_p.dart';
import 'package:inventory_ms/widgets/product.dart';
import 'package:protobuf/protobuf.dart';

class DisplayCard extends StatelessWidget {
  final Product product;

  const DisplayCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemP(products: product)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: Card(
              elevation: 2,
              // color: Color.fromRGBO(245, 118, 26, 1),
              child: Expanded(
                  child: Column(
                children: [
                  if (product
                      .image.isNotEmpty) // Check if image data is present
                    Image.memory(
                      product.image as Uint8List,
                      height: 180,
                      fit: BoxFit.fill,
                    )
                  else
                    const Text('No Image'),
                  // Image.asset(Pimage, fit: BoxFit.fill, height: 218),
                  Text(product.name, style: TextStyle(color: Colors.black)),
                  Text(
                    '₹ ${product.price}',
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    '${product.quantity}',
                    style: TextStyle(color: Colors.deepOrange),
                    // style: TextStyle(color: Color.fromARGB(255, 48, 233, 55)),
                  )
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
