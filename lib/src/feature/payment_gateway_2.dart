// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// class PaymentGateway extends StatefulWidget {
//   const PaymentGateway({super.key});
//
//   @override
//   State<PaymentGateway> createState() => _PaymentGatewayState();
// }
//
// class _PaymentGatewayState extends State<PaymentGateway> {
//
//   Future<void> makePayment() async {
//     try {
//       //STEP 1: Create Payment Intent
//       paymentIntent = await createPaymentIntent('100', 'USD');
//
//       //STEP 2: Initialize Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//
//           paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret: paymentIntent![
//               'client_secret'], //Gotten from payment intent
//               style: ThemeMode.light,
//               merchantDisplayName: 'Ikay'))
//           .then((value) {});
//
//       //STEP 3: Display Payment sheet
//       displayPaymentSheet();
//     } catch (err) {
//       throw Exception(err);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
