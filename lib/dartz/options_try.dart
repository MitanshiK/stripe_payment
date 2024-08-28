
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
class OptionAndTry extends StatelessWidget {
   OptionAndTry({super.key ,required this.getText});

   final Option<String> getText;
  @override
  Widget build(BuildContext context) {
     TextEditingController result1Controller=TextEditingController();
     TextEditingController result2Controller=TextEditingController();
     TextEditingController divideController=TextEditingController();

    Option<int> num1=const Some(22); // has a value 
    Option<int> num2=const None();   // has no value i.e null

    return Scaffold(
      appBar: AppBar(title: const Text(" Options and try"),),
      body: Container(
        height: 500,
        width: 500,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            getText.fold(
              ()=> const Text(" no value"), 
              (text)=>Text("returns $text")
              ),
            const SizedBox(height: 20,),

             Row(
              children: [
              ElevatedButton(onPressed: (){
              result1Controller.text= num1.getOrElse(()=> -1).toString();
              result2Controller.text=num2.getOrElse(()=> -1).toString();
              }
              ,child: const Text("GetOrElse"),),
              // result 1
              Expanded(
                flex: 2,
                child: TextField(
                  controller: result1Controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                  label: const Text("result1")
                  ),
                  enabled: false,
                ),
              )
              ,
                    // result 2
              Expanded(
                flex: 2,
                child: TextField(
                  controller: result2Controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                  label: Text("result2")
                  ),
                  enabled: false,
                ),
              )
            ],),
         SizedBox(height:  20,),

         Row(
              children: [
              ElevatedButton(onPressed: (){
              divideController.text=  divide(4,0).toString();
              }
              ,child: const Text("Either[divide]"),),
            
              Expanded(
                flex: 2,
                child: TextField(
                  controller:divideController ,
                  readOnly: true,
                  decoration: const InputDecoration(
                  label:  Text("Ans")
                  ),
                  enabled: false,
                ),
              )
            ],),
          ],
        ),
      ),
    );
  }

  Either<String,double> divide(double a,double b){
    if(b==0){
      return Left("cannot divide by zero");
    }
    else
     return Right(a/b);
  }
}