import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/custom_paint/draw_circle.dart';
import 'package:stripe_payment/dartz/send_data_btn.dart';
import 'package:stripe_payment/shopping_riverpod/screens/Shopping_home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 try{
   await dotenv.load(fileName: ".env");       // for dotenv file
  Stripe.publishableKey=dotenv.env["STRIPE_PUBLISH_KEY"]!;     //to get publish key
  debugPrint("publishKey is ${Stripe.publishableKey}");
  }catch(e){
    debugPrint(" could not get publsh key");
  }
 Stripe.instance.applySettings();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  DrawCircle(),
    );
  }
}
