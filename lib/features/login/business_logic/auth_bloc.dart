import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum ErrorCode {
  email,
  password,
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(Uninitialized()) {
    on<SignInRequested>(_signInRequested);
    on<SignUpRequested>(_signUpRequested);
    on<GoogleSignInRequested>(_googleSignInRequested);
    on<SignOutRequested>(_signOutRequested);
    on<ForgotPassword>(_forgotPassword);
    on<IsSignedIn>(_isSignedIn);
  }

  // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
  Future<void> _signInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      await authRepository.signIn(email: event.email, password: event.password);
      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          const UnAuthenticated(
            errorCode: ErrorCode.email,
            errorMessage: 'No user found for that email.',
          ),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          const UnAuthenticated(
            errorCode: ErrorCode.password,
            errorMessage: 'Wrong password provided for that user.',
          ),
        );
      }
      emit(const UnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(const UnAuthenticated());
    }
  }

  // When User Presses the SignUp Button, we will send the SignUpRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
  Future<void> _signUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      await authRepository.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          const UnAuthenticated(
            errorCode: ErrorCode.password,
            errorMessage: 'The password provided is too weak.',
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          const UnAuthenticated(
            errorCode: ErrorCode.email,
            errorMessage: 'The account already exists for that email.',
          ),
        );
      } else {
        emit(AuthError(e.toString()));
      }
      emit(const UnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(const UnAuthenticated());
    }
  }

  // When User Presses the Google Login Button, we will send the GoogleSignInRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
  Future<void> _googleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      await authRepository.signInWithGoogle();
      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.toString()));
      emit(const UnAuthenticated());
    }
  }

  // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
  Future<void> _signOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    await authRepository.signOut();
    emit(const UnAuthenticated());
  }

  Future<void> _forgotPassword(
    ForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(const UnAuthenticated());
    await authRepository.forgotPassword(email: event.email);
    emit(PasswordReset());
  }

  Future<void> _isSignedIn(
    IsSignedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(Uninitialized());
    bool isSignedIn = await authRepository.isSignedIn();
    if (isSignedIn) {
      emit(Authenticated());
    } else {
      emit(const UnAuthenticated());
    }
  }
}
