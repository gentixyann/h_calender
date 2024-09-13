import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:h_calender/views/pages/day_page.dart';
import 'package:h_calender/views/pages/home_page.dart';
import 'package:h_calender/views/pages/settings_page.dart';
import 'package:h_calender/views/pages/widgets/main_scaffold.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
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
