import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_warranty_tracker/features/article/business_logic/add_product_cubit.dart';

class ProductNameStepContent extends StatefulWidget {
  const ProductNameStepContent({Key? key}) : super(key: key);

  @override
  State<ProductNameStepContent> createState() => _ProductNameStepContentState();
}

class _ProductNameStepContentState extends State<ProductNameStepContent> {
  final TextEditingController _textEditingController = TextEditingController();
  final addProductCubit = AddProductCubit();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      BlocProvider.of<AddProductCubit>(context)
          .changeProductName(_textEditingController.text);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _clearTextField() {
    _textEditingController.clear();
    addProductCubit.changeProductName('');
  }

  // TODO add bloc / divide business logic from presentation layer
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<AddProductCubit, AddProductState>(
        bloc: addProductCubit,
        builder: (context, state) {
          print("show product in widget: ${state.productName}");
          return TextFormField(
            controller: _textEditingController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              icon: const Icon(Icons.sell_outlined),
              suffixIcon: state.productName.isNotEmpty
                  ? IconButton(
                      onPressed: _clearTextField,
                      icon: const Icon(Icons.clear),
                    )
                  : null,
              label: const Text('Product Name'),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              return value != null && value.isNotEmpty && value.length > 100
                  ? 'Enter Product Name'
                  : null;
            },
          );
        },
      ),
    );
  }
}
