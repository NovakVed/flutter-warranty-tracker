import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WarrantyDetailsNotificationStepContent extends StatefulWidget {
  const WarrantyDetailsNotificationStepContent({Key? key}) : super(key: key);

  @override
  State<WarrantyDetailsNotificationStepContent> createState() =>
      _WarrantyDetailsNotificationStepContentState();
}

class _WarrantyDetailsNotificationStepContentState
    extends State<WarrantyDetailsNotificationStepContent> {
  final TextEditingController _dateTextEditingController =
      TextEditingController();
  bool _showClearButton = false;

  //text editing controller for text field

  @override
  void initState() {
    super.initState();
    _dateTextEditingController.addListener(_updateClearButtonVisibility);
  }

  void _updateClearButtonVisibility() {
    setState(() {
      _showClearButton = _dateTextEditingController.text.isNotEmpty;
    });
  }

  void _clearTextField() {
    setState(() {
      _dateTextEditingController.clear();
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _dateTextEditingController,
        decoration: InputDecoration(
          icon: const Icon(Icons.calendar_today),
          suffixIcon: _showClearButton
              ? IconButton(
                  onPressed: _clearTextField, icon: const Icon(Icons.clear))
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          // prefixIcon: const Icon(Icons.calendar_today),
          labelText: 'Date of Purchase',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              _dateTextEditingController.text =
                  formattedDate; //set output date to TextField value.
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }
}
