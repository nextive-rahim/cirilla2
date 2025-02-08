import 'dart:math';

import 'package:cinetpay/cinetpay.dart';
import 'package:flutter/material.dart';

import 'CinetPayBase.dart';

class MyAppPay extends StatefulWidget {
  final String amount;
  const MyAppPay(this.amount, {super.key});

  @override
  _MyAppPayState createState() => _MyAppPayState();
}

class _MyAppPayState extends State<MyAppPay> {
  TextEditingController amountController = TextEditingController();
  Map<String, dynamic>? response;
  Color? color;
  IconData? icon;
  String? message;
  bool show = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'CinetPay Demo';
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
              child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              show ? Icon(icon, color: color, size: 150) : Container(),
              //  show ? Text(message!) : Container(),
              show ? const SizedBox(height: 50.0) : Container(),
              const SizedBox(height: 50.0),
              Text(
                "Cart informations.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 50.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.symmetric(horizontal: 50.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.green),
                ),
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    hintText: "Amount",
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                child: const Text("Pay with CinetPay"),
                onPressed: () async {
                  String amount = amountController.text;
                  if (amount.isEmpty) {
                    // Mettre une alerte
                    return;
                  }
                  double amount0;
                  try {
                    amount0 = double.parse(amount);

                    if (amount0 < 100) {
                      // Mettre une alerte
                      return;
                    }

                    if (amount0 > 1500000) {
                      // Mettre une alerte
                      return;
                    }
                  } catch (exception) {
                    return;
                  }

                  amountController.clear();

                  final String transactionId = Random()
                      .nextInt(100000000)
                      .toString(); // Mettre en place un endpoint à contacter côté serveur pour générer des ID unique dans votre BD

                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CinetPayCheckout(
                                title: 'Payment Checkout',
                                titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                titleBackgroundColor: Colors.green,
                                configData: <String, dynamic>{
                                  'apikey': '13517083862ddefdd586c31.27475055',
                                  'site_id': int.parse("975017"),
                                  'notify_url': 'https://www.afrosmartshop.cm/'
                                },
                                paymentData: <String, dynamic>{
                                  'transaction_id': transactionId,
                                  'amount': amount0,
                                  'currency': 'XAF',
                                  'channels': 'ALL',
                                  'description': 'Payment test',
                                },
                                waitResponse: (data) {
                                  if (mounted) {
                                    setState(() {
                                      payment = true;
                                      response = data;
                                      print(response);
                                      icon = data['status'] == 'ACCEPTED' ? Icons.check_circle : Icons.mood_bad_rounded;
                                      color = data['status'] == 'ACCEPTED' ? Colors.green : Colors.redAccent;
                                      show = true;
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                onError: (data) {
                                  if (mounted) {
                                    setState(() {
                                      response = data;
                                      message = response!['description'];
                                      print(response);
                                      icon = Icons.warning_rounded;
                                      color = Colors.yellowAccent;
                                      show = true;
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                              )));
                },
              )
            ],
          ),
        ],
      ))),
    );
  }
}
