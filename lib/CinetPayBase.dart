library;

import 'dart:math';

import 'package:cinetpay/cinetpay.dart';
import 'package:flutter/material.dart';
import 'package:payment_base/payment_base.dart';

bool? payment = false;

class CinetPay implements PaymentBase {
  /// Payment method key
  ///
  static const key = "razorpay";

  @override
  String get libraryName => "razorpay_gateway";

  @override
  String get logoPath => "assets/images/razorpay.png";

  @override
  Future<void> initialized({
    required BuildContext context,
    required RouteTransitionsBuilder slideTransition,
    required Future<dynamic> Function(List<dynamic>) checkout,
    required Function(dynamic data) callback,
    required String amount,
    required String currency,
    required Map<String, dynamic> billing,
    required Map<String, dynamic> settings,
    required Future<dynamic> Function({String? cartKey, required Map<String, dynamic> data}) progressServer,
    required String cartId,
    required Widget Function(String url, BuildContext context, {String Function(String url)? customHandle})
        webViewGateway,
  }) async {
    try {
      if (amount.isEmpty) {
        // Mettre une alerte
        return;
      }
      double amount0;
      try {
        amount0 = double.parse(amount);

        if (amount0 < 100) {
          // Mettre une alerte
          //callback('');
          callback(PaymentException(error: "Amount must be greater than 100"));
          Navigator.pop(context);
          return;
        }

        if (amount0 > 1500000) {
          // callback('Amount must be less then than 1500000');
          callback(PaymentException(error: "Amount must be less then than 1500000"));
          Navigator.pop(context);
          // Mettre une alerte
          return;
        }
      } catch (exception) {
        return;
      }

      //   amountController.clear();

      final String transactionId = Random().nextInt(100000000).toString();
      dynamic result = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => CinetPayCheckout(
              title: 'Payment Checkout',
              titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              titleBackgroundColor: Colors.green,
              configData: <String, dynamic>{
                'apikey': '13517083862ddefdd586c31.27475055',
                'site_id': int.parse("975017"),
                'notify_url': 'https://www.facebook.com/'
              },
              paymentData: <String, dynamic>{
                'transaction_id': transactionId,
                'amount': amount,
                'currency': 'XAF',
                'channels': 'ALL',
                'description': 'Payment test',
              },
              waitResponse: (data) {
                if (data['status'] == 'ACCEPTED') {
                  payment = true;
                } else {
                  if (data['status'] == 'REFUSED') {
                    //callback('Payment Failled');
                    callback(PaymentException(error: "Payment Failed"));
                    Navigator.pop(context);
                  }
                }
                print('here  CinetPay$data');
              },
              onError: (data) {
                // if (mounted) {
                print('here is CinetPay $data');

                callback('Payment Failled');
                Navigator.pop(context);
                // }
              },
            ),
          ));

      if (payment == true) {
        final checkoutData = await checkout([]);
        int orderId = checkoutData["order_id"];
        payment = false;
        callback({
          'redirect': result['redirect'],
          'order_received_url': result['order_received_url'],
        });
      }
    } catch (e) {
      callback(e);
    }
  }

  @override
  String getErrorMessage(Map<String, dynamic>? error) {
    if (error == null) {
      return 'Something wrong in checkout!';
    }

    if (error['message'] != null) {
      return error['message'];
    }

    return 'Error!';
  }
}
