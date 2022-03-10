import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom/compnement/const.dart';
import 'package:zoom/cubit/state.dart';
import 'package:zoom/model/users.dart';
import 'package:zoom/share/cache_elper.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  late String verificationId;

  Future<void> submittedPhone(phone) async {
    emit(PhoneSubmittedLoading());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phone',
      timeout: Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  verificationCompleted(PhoneAuthCredential credential) async {
    await login(credential);
  }

  verificationFailed(FirebaseAuthException e) {
    emit(PhoneSubmittedError());

    print(e.toString());
  }

  codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(PhoneSubmittedSucsses());

    print('codeSent');
  }

  codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submittedOtpCode(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: smsCode);
    emit(PhoneSubmittedSucsses());
  }

  Future<void> login(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(LoginSucsses());
    } catch (er) {
      print(er.toString());
    }
  }

  logOut() {
    FirebaseAuth.instance.signOut();
    emit(LogoutSucsses());
  }

  User loggedIn() {
    return FirebaseAuth.instance.currentUser!;
  }

  void loginWithEmail({
    required String email,
    required String password,
  }) {
    emit(LoginWithEmailLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginWithEmailSucsses(value.user!.uid));
    }).catchError((er) {
      emit(LoginWithEmailError());

      print(er.toString());
    });
  }

  void createUserWithEmail({
    required String email,
    required String password,
    required String name,
  }) {
    emit(CreateWithEmailLoading());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      saveUserData(email: email, name: name, id: value.user!.uid);
      emit(CreateWithEmailSucsses(uid));
    }).catchError((er) {
      emit(CreateWithEmailError());

      print(er.toString());
    });
  }

  void saveUserData({
    String? name,
    String? email,
    String? id,
  }) {
    Users user = Users(
      name: name,
      email: email,
      id: id,
    );

    emit(SaveUserDataLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .set(user.toMap())
        .then((value) {
      emit(SaveUserDataSucsses());
    }).onError((error, stack) {
      print(stack.toString());
      print(error);
      emit(SaveUserDataError());
    });
  }

  String code = '';
  void createCode() {
    code = Uuid().v1().substring(0, 6);
    emit(CreateCodeSucsses());
  }

  bool isVideo = true;
  void isVideoButton(value) {
    isVideo = value;
    emit(CheckVideoSucsses());
  }

  bool isMuted = true;
  void isMutedButton(value) {
    isMuted = value;
    emit(CheckMutedSucsses());
  }

  Users? users;
  void getUserData() {
    emit(GetUserDataLoading());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      users = Users.fromJson(value.data()!);
      print(users!.name);
      emit(GetUserDataSucsses());
    }).catchError((er) {
      print(er.toString());
    });
  }
  // void getUsers() {
  //   try {
  //     emit(GetUserDataLoading());
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid!)
  //         .get()
  //         .then((value) {
  //       print(value.data());
  //       users = Users.fromJson(value.data());
  //       print(users!.name);
  //       emit(GetUserDataSucsses());
  //     }).catchError((er) {
  //       emit(GetUserDataError());

  //       print(er.toString());
  //     });
  //   } catch (er) {
  //     emit(GetUserDataError());

  //     print(er.toString());
  //   }
  // }
}
