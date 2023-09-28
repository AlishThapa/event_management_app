import 'package:appwrite/appwrite.dart';

import '../../auth.dart';

String databaseId = '65153a6166fe14ae786e';

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
        collectionId: '65153a72c2d0ec755080',
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
