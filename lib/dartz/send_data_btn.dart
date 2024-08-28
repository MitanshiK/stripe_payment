import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' ;
import 'package:stripe_payment/dartz/options_try.dart';

class SendDataBtn extends StatelessWidget {
  const SendDataBtn({super.key});

  @override
  Widget build(BuildContext context) {
 Option<String> String1=const Some("hello");
    return  Scaffold(
      appBar: AppBar(title: Text("Dartz"),),
      body: Center(child: 
      Column(
        children: [
          TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> OptionAndTry(getText: String1)));
          }, child: Text("Option and Try"))
        ],
      ),)
    );
  }
}