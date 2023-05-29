import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChangeBetweenAuthScreen extends StatelessWidget {
  final String text;
  final String screenName;
  final VoidCallback onPressed;

  const ChangeBetweenAuthScreen({
    Key? key,
    required this.text,
    required this.screenName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const TextSpan(
              text: '   ',
            ),
            TextSpan(
              text: screenName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()..onTap = onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
