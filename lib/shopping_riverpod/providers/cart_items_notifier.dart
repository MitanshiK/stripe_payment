
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stripe_payment/shopping_riverpod/providers/shopping_model.dart';

// notifier class
class CartItemsNotifier extends Notifier<Set<ProductsModel>>{
  @override
  Set<ProductsModel> build() {
    return const{};
  }

  void addItem(ProductsModel item){
    if(!state.contains(item)){
      state={...state,item};
    }
  }

  void removeItem(ProductsModel item){
     if(state.contains(item)){            // check if state contains the product
    state=state.where((e)=> e.id !=item.id).toSet();  // keep all products except the one with provided id
  }
  }

  void blahBlah(ProductsModel item){
    if (state.contains(item)) {state={...state,state.first};} 
    else {state={...state,item}; }
  }

}

// provider
final cartItemsNotifierProvider=NotifierProvider<CartItemsNotifier,Set<ProductsModel>>((){
  return CartItemsNotifier();
});