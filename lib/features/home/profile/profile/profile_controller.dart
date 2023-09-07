import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/services/firebase/auth/firebase_auth_service.dart';
import 'package:task/core/services/firebase/database/firestore_service.dart';
import 'package:task/core/services/firebase/storage/firestore_storage.dart';
import 'package:task/core/utils/functions/functions.dart';
import 'package:task/core/utils/helper/helper_class.dart';
import 'package:task/core/utils/widgets/dialog.dart';
import 'package:task/features/auth/sign_in/views/signin_view.dart';
import 'package:task/core/models/photo_model.dart';



class ProfileController extends GetxController {
 RxBool isDarkMode = false.obs;
  RxBool receiveNotifications = true.obs;
 Rx<User?> user = FirebaseAuth.instance.currentUser.obs;
 Rx<String> photoUrl = ''.obs;

@override
  void onInit() {
    super.onInit();
    if(user.value != null){
      photoUrl.value = user.value!.photoURL!;
    }
  }

  showBottomSheet(BuildContext context) async {
    final xFile = await HelperClass().bottomSheetImagePicker(context);
    if (xFile == null) return;
    final url = await FirestoreStorage.uploadFile(xFile.path);
    final photo = PhotoModel(
      createdBy: FirebaseAuth.instance.currentUser!.uid,
      id: getRandomString(25),
      createdAt: Timestamp.now(),
      url: url,
      name: FirebaseAuth.instance.currentUser!.email!,
    );
    await FirestoreService.addPhoto(
        photo, FirebaseAuth.instance.currentUser!.uid);
      photoUrl.value =  await updateUserProfile(url );
  }

  Future<String> updateUserProfile(String profileImageUrl) async {
    String? url;
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePhotoURL(
         profileImageUrl, 
      );
      user = FirebaseAuth.instance.currentUser;
      if (user!.photoURL == profileImageUrl) {
        url = user.photoURL;
        print('Profile image URL updated successfully');
      } else {
        print('Profile image URL update failed');
      }
    }
  } catch (e) {
    print('Error updating user profile: $e');
  }
  return url!;
}

//  Future<void> updateUserProfileInFirestore(String uid, String imageUrl) async {
//   try {
//     await FirebaseFirestore.instance.collection('users').doc(uid).update({
//       'imageUrl': imageUrl,
//     });
//     print('Profile image URL updated in Firestore');
//   } catch (e) {
//     print('Error updating profile image URL in Firestore: $e');
//   }
// }


 

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    // You can save this setting locally (e.g., using shared_preferences) if needed.
  }
  void toggleNotifications() {
    receiveNotifications.value = !receiveNotifications.value;
    // You can save this setting locally or on a server if needed.
  }

  void signOut() {
    AppDialog().showOSDialog(
      context: Get.context!,
      title: "Sign Out",
      message: "Do you really want to sign out?",
      firstButtonText: "Cancel",
      secondButtonText: "Sign out",
      secondCallBack: _signOut,
    );
  }

  void _signOut() async {
    final isSuccess = await SignOutService().signOut();
    if (!isSuccess) return;
    Get.offAll(() => const SignInView());
  }
}
