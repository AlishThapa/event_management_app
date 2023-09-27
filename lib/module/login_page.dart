import 'package:event_management_app/module/register_page.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true; // Password visibility flag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // App Logo
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

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login logic here
                    },
                    child: const Text("Login"),
                  ),
                  Row(
                    children: [
                      Text(
                        "Don't have an account?,",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                        },
                        child: const Text(
                          "Register now",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
