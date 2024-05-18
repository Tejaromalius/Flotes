import 'package:flotes/services/client.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getOrderedNotes() {
    return _firestore
        .collection('Notes')
        .where('UserID', isEqualTo: Get.find<Client>().info.uid)
        .orderBy("CreationDate", descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot<Object?>> createAndGetNote(
      String title, String content) async {
    final noteData = {
      'Title': title,
      'Content': content,
      'CreationDate': FieldValue.serverTimestamp(),
      'LastEditDate': FieldValue.serverTimestamp(),
      'UserID': Get.find<Client>().info.uid,
    };

    final docRef = await _firestore.collection('Notes').add(noteData);
    return docRef.get();
  }

  Future<DocumentSnapshot<Object?>> updateAndGetNote(
      DocumentSnapshot<Object?> document, String title, String content) async {
    final updatedData = {
      'Title': title,
      'Content': content,
      'LastEditDate': FieldValue.serverTimestamp(),
    };

    await document.reference.update(updatedData);
    return document.reference.get();
  }

  Future<void> deleteNote(DocumentSnapshot<Object?> document) async {
    await document.reference.delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> search(String query) async {
    return _firestore
        .collection('Notes')
        .where('UserID', isEqualTo: Get.find<Client>().info.uid)
        .get();
  }
}
