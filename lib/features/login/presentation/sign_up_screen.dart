import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import './login_screen.dart';
import './widgets/change_between_auth_screen.dart';
import './widgets/email_text_field.dart';
import './widgets/name_text_field.dart';
import './widgets/password_text_field.dart';
import './widgets/privacy_policy_and_terms_of_use.dart';
import './widgets/textual_or_divider.dart';
import '../../../core/presentation/res/utils/system_ui_overlay_style.dart';
import '../../home/presentation/home_screen.dart';
import '../business_logic/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-in';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUpWithNameEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(_emailController.text, _passwordController.text,
            _nameController.text),
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
                            'Create your account',
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
                                NameTextField(
                                  nameController: _nameController,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                EmailTextField(
                                  emailController: _emailController,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                PasswordTextField(
                                  passwordController: _passwordController,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _signUpWithNameEmailAndPassword(context);
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
                                      : const Text('Sign up'),
                                ),
                              );
                            },
                          ),
                          ChangeBetweenAuthScreen(
                            text: 'Already have an account?',
                            screenName: 'Log in',
                            onPressed: () => context.go(LoginScreen.routeName),
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
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
