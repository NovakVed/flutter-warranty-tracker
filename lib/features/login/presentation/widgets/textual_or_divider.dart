import 'package:flutter/material.dart';

class TextualORDivider extends StatelessWidget {
  const TextualORDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(flex: 3, child: Divider()),
          Flexible(
            flex: 1,
            child: Text(
              'OR',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Flexible(flex: 3, child: Divider()),
        ],
      ),
    );
  }
}
