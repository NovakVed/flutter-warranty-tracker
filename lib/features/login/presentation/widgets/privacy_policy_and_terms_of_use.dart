import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../policies/presentation/privacy_policy.dart';
import '../../../policies/presentation/terms_of_use.dart';

class PrivacyPolicyAndUserAgreementRichText extends StatelessWidget {
  const PrivacyPolicyAndUserAgreementRichText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Terms of use',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.go(TermsOfUse.routeName),
          ),
          TextSpan(
            text: '   |   ',
            style: TextStyle(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
            ),
          ),
          TextSpan(
            text: 'Privacy policy',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => context.go(PrivacyPolicy.routeName),
          ),
        ],
      ),
    );
  }
}
