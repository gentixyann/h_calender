import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// firebaseAuthのインスタンス
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// ログイン状態監視用
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.authStateChanges();
});

final userProvider = StateProvider((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.currentUser;
});

final signUpProvider = Provider(
  (ref) => ({
    required String email,
    required String password,
    required String name,
  }) async {
    final auth = ref.watch(firebaseAuthProvider);
    final createdUser =
        auth.createUserWithEmailAndPassword(email: email, password: password);
  },
);

final signInProvider = Provider(
  (ref) => ({
    required String email,
    required String password,
  }) async {
    final auth = ref.watch(firebaseAuthProvider);
    final userStateController = ref.read(userProvider.notifier);

    try {
      // signInWithEmailAndPassword を await で待つ
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // UserCredential から user 情報を取得
      final user = userCredential.user;
      if (user != null) {
        print(
            'Logged in as: ${user.email}, UID: ${user.uid},  name: ${user.displayName}');
        // userProvider でユーザー情報を更新
        userStateController.state = user;
      } else {
        print('User is null');
      }
    } on FirebaseAuthException catch (e) {
      print('Error during sign in: $e');
    }
  },
);

final signOutProvider = Provider((ref) => () async {
      final auth = ref.watch(firebaseAuthProvider);
      await auth.signOut();
    });
