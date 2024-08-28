import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future createPaymentintent({
  required name,
  required address,
  required  pin,
  required  city,
  required  country,
  required  state,
  required  currency,
  required  amount,
}) async{

final url=Uri.parse("https://api.stripe.com/v1/payment_intents");
final secretKey=dotenv.env["STRIPE_SECRET_KEY"]!;
 final body={
  "amount": amount,
  "currency":currency.toString().toLowerCase(),
  "automatic_payment_methods[enabled]":"true",
  "description":"Test donation",
  "shipping[name]":name,
  "shipping[address][line1]":address,
  "shipping[address][postal_code]":pin,
  "shipping[address][city]":city,
  "shipping[address][state]":state,
  "shipping[address][country]":country,
 };

 final response= await http.post(url,
 headers: {
  "Authorization":"Bearer $secretKey",
  "Content-type": "application/x-www-form-urlencoded"
 },
 body: body);
 if(response.statusCode==200 || response.statusCode==201 ){
  final json=jsonDecode(response.body);
  debugPrint(json);
  return json;
 }
 else{
  debugPrint("error in creating payment intent");
 }

}