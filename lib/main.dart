import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:inventory_ms/class/connection.dart';
import 'package:inventory_ms/src/app.pb.dart';
import 'package:inventory_ms/src/app.pbgrpc.dart';
import 'package:inventory_ms/widgets/product.dart';

import 'package:grpc/grpc.dart';

// run app
void main() {
  runApp(const MyApp());
}

var myTheam = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  String user = '';
  String password = '';

  // Map<String, String> users = {
  //   'dribbble@gmail.com': '12345',
  //   'hunter@gmail.com': 'hunter',
  // };

// login request server
  Future<LoginResponse> _login(String user, String password) async {
    final channel = GrpcClientService().createChannel();
    final stub = productServiceClient(channel);
    try {
      final request = LoginRequest()
        ..user = user
        ..password = password;
      final response = await stub.login(request);
      return response;
    } catch (e) {
      print('Error during login: $e');
      // Handle the error appropriately (e.g., show a dialog to the user)
      throw e; // Re-throw the error to be caught by the caller, so the UI can react
    } finally {
      await channel.shutdown();
    }
  }

// this is for error display
  Future<String?> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    // return Future.delayed(loginTime).then((_) {
    //   if (!users.containsKey(data.name) || users[data.name] != data.password) {
    //     return 'Username or password is incorrect';
    //   }
    //   return null;
    // });

    try {
      final response = await _login(data.name, data.password);

      if (response.success) {
        // Store the token securely
        print('Login successful. Token ${response.token}.');
        return null; // Return null on success
      } else {
        return response.message; // Return the error message from the server
      }
    } catch (error) {
      return "Failed to connect to the server";
    }
  }

  Future<String?> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (name != 'user') {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Inventory Login',
      onLogin: _authUser,
      // onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
