import 'package:appwrite/appwrite.dart';

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
    return "success";
  } on AppwriteException catch (e) {
    return e.message.toString();
  }
}

/// LOGIN ///

Future loginUser({required String email, required String password}) async {
  try {
    final user = await account.createEmailSession(
      email: email,
      password: password,
    );
    return true;
  }on AppwriteException catch (e) {
    return false;
  }
}



/// LOGOUT ///

Future logoutUser()async{
  await account.deleteSession(sessionId: 'current');
}

//check if user have an active session or not

Future checkSession()async{
  try{
    await account.getSession(sessionId: 'current');
    return true;
  }
  on AppwriteException catch (e){
    return false;
  }
}