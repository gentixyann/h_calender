import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:h_calender/views/pages/day_page.dart';
import 'package:h_calender/views/pages/home_page.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [...$appRoutes],
  );
});

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<DayRoute>(
      path: 'day',
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

// final router = GoRouter(initialLocation: '/', routes: [
//   GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState? state) => const HomePage(),
//       routes: [
//         GoRoute(
//           path: 'day',
//           builder: (BuildContext context, GoRouterState? state) =>
//               const DayPage(),
//         ),
//       ]),
// ]);