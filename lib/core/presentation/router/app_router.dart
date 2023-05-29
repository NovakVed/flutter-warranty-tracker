import 'package:flutter/material.dart';
import 'package:flutter_warranty_tracker/features/article/presentation/add_product_screen.dart';
import 'package:flutter_warranty_tracker/features/home/presentation/home_screen.dart';
import 'package:flutter_warranty_tracker/features/login/presentation/auth_screen.dart';
import 'package:flutter_warranty_tracker/features/login/presentation/login_screen.dart';
import 'package:flutter_warranty_tracker/features/login/presentation/sign_up_screen.dart';
import 'package:flutter_warranty_tracker/features/policies/presentation/privacy_policy.dart';
import 'package:flutter_warranty_tracker/features/policies/presentation/terms_of_use.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const AuthScreen();
        },
      ),
      GoRoute(
          path: HomeScreen.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
          routes: [
            GoRoute(
              path: AddProductScreen.routeName,
              builder: (BuildContext context, GoRouterState state) {
                return const AddProductScreen();
              },
            ),
          ]),
      GoRoute(
        path: LoginScreen.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            child: const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: SignUpScreen.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: PrivacyPolicy.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const PrivacyPolicy();
        },
      ),
      GoRoute(
        path: TermsOfUse.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const TermsOfUse();
        },
      ),
    ],
  );
}
