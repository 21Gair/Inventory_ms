import 'package:flutter/material.dart';
import 'package:inventory_ms/core/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Profile"),
      ),
      backgroundColor: Colors.orange,
      body: const Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('Image/logo_gair.png'),
            radius: 90,
          ),
          SizedBox(
            height: kdouble20,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Flutter Map => Gaurav'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('info@flutterMap.com'),
          ),
          ListTile(
            leading: Icon(Icons.web),
            title: Text('FlutterMap.com'),
          ),
        ],
      ),
    );
  }
}
