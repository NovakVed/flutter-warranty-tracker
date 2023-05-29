import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/auth_bloc.dart';
import '../../business_logic/obscure_text_cubit.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordTextField({
    super.key,
    required this.passwordController,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final obscureTextCubit = ObscureTextCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String? errorMessage;
        if (state is UnAuthenticated) {
          if (state.errorCode == ErrorCode.password &&
              widget.passwordController.text.isNotEmpty) {
            errorMessage = state.errorMessage;
          }
        }
        return BlocBuilder<ObscureTextCubit, bool>(
          bloc: obscureTextCubit,
          builder: (context, state) {
            return TextFormField(
              keyboardType: TextInputType.text,
              controller: widget.passwordController,
              obscureText: state,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                label: const Text('Password'),
                errorText: errorMessage,
                suffixIcon: IconButton(
                  icon: Icon(
                    state
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    obscureTextCubit.changeObscureText(!state);
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return value != null && value.length < 6
                    ? "Enter min. 6 characters"
                    : null;
              },
            );
          },
        );
      },
    );
  }
}
