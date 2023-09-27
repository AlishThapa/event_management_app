
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true; // Password visibility flag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // App Logo (You can replace this with a registration logo)
              Image.asset(
                "assets/logo.png",
                width: 150,
                height: 150,
              ),

              // Email TextField
              const TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password TextField with visibility toggle
              TextField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  // Handle registration logic here
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}