import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // '/': (context) => SignInScreen(),
      'home_screen': (context) => const HomeScreen(),
      // 'signup_screen': (context) => SignUpScreen(),
      // 'forgot': (context) => ForgotPasswordScreen(),
    },
  ));
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  Future<void> SignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Replace 'home_screen' with the actual route name for your home screen.
      Navigator.pushReplacementNamed(context, 'home_screen');
    } catch (e) {
      String errorMessage = 'An error occurred.';

      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'An error occurred.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            errorMessage,
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber,
              Colors.white,
              Colors.green,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/project_image2.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          // Replace 'home_screen' with the actual route name for your home screen.
                          Navigator.pushReplacementNamed(context, 'home_screen');
                        },
                        child: const Text('Sign In'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Replace 'signup_screen' with the actual route name for your sign-up screen.
                              Navigator.pushNamed(context, 'signup_screen');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Replace 'forgot_password' with the actual route name for your forgot password screen.
                              Navigator.pushNamed(context, 'forgot_password');
                            },
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



