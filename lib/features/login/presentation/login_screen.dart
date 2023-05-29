import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import './sign_up_screen.dart';
import './widgets/change_between_auth_screen.dart';
import './widgets/email_text_field.dart';
import './widgets/forgot_password_modal.dart';
import './widgets/password_text_field.dart';
import './widgets/privacy_policy_and_terms_of_use.dart';
import './widgets/textual_or_divider.dart';
import '../../../core/presentation/res/utils/system_ui_overlay_style.dart';
import '../../home/presentation/home_screen.dart';
import '../business_logic/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _logInWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: getSystemUiOverlayStyle(theme, false),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go(HomeScreen.routeName);
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is PasswordReset) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email for password reset is sent.'),
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: mediaQuery.size.height - mediaQuery.padding.top,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 18.0,
                  right: 18.0,
                  left: 18.0,
                  bottom: 18.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome back',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  theme.textTheme.headlineMedium?.fontSize,
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return EmailTextField(
                                      emailController: _emailController,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                PasswordTextField(
                                  passwordController: _passwordController,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    _showForgotPasswordModalBottomSheet(
                                        context),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: theme.colorScheme.onBackground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _logInWithEmailAndPassword(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: state is Loading
                                      ? const SizedBox(
                                          width: 24.0,
                                          height: 24.0,
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text('Log In'),
                                ),
                              );
                            },
                          ),
                          ChangeBetweenAuthScreen(
                            text: 'Don\'t have an account?',
                            screenName: 'Sign up',
                            onPressed: () => context.go(SignUpScreen.routeName),
                          ),
                          const TextualORDivider(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _authenticateWithGoogle(context);
                              },
                              label: const Text('Continue with Google'),
                              icon: SvgPicture.asset(
                                'assets/icons/google-icon.svg',
                                width: 24.0,
                                height: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const PrivacyPolicyAndUserAgreementRichText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return const ForgotPasswordModal();
      },
    );
  }
}
