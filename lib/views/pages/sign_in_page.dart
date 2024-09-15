import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_calender/router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

final _isInProgressProvider = StateProvider.autoDispose((ref) {
  return false;
});

@visibleForTesting
final validateProvider = Provider.autoDispose(
  (ref) => () {
    return ref.read(_formStateProvider).currentState?.validate();
  },
);

@visibleForTesting
final emailNumberProvider = ChangeNotifierProvider.autoDispose(
  (ref) => TextEditingController(),
);

@visibleForTesting
final passwordProvider = ChangeNotifierProvider.autoDispose(
  (ref) => TextEditingController(),
);

final _formStateProvider = Provider.autoDispose((_) => GlobalKey<FormState>());

class SignInRoute extends GoRouteData {
  const SignInRoute();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}
