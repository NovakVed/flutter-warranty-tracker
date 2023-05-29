import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicy extends StatelessWidget {
  static const routeName = '/privacy-policy';

  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: const Placeholder(),
    );
  }
}
