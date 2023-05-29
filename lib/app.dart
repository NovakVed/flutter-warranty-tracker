import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_warranty_tracker/core/presentation/router/app_router.dart';

import './core/presentation/res/theme/theme.dart';
import 'features/login/business_logic/auth_bloc.dart';
import 'features/login/business_logic/profile_picture_cubit.dart';
import 'features/login/data/repository/auth_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfilePictureCubit(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
              create: (context) => AuthBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepository>(context),
                  )..add(IsSignedIn())),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: lightThemeData(Colors.orange),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
