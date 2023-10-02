import 'package:appwrite/appwrite.dart';
import 'package:event_management_app/module/local_data_save/saved_data.dart';

import '../../auth.dart';

String databaseId = '65153a6166fe14ae786e';
String userCollectionId = '65153a72c2d0ec755080';
String eventCollectionId = '6516eb5b6e862de7fbb4';

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
        collectionId: userCollectionId,
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
      collectionId: userCollectionId,
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

///create new event in database
Future<void> createEvent({
  required String name,
  required String description,
  required String image,
  required String location,
  required String datetime,
  required String createdBy,
  required bool isInPerson,
  required String guest,
  required String sponsors,
}) async {
  return await databases
      .createDocument(
        databaseId: databaseId,
        collectionId: eventCollectionId,
        documentId: ID.unique(),
        data: {
          "name": name,
          "description": description,
          "image": image,
          "location": location,
          "dateTime": datetime,
          "createdBy": createdBy,
          "isInPerson": isInPerson,
          "guest": guest,
          "sponsors": sponsors
        },
      )
      .then((value) => print("Event Created"))
      .catchError((e) => print(e));
}

///READ ALL EVENTS
Future getAllEvents() async {
  try {
    final data = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: eventCollectionId,
    );
    return data.documents;
  } catch (e) {
    print(e);
  }
}



///RSVP an event (Respond, if you please)
Future rsvpEvent({required List participants, required String documentId}) async {
  final userId = LocalDataSaved.getUserID();
  participants.add(userId);
  try {
    await databases.updateDocument(
        databaseId: databaseId,
        collectionId: eventCollectionId,
        documentId: documentId,
        data: {"participants": participants});
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
