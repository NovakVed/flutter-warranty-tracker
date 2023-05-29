import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_warranty_tracker/core/presentation/res/utils/system_ui_overlay_style.dart';
import 'package:flutter_warranty_tracker/features/article/business_logic/add_product_cubit.dart';
import 'package:flutter_warranty_tracker/features/article/presentation/widgets/stepper_content/add_receipt_step_content.dart';
import 'package:flutter_warranty_tracker/features/article/presentation/widgets/stepper_content/warranty_details_notification_step_content.dart';

import 'widgets/stepper_content/product_name_step_content.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = 'add-product';

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        systemOverlayStyle: getSystemUiOverlayStyle(Theme.of(context), false),
      ),
      body: BlocProvider(
        create: (context) => AddProductCubit(),
        child: Stepper(
          currentStep: _currentStep,
          onStepTapped: (value) => setState(() {
            _currentStep = value;
          }),
          onStepContinue: () {
            if (_currentStep != 4) {
              setState(() {
                _currentStep++;
              });
            }
          },
          onStepCancel: () {
            if (_currentStep != 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            Step(
              isActive: _currentStep >= 0,
              title: const Text('Product Name'),
              content: const ProductNameStepContent(),
            ),
            Step(
              isActive: _currentStep >= 1,
              title: const Text('Add Receipt'),
              content: const AddReceiptStepContent(),
            ),
            Step(
                isActive: _currentStep >= 2,
                title: const Text('Warranty Details & Notification'),
                content: const WarrantyDetailsNotificationStepContent()),
            Step(
              isActive: _currentStep >= 3,
              title: const Text('Select Category'),
              content: Column(
                children: [Text('data')],
              ),
            ),
            Step(
              isActive: _currentStep >= 4,
              title: const Text('Other'),
              subtitle: const Text(
                  'Product Info, Product Images, Merchant Detail and Note'),
              content: Column(
                children: [Text('data')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
