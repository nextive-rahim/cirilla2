import 'package:cirilla/screens/checkout/gateway/gateway.dart';
// import 'package:flutterwave_gateway/flutterwave_gateway.dart';
import 'package:payment_base/payment_base.dart';
import 'package:stripe_gateway/stripe_gateway_native.dart';
import 'package:cirilla/utils/currency_format.dart';
import 'package:wallet_gateway/wallet_gateway.dart';
import 'CinetPayBase.dart';
import 'service/constants/endpoints.dart';
import 'dart:io' show Platform;

final Map<String, PaymentBase> methods = {
  ChequeGateway.key: ChequeGateway(),
  CodGateway.key: CodGateway(),
  BacsGateway.key: BacsGateway(),
  StripeGatewayNative.key: StripeGatewayNative(),
  //StripeGatewayWeb.key: StripeGatewayWeb(),
  WalletGateway.key: WalletGateway(
    restUrl: Endpoints.restUrl,
    consumerKey: Endpoints.consumerKey,
    consumerSecret: Endpoints.consumerSecret,
    formatCurrency: formatCurrency,
  ),

  /// Hide #cinetpay only on ios platform
  if (Platform.isAndroid) CinetPay.key: CinetPay(),

  // FlutterwaveGateway.key: FlutterwaveGateway(encryptionKey: "FLWSECK_TEST2152f818b3b4"),
};
