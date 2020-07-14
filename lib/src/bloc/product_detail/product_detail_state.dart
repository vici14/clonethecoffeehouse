import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/entities.dart';

enum Size { SMALL, MEDIUM, LARGE }
enum Topping { NONE, TRANCHAUTRANG }

class ProductDetailState extends BaseState {
  final ProductEntity product;
  int quantity;
  int sizeCost;
  int toppingCost;
  bool isActive;
  int selectedSizeIndex;

  ProductDetailState({
    ProductEntity product,
    ProductDetailState state,
    int sizeCost,
    int toppingCost,
    int quantity,
    int selectedSizeIndex,
    bool isActive,
  })  : isActive = isActive ?? state.isActive,
        selectedSizeIndex = selectedSizeIndex ?? state.selectedSizeIndex,
        product = product ?? state?.product,
        sizeCost = sizeCost ?? state?.sizeCost,
        toppingCost = toppingCost ?? state?.toppingCost,
        quantity = quantity ?? state.quantity,
        super(
          timeStamp: DateTime.now().millisecondsSinceEpoch,
        );
}
