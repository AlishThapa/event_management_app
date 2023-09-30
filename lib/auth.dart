import 'package:appwrite/appwrite.dart';
import 'package:event_management_app/module/database/database.dart';
import 'package:event_management_app/module/local_data_save/saved_data.dart';
import 'package:flutter/material.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6514426ecc07f38d46b7')
    .setSelfSigned(status: true); // For self signed certificates, only use for development

// Register User
Account account = Account(client);

Future<String> createUser({required String name, required String email, required String password}) async {
  try {
    final user = await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
    saveUserData(name: name, email: email, userId: user.$id);
    return "success";
  } on AppwriteException catch (e) {
    print(e.message.toString());
    return e.message.toString();
  }
}

/// LOGIN ///

Future loginUser(BuildContext context, {required String email, required String password}) async {
  try {
    final user = await account.createEmailSession(
      email: email,
      password: password,
    );
    getUserData();
    LocalDataSaved.saveUserId(user.userId);
    return true;
  } on AppwriteException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Incorrect Email or Password'),
      ),
    );
    return false;
  }
}

/// LOGOUT ///

Future logoutUser() async {
  await account.deleteSession(sessionId: 'current');
}

//check if user have an active session or not

Future checkSession() async {
  try {
    await account.getSession(sessionId: 'current');
    return true;
  } on AppwriteException catch (e) {
    return false;
  }
}
