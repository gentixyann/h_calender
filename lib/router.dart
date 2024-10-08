import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_calender/models/user.dart';

import 'package:h_calender/views/pages/day_page.dart';
import 'package:h_calender/views/pages/home_page.dart';
import 'package:h_calender/views/pages/password_reset_page.dart';
import 'package:h_calender/views/pages/settings_page.dart';
import 'package:h_calender/views/pages/sign_in_page.dart';
import 'package:h_calender/views/pages/sign_up_page.dart';
import 'package:h_calender/views/pages/widgets/main_scaffold.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  final authState = ref.watch(authStateChangesProvider);
  String initialLocation = const SignUpRoute().location;
  authState.whenData((user) {
    initialLocation = user != null
        ? const HomeRoute().location
        : const SignUpRoute().location;
  });
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    routes: [...$appRoutes],
  );
});

// メインシェルルート定義
@TypedStatefulShellRoute<MainShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(
          path: '/home',
          routes: [
            TypedGoRoute<DayRoute>(
              path: 'day',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsRoute>(
          path: '/settings',
        ),
      ],
    ),
  ],
)

// メインシェルルートの状態
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainScaffold(
      navigationShell: navigationShell,
    );
  }
}

class HomeShellBranchData extends StatefulShellBranchData {
  const HomeShellBranchData();
}

class SettingsShellBranchData extends StatefulShellBranchData {
  const SettingsShellBranchData();
}

// ルート定義
@TypedGoRoute<SignInRoute>(path: '/sign_in')
class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignInPage();
  }
}

@TypedGoRoute<SignUpRoute>(path: '/sign_up')
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpPage();
  }
}

@TypedGoRoute<PasswordResetRoute>(path: '/password_reset')
class PasswordResetRoute extends GoRouteData {
  const PasswordResetRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PasswordResetPage();
  }
}
