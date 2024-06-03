// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kyoumutechou/app/widget/app_start_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(RouterRef ref) {
  //final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    //refreshListenable: notifier,
    debugLogDiagnostics: true,
    initialLocation: AppRoute.path,
    routes: $appRoutes,
    //redirect: notifier.redirect,
  );
}

@TypedGoRoute<AppRoute>(path: AppRoute.path)
class AppRoute extends GoRouteData {
  const AppRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppStartPage();
  }
}

// @TypedGoRoute<SignInRoute>(path: SignInRoute.path)
// class SignInRoute extends GoRouteData {
//   const SignInRoute();

//   static const path = '/signIn';

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const SignInPage();
//   }
// }

// class GoNavigatorObserver extends NavigatorObserver {
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     debugPrint('did push route $route : $previousRoute');
//   }

//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     debugPrint('did pop route $route : $previousRoute');
//   }
// }

// // 010) ダッシュボードルート
// @TypedGoRoute<DashboardRoute>(path: DashboardRoute.path)
// class DashboardRoute extends GoRouteData {
//   const DashboardRoute();

//   static const path = '/dashboard';

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return DashboardPage();
//   }
// }

// // 020) 健康観察ルート
// @TypedGoRoute<HealthRoute>(path: HealthRoute.path)
// class HealthRoute extends GoRouteData {
//   const HealthRoute(this.showType);
//   final String showType;

//   static const path = '/health/:showType';
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     final showType = state.pathParameters['showType'] ?? 'list';
//     return HealthPage(showType: showType);
//   }
// }

// // 030) 出欠（日）ルート AttendancePage()
// @TypedGoRoute<AttendanceRoute>(path: AttendanceRoute.path)
// class AttendanceRoute extends GoRouteData {
//   const AttendanceRoute(this.showType);
//   final String showType;

//   static const path = '/attendance/:showType';

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     final showType = state.pathParameters['showType'] ?? 'list';
//     return AttendancePage(showType: showType);
//   }
// }

// // 040) 出欠（時限）ルート
// @TypedGoRoute<AttendanceTimedRoute>(path: AttendanceTimedRoute.path)
// class AttendanceTimedRoute extends GoRouteData {
//   const AttendanceTimedRoute(this.showType);
//   final String showType;

//   static const path = '/attendanceTimed/:showType';

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     final showType = state.pathParameters['showType'] ?? 'list';
//     return AttendanceTimedPage(showType: showType);
//   }
// }

// // 050) 気づき ルート
// @TypedGoRoute<AwarenessRoute>(path: AwarenessRoute.path)
// class AwarenessRoute extends GoRouteData {
//   const AwarenessRoute(this.showType);
//   final String showType;

//   static const path = '/awareness/:showType';

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     final showType = state.pathParameters['showType'] ?? 'list';
//     return AwarenessPage(showType: showType);
//   }
// }
