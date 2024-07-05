import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schieved/app/data/service/base_service.dart';
import 'package:schieved/app/data/models/user_master_model.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/shared/utils.dart';

class AuthService extends BaseService {
  Future<bool> signInWithGoogle() async {
    try {
      isLoading.value = true;
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await BaseService.auth.signInWithCredential(credential);
      userMaster.value = UserMaster(
        uid: userCredential.user?.uid,
        email: userCredential.user?.email,
        photoUrl: userCredential.user?.photoURL,
        name: userCredential.user?.providerData[0].displayName,
      );
      getStorage.write('userMaster', userMaster.value);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      debugPrint('error signInWithGoogle : ${e.toString()}');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await BaseService.auth.signOut();
      getStorage.remove('userMaster');
      userMaster.value = UserMaster();
      return true;
    } catch (e) {
      debugPrint('error signOut : ${e.toString()}');
      return false;
    }
  }
}
