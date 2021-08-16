import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:urban/customerApp/services/payment_response.dart';
import 'package:urban/customerApp/services/payment_service.dart';

class StripeCharge{
  static Future<StripeTransactionResponse> addNewCard(BuildContext context,String amount, String currency) async {
    print("called");
    try {
      print("requestiong Car");
      var stripePaymentMethod = await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest(),);
      print("requestiong int");
      var stripePaymentIntent = await StripeService.createPaymentIntent(amount, currency,context);
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(clientSecret: stripePaymentIntent['client_secret'], paymentMethodId: stripePaymentMethod.id));

      if (response.status == 'succeeded') {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentInvoice()));//if the payment process success
        return new StripeTransactionResponse(
            message: 'Transaction successful',
            success: true
        );
      }else { //payment process fail
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } catch (error) {
      return new StripeTransactionResponse(
        //convert the error to string and assign to message variable
          message: 'Transaction failed: ${error.toString()}',
          success: false
      );
    }
  }


}