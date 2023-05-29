import 'package:bloc/bloc.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductState(productName: ''));

  void changeProductName(value) {
    emit(AddProductState(productName: value));
  }
}
