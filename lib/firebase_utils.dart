

import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user_model.dart';

class FireBaseUtils {

  static CollectionReference<MyUsers>
  getUsersCollection() {

    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter<MyUsers>(

      fromFirestore: (snapshot, _) {

        return MyUsers.fromFireStore(
          snapshot.data()!,
        );
      },

      toFirestore: (user, _) {

        return user.toFireStore();
      },
    );
  }

  // Add User
  static Future<void> addUserToFireStore(
      MyUsers user,
      ) async {

    await getUsersCollection()
        .doc(user.id)
        .set(user);
  }

  // Read User
  static Future<MyUsers?> readUserFromFireStore(
      String id,
      ) async {

    var doc =
    await getUsersCollection()
        .doc(id)
        .get();

    return doc.data();
  }
}