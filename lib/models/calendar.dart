import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_calender/models/firebase.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final focusedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final addEventProvider = Provider((ref) => ({
      required String uid,
      required String title,
      String? memo,
    }) async {
      final firestore = ref.watch(firestoreProvider);
      await firestore.collection('users/$uid/events/').add({
        'title': title,
        'memo': memo,
      });
    });
