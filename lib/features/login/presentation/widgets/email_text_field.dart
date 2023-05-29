import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/auth_bloc.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController emailController;

  const EmailTextField({Key? key, required this.emailController})
      : super(key: key);

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  late TextEditingController _textEditingController;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.emailController;
    _textEditingController.addListener(_updateClearButtonVisibility);
  }

  void _updateClearButtonVisibility() {
    setState(() {
      _showClearButton = _textEditingController.text.isNotEmpty;
    });
  }

  void _clearTextField() {
    setState(() {
      _textEditingController.clear();
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String? errorMessage;
        if (state is UnAuthenticated) {
          if (state.errorCode == ErrorCode.email &&
              widget.emailController.text.isNotEmpty) {
            errorMessage = state.errorMessage;
          }
        }
        return TextFormField(
          controller: _textEditingController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            suffixIcon: _showClearButton
                ? IconButton(
                    onPressed: _clearTextField, icon: const Icon(Icons.clear))
                : null,
            label: const Text('Email'),
            errorText: errorMessage,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          textInputAction: TextInputAction.next,
          validator: (value) {
            return value != null && !EmailValidator.validate(value)
                ? 'Enter a valid email'
                : null;
          },
        );
      },
    );
  }
}
