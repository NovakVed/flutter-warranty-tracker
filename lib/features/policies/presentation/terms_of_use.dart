import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsOfUse extends StatelessWidget {
  static const routeName = '/terms-of-use';

  const TermsOfUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms Of Use'),
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
