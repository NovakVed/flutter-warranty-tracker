import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/auth_bloc.dart';
import 'email_text_field.dart';

class ForgotPasswordModal extends StatefulWidget {
  const ForgotPasswordModal({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordModal> createState() => _ForgotPasswordModalState();
}

class _ForgotPasswordModalState extends State<ForgotPasswordModal> {
  final TextEditingController _forgotPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _forgotPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 40.0,
        right: 18.0,
        left: 18.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Forgot your password?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 12.0,
              bottom: 24.0,
            ),
            child: Text(
              'Enter your email address and we will share a link to create a new password',
              textAlign: TextAlign.center,
            ),
          ),
          EmailTextField(
            emailController: _forgotPasswordController,
          ),
          const SizedBox(
            height: 12.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  ForgotPassword(_forgotPasswordController.text),
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.send),
              label: const Text('Send'),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
