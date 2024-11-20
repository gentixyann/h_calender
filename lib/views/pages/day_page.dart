import 'package:flutter/material.dart';
import 'package:h_calender/models/calendar.dart';
import 'package:h_calender/models/user.dart';
import 'package:h_calender/router.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_calender/utils/errors.dart';
import 'package:h_calender/views/pages/widgets/un_focus.dart';

class DayPage extends ConsumerWidget {
  const DayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UnFocus(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('記録しよう'),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _TitleField(),
              SizedBox(height: 24),
              _MemoField(),
              SizedBox(height: 24),
              _SubmitButton(),
            ],
          )),
    );
  }
}

class _TitleField extends ConsumerWidget {
  const _TitleField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'タイトル',
        prefixIcon: Icon(Icons.label),
      ),
    );
  }
}

class _MemoField extends ConsumerWidget {
  const _MemoField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TextField(
      maxLines: null,
      maxLength: 500,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'メモ',
        prefixIcon: Icon(Icons.description),
      ),
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: () => print('送信'),
      child: const FittedBox(
        child: Text(
          '記録する',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class DayProviders {
  static final _isInProgressProvider = StateProvider.autoDispose((ref) {
    return false;
  });

  @visibleForTesting
  static final titleProvider = ChangeNotifierProvider.autoDispose(
    (ref) => TextEditingController(),
  );

  @visibleForTesting
  static final memoProvider = ChangeNotifierProvider.autoDispose(
    (ref) => TextEditingController(),
  );

  @visibleForTesting
  static final dayEventValues = Provider.autoDispose((ref) => ({
        required VoidCallback onSuccess,
        required OnError onError,
      }) async {
        try {
          final user = ref.watch(userProvider);
          if (user == null || user.uid.isEmpty) {
            throw Exception('User not logged in or UID is null.');
          }
          await ref.watch(addEventProvider)(
            uid: user.uid,
            title: ref.watch(titleProvider).text,
            memo: ref.watch(memoProvider).text,
          );
        } catch (error) {
          print(error);
        }
      });
}

class DayRoute extends GoRouteData {
  const DayRoute();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => const DayPage();
}
