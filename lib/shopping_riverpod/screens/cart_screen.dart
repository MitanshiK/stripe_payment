import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stripe_payment/shopping_riverpod/providers/cart_items_notifier.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
 final cartItems=ref.watch(cartItemsNotifierProvider);

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Cart"),
       backgroundColor: Colors.white,),
       body:    Column(
              children:cartItems.map((e) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: ListTile(
                trailing: Stack(
                  clipBehavior: Clip.none,
                children: [
                  Image(
                    image: NetworkImage(e.thumbnail!),
                    width: 120,
                    height: 120,
                  )
                  ,Positioned(
                    right: -15,
                    top: -25,
                    child: IconButton(
                      onPressed: (){
                    ref.read(cartItemsNotifierProvider.notifier).removeItem(e);
                    }, icon: const Icon(Icons.close)),
                  )
                ]),
                title: Text(e.title!),
                subtitle: Text("\$"  " ${e.price}"),
              ),
            ),
          ],
        );
      }).toList()
            ), 
    );
  }
}