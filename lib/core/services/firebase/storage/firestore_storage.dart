import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../utils/helper/loading_helper.dart';

class FirestoreStorage {
  static Future<String> uploadFile(String filePath) async {
    final String path =
        'photo/${FirebaseAuth.instance.currentUser!.uid}/${Timestamp.now().millisecondsSinceEpoch}';
    Reference firestore = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = firestore.putFile(File(filePath));
    LoadingHelper.showLoading();
    TaskSnapshot snapshot = await uploadTask;
    final url = await snapshot.ref.getDownloadURL();
    LoadingHelper.hideLoading();
    return url;
  }
}
