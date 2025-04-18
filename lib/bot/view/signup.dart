import 'package:flutter/material.dart';

import '../services/supabaseservice.dart';
import '../utilities/button.dart';
import '../utilities/utils.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isSecure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      appBar: null,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
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
                  'Sign up',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Username',
                    labelText: 'Enter username',
                    prefixIcon: const Icon(
                      Icons.person,
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
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Enter Email',
                    prefixIcon: const Icon(
                      Icons.person,
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
                  obscureText: isSecure,
                  controller: passwordController,
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
                  height: 10,
                ),
                ButtonWidget(
                    onPressed: () {
                      if (usernameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          emailController.text.isNotEmpty) {
                        authService.signUpUser(
                            context,
                            usernameController.text.toString(),
                            passwordController.text.toString(),
                            emailController.text.toString()
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Email,password or username must not be empty')));
                      }
                    },
                    text: 'SIGNUP'),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Login()));
                    },
                    child: const Text('Already Have Account? Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
