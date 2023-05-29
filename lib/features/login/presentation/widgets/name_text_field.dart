import 'package:flutter/material.dart';

class NameTextField extends StatefulWidget {
  final TextEditingController nameController;

  const NameTextField({Key? key, required this.nameController})
      : super(key: key);

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  late TextEditingController _textEditingController;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.nameController;
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
    return TextFormField(
      controller: _textEditingController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        suffixIcon: _showClearButton
            ? IconButton(
                onPressed: _clearTextField, icon: const Icon(Icons.clear))
            : null,
        label: const Text('Name'),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      // validator: (value) {
      //   // TODO add regex for username
      //   return value != null ? 'Enter your name' : null;
      // },
    );
  }
}
