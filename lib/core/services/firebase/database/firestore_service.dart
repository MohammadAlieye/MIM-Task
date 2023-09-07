import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/photo_model.dart';
import '../../../../features/home/text/models/text_model.dart';
import '../../../utils/helper/loading_helper.dart';

enum Collection { photos, messages }

class FirestoreService {
  static Future<bool> addPhoto(PhotoModel photo, String userId) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.photos.name)
          .doc(userId)
          .set(photo.toMap());
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      return false;
    }
  }


  static Future<bool> sendMessage(TextModel message) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collection.messages.name)
          .doc(message.id)
          .set(message.toMap());
      return true;
    } on FirebaseException catch (e) {
      log(e.message.toString());
      return false;
    }
  }
}
