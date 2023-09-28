import 'package:appwrite/appwrite.dart';
import 'package:event_management_app/module/local_data_save/saved_data.dart';

import '../../auth.dart';

String databaseId = '65153a6166fe14ae786e';
String collectionId = '65153a72c2d0ec755080';

final Databases databases = Databases(client);

//saving in the database

Future<void> saveUserData({
  required String name,
  required String email,
  required String userId,
}) async {
  return await databases
      .createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: {
          "Name": name,
          "Email": email,
          "userID": userId,
        },
      )
      .then(
        (value) => print('document created successfully'),
      )
      .catchError((e) => print(e));
}

Future getUserData() async {
  final id = LocalDataSaved.getUserID();
  try {
    final data = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: [
        Query.equal('userID', id),
      ],
    );
    LocalDataSaved.saveUserName(data.documents[0].data['Name']);
    LocalDataSaved.saveUserEmail(data.documents[0].data['Email']);
    print(data);
  } catch (e) {
    print(e);
  }
}
