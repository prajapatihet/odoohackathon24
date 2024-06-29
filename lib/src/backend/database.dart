import 'package:appwrite/appwrite.dart';
import 'package:odoohackathon24/src/backend/auth.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';

String databaseId = "667fc32900101c78bacf";

final Databases databases = Databases(client);

// Save the user data to appwrite database
Future<void> saveUserData(String name, String email, String userId) async {
  return await databases
      .createDocument(
          databaseId: databaseId,
          collectionId: "667fc34100366630ad88",
          documentId: ID.unique(),
          data: {
            "name": name,
            "email": email,
            "userId": userId,
          })
      .then((value) => print("Document Created"))
      .catchError((e) => print(e));
}

// get user data from the database
Future getUserData() async {
  final id = SavedData.getUserId();
  print(id);
  try {
    final data = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: "667fc34100366630ad88",
        queries: [
          Query.equal("userId", id),
        ]);

    SavedData.saveUserName(data.documents[0].data['name']);
    SavedData.saveUserEmail(data.documents[0].data['email']);
    // this is for organizer update please uncomment if required.
    // print(data.documents[0].data['isOrganizer']);
    // print(data.documents[0].data['isOrganizer'].runtimeType);
    // add this one
    SavedData.saveUserIsOrganized(
        data.documents[0].data['isOrganizer'] ?? false);

    // print("data is data : $data");
  } catch (e) {
    // print("error on database : $e");
    // print(e);
  }
}

// Create new events
Future<void> createEvent(
    String name,
    String desc,
    String image,
    String location,
    String datetime,
    String createdBy,
    bool isInPersonOrNot,
    String guest,
    String sponsers) async {
  return await databases
      .createDocument(
          databaseId: databaseId,
          collectionId: "667fd8040032215ca8e2",
          documentId: ID.unique(),
          data: {
            "name": name,
            "description": desc,
            "image": image,
            "location": location,
            "datetime": datetime,
            "createdBy": createdBy,
            "isInPerson": isInPersonOrNot,
            "guests": guest,
            "sponsers": sponsers
          })
      .then((value) => print("Event Created"))
      .catchError((e) => print(e));
}

// Read all Events
Future getAllEvents() async {
  try {
    final data = await databases.listDocuments(
        databaseId: databaseId, collectionId: "667fd8040032215ca8e2");
    return data.documents;
  } catch (e) {
    print(e);
  }
}
