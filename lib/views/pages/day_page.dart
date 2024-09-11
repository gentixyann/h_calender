import 'package:flutter/material.dart';
import 'package:h_calender/router.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DayPage extends ConsumerWidget {
  const DayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Page'),
      ),
      body: const Center(
        child: Text('dayです'),
      ),
    );
  }
}

class DayRoute extends GoRouteData {
  const DayRoute();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => const DayPage();
}
