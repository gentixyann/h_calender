import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h_calender/views/pages/home_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState? state) => const HomePage(),
  )
]);
