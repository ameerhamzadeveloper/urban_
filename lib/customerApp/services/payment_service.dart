import 'package:flutter/cupertino.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StripeService {
  static String? paymentId;
  static String apiURL = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiURL}/payment_intents';
  static String secret = 'sk_test_51HmL50JgRTIAdsOfHHllCplppQPRt5i297xJFDn4mjxapdTuqwRpcnDLQfPzSgIO1Xm7DGPScSeaZ7fgwbpXTMpG00u00m0c3P'; //your secret from stripe dashboard
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
        StripeOptions(
          publishableKey:"pk_test_51HmL50JgRTIAdsOfL12aG7nwFoVXJE11KD1IQOvhkWNB86zGEvCFhyyUdotaTKe8fcoYndGmMKwFIgqMgDFzEDvK00UjVDGNvd", // user your api key
          merchantId: "merchant.themetismarkeetplace",
          androidPayMode: 'test',
        )
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency,BuildContext context) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount, // amount charged will be specified when the method is called
        'currency': currency, // the currency
        'payment_method_types[]': 'card' //card
      };
      var response =
      await http.post(
          Uri.parse(paymentApiUrl),
          body: body,  //request body
          headers: StripeService.headers //headers of the request specified in the base class
      );
      var de = json.decode(response.body);
      print(de['id']);
      paymentId = de['id'];
      return jsonDecode(response.body); //decode the response to json
    } catch (error) {
      print('Error occured : ${error.toString()}');
    }
    var ret = {"payment" : "succed"};
    return ret;
  }
}
