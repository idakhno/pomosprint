import 'package:go_router/go_router.dart';
import 'package:pomosprint/routing/routes.dart';
import 'package:pomosprint/ui/about/widgets/about_screen.dart';
import 'package:pomosprint/ui/core/ui/app_shell.dart';
import 'package:pomosprint/ui/focus/widgets/focus_screen.dart';
import 'package:pomosprint/ui/settings/widgets/settings_screen.dart';
import 'package:pomosprint/ui/stats/widgets/stats_screen.dart';

final router = GoRouter(
  initialLocation: Routes.focus,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.focus,
              builder: (context, state) => const FocusScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.stats,
              builder: (context, state) => const StatsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: Routes.about,
                  builder: (context, state) => const AboutScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
