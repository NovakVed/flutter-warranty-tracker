import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/home_screen.dart';
import '../business_logic/auth_bloc.dart';
import 'loading_screen.dart';
import 'login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Authenticated) {
        return const HomeScreen();
      }
      if (state is Uninitialized) {
        return const LoadingScreen();
      }
      return const LoginScreen();
    });
  }
}
