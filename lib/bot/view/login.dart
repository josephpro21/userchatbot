import 'package:flutter/material.dart';
import 'package:mama/bot/utilities/button.dart';
import 'package:mama/bot/view/signup.dart';

import '../services/supabaseservice.dart';
import '../utilities/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSecure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/images/botlogo.jpg'),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Login Page',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Enter Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(
                  height: height,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: isSecure,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    labelText: 'Enter Password',
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.green,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isSecure = !isSecure;
                          });
                        },
                        icon: Icon(isSecure
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      final email = emailController.text.toString();
                      final password = passwordController.text.toString();
                      authService.signInUser(context, password, email);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Email or Password is empty')));
                    }
                  },
                  text: 'Login',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Signup()));
                    },
                    child: const Text('Do not Have Account Yet? Signup'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
