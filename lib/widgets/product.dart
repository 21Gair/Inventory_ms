import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart' as gs;
import 'package:inventory_ms/class/connection.dart';
import 'package:inventory_ms/src/app.pbgrpc.dart';

import 'package:inventory_ms/class/DisplayCard.dart';
import 'package:inventory_ms/class/Search_Delegate.dart';
import 'package:inventory_ms/widgets/add_new.dart';
import 'package:inventory_ms/widgets/profile_page.dart';

Widget _buildProductCard(Product product) {
  return Container(
    width: 150,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      children: [
        if (product.image.isNotEmpty) // Check if image data is present
          Image.memory(
            product.image as Uint8List,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          )
        else
          const Text('No Image'),
        Text(product.name),
        Text('Price: ${product.price}'),
        Text('Quantity: ${product.quantity}'),
      ],
    ),
  );
}

Widget _buildProductList(Map<String, List<Product>> categoryProducts) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(
        top: 100.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0), // Adjust top padding as needed

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categoryProducts.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.key,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: entry.value
                    .map((product) => DisplayCard(product: product))
                    .toList(),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    ),
  );
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<Map<String, List<Product>>> _getDataToServer() async {
    final channel = GrpcClientService().createChannel();
    final stub = productServiceClient(channel);

    // 3. Prepare the gRPC Request
    try {
      final categoriesResponse = await stub.getCategories(Empty());
      Map<String, List<Product>> categoryProducts = {};
      print('category ${categoriesResponse}');

      for (var category in categoriesResponse.categories) {
        final productsResponse = await stub.getProductsByCategory(
          GetProductsByCategoryRequest()
            ..category = category
            ..limit = 3,
        );
        categoryProducts[category] = productsResponse.products;
      }
      print('Category Products: $categoryProducts');
      return categoryProducts;
    } catch (e) {
      print('gRPC Error: $e');
      return {};
    } finally {
      channel.shutdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: FutureBuilder<Map<String, List<Product>>>(
        future: _getDataToServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found.'));
          } else {
            return _buildProductList(snapshot.data!);
          }
        },
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: buildAppBar(context),
//       // appBar: AppBar(
//       //   title: const Text('Dashboard'),
//       // ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 100),
//             // alignment: const Alignment(-0.97, -1),
//             const Text('Grocery'),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   DisplayCard(
//                     Pimage: 'image/logo_gair.png',
//                     pname: 'GTFO',
//                     price: '499',
//                     Quantity: '2',
//                   ),
//                   DisplayCard(
//                     Pimage: 'images/Halo 5_ Guardians.jpeg',
//                     pname: 'Halo 5',
//                     price: '300',
//                     Quantity: '2',
//                   ),
//                   DisplayCard(
//                     Pimage: 'images/Samura_girl.jpg',
//                     pname: 'Samura girl',
//                     price: '1000',
//                     Quantity: '2',
//                   )
//                 ],
//               ),
//             ),
//             // server call
//           ],
//         ),
//       ),
//     );
//   }
// }

// AppBar button's
AppBar buildAppBar(BuildContext context) {
  return AppBar(
    // backgroundColor: Colors.orange.shade700,
    elevation: 2,
    title: const Text('Product'),
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          showSearch(context: context, delegate: MySearchDelegate());
        },
        icon: const Icon(Icons.search)),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile()));
          },
          icon: const Icon(Icons.person_2_rounded))
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNew()));
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Overview',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}
