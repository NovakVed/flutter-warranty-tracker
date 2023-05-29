import 'package:flutter/material.dart';

import '../pick_file_to_add.dart';

class AddReceiptStepContent extends StatefulWidget {
  const AddReceiptStepContent({Key? key}) : super(key: key);

  @override
  State<AddReceiptStepContent> createState() => _AddReceiptStepContentState();
}

class _AddReceiptStepContentState extends State<AddReceiptStepContent> {
  void _showPickFileToAddModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return const PickFileToAddModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () => _showPickFileToAddModalBottomSheet(context),
              child: Ink(
                padding: const EdgeInsets.all(36.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(Icons.add_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
