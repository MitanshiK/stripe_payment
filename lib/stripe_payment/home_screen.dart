import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/stripe_payment/payment.dart';
import 'package:stripe_payment/stripe_payment/reusable_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  String selectedCurrency = "INR";

  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey6 = GlobalKey<FormState>();

  List<String> currencyList = ["INR", "EUR", "USD", "YEN", 'JPY', 'GBP', 'AED'];

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await createPaymentintent(
          name: nameController.text,
          address: addressController.text,
          pin: pincodeController.text,
          city: cityController.text,
          country: countryController.text,
          state: stateController.text,
          currency: selectedCurrency,
          amount: (int.parse(amountController.text) * 100).toString());

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Moon Store',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          // Extra options

          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Form"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage("assets/moonTower.gif"),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Donate Funds",
              style: TextStyle(
                  color: Color.fromARGB(255, 141, 193, 248),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height / 2,
                    maxWidth: MediaQuery.sizeOf(context).width),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ReusableField(
                              isNumber: true,
                              formKey: formKey,
                              title: "Donation amount",
                              hint: "Donation amount",
                              textController: amountController),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        DropdownMenu<String>(
                          inputDecorationTheme: const InputDecorationTheme(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          initialSelection: currencyList.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              selectedCurrency = value!;
                            });
                          },
                          dropdownMenuEntries: currencyList
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ReusableField(
                        formKey: formKey1,
                        title: "Name",
                        hint: "Name",
                        textController: nameController),
                    const SizedBox(
                      height: 8,
                    ),
                    ReusableField(
                        formKey: formKey2,
                        title: "Address",
                        hint: "Address",
                        textController: addressController),

                    const SizedBox(
                      height: 8,
                    ),
                    // city /state
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ReusableField(
                              formKey: formKey3,
                              title: "City",
                              hint: "City",
                              textController: cityController),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: ReusableField(
                              formKey: formKey4,
                              title: "State",
                              hint: "State",
                              textController: stateController),
                        ),
                      ],
                    ),
                    // country /pincode
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ReusableField(
                              formKey: formKey5,
                              title: "Countery code",
                              hint: "Countery code",
                              textController: countryController),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: ReusableField(
                              isNumber: true,
                              formKey: formKey6,
                              title: "Pin Code",
                              hint: "Pin Code",
                              textController: pincodeController),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(255, 141, 193, 248))),
                          onPressed: () async {
                            // if(
                            //   formKey.currentState!.validate() &&
                            //   formKey1.currentState!.validate() &&
                            //   formKey2.currentState!.validate() &&
                            //   formKey3.currentState!.validate() &&
                            //   formKey4.currentState!.validate() &&
                            //   formKey5.currentState!.validate() &&
                            //   formKey6.currentState!.validate() ){
                            await initPaymentSheet();
                            try {
                              Stripe.instance.presentPaymentSheet();
                              debugPrint("payment successful");
                            } catch (e) {
                              debugPrint("payment failed");
                            }

                            // }
                          },
                          child: const Text(
                            "Proceed",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
