import 'package:flutter/material.dart';

import '../services/supabaseservice.dart';
import '../utilities/button.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    bool isSecure = true;
    final authService = AuthService();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final usernameController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
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
                  'Sign-up',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Username',
                    labelText: 'Enter username',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                      Icons.person,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
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
                        icon: isSecure == true
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    border: const OutlineInputBorder(),
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
                        authService
                            .signUpUser(usernameController.text,
                                passwordController.text, emailController.text)
                            .then((_) {
                          return ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Account created successfully')));
                        });
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
