import 'dart:io';

import 'package:event_management_app/module/loading_page.dart';
import 'package:event_management_app/module/local_data_save/saved_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LocalDataSaved.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(textTheme: GoogleFonts.interTextTheme()),
      home: const LoadingPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}