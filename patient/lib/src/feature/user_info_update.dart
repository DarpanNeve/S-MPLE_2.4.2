import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool isAdmin = false;

Future<void> checkIsAdmin() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final doc = await firestore
      .collection("Users_info")
      .doc(auth.currentUser!.email)
      .get();

  if (doc.exists) {
    if (doc.data() != null && doc.data()!['isAdmin'] != null) {
      isAdmin = doc["isAdmin"];
      if (doc["name"] == null) {
        await firestore
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update(
          {
            "name": FirebaseAuth.instance.currentUser!.displayName,
          },
        );
      }
    } else {
      await addUsersToFirestore();
      // Handle the case when the 'isAdmin' field is missing or null
      isAdmin = false;
    }
  } else {
    await addUsersToFirestore();
    isAdmin = false;
  }
}

Future<void> addUsersToFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // Ensure that the required user data is available and valid before adding to Firestore
  String? displayName = auth.currentUser!.displayName;
  String? uid = auth.currentUser!.uid;

  await firestore.collection("Users").doc(auth.currentUser!.email).set({
    "name": displayName,
    "email": auth.currentUser!.email,
    "uId": uid,
    "isAdmin": false,
  });
}
