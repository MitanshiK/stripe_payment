import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stripe_payment/shopping_riverpod/providers/cart_items_notifier.dart';
import 'package:stripe_payment/shopping_riverpod/screens/cart_screen.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    int cartItem=ref.watch(cartItemsNotifierProvider).length;
    return GestureDetector(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartScreen()));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child:  Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
              size: 30,
            ),
            Positioned(
              top: -5,
              left: -5,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.blue,
                child: Text(cartItem.toString() ,style: const TextStyle(color: Colors.white,fontSize: 12),),
              ),
            )
          ],
        ),
      ),
    );
  }
}