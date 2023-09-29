import 'package:event_management_app/auth.dart';
import 'package:event_management_app/module/local_data_save/saved_data.dart';
import 'package:event_management_app/module/login_page.dart';
import 'package:flutter/material.dart';

import '../event/event_page.dart';
import '../widgets/custom_header_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';

  @override
  void initState() {
    userName = LocalDataSaved.getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(userName);
    return Scaffold(
      appBar: AppBar(
        title: CustomHeaderText(text: userName),
        centerTitle: true,
        leading: const Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                logoutUser().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.tealAccent,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const EventPage()));
        },
        backgroundColor: Colors.tealAccent,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
