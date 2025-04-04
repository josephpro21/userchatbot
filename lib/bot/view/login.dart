import 'package:flutter/material.dart';
import 'package:mama/bot/utilities/button.dart';
import 'package:mama/bot/view/signup.dart';

import '../services/supabaseservice.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    bool isSecure = true;
    final authService = AuthService();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  labelText: 'Enter Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
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
                      icon: isSecure == true
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  border: const OutlineInputBorder(),
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
                    authService.signInUser(password, email).then((_) {
                      return ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login successful')));
                    });
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
                  child: const Text('Dont Have Account Yet? Signup'))
            ],
          ),
        ),
      ),
    );
  }
}
