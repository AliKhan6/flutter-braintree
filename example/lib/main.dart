import 'package:flutter/material.dart';

import 'package:braintree/braintree.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Braintree example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  setState(() {
                    _text = 'Waiting for payment...';
                  });
                  BraintreeDropInResult result = await BraintreeDropIn.launch(
                    clientToken: '<INSERT YOUR CLIENT TOKEN HERE>',
                    collectDeviceData: true,
                  );
                  setState(() {
                    if (result == null) {
                      _text = 'Payment canceled';
                    } else {
                      _text = 'Nonce: ${result.paymentMethodNonce.nonce}\n'
                          'Nonce label: ${result.paymentMethodNonce.typeLabel}\n'
                          'Nonce description: ${result.paymentMethodNonce.description}\n'
                          'Device data: ${result.deviceData}';
                    }
                  });
                },
                child: Text('Pay now!'),
              ),
              SizedBox(height: 8.0),
              Text(_text),
            ],
          ),
        ),
      ),
    );
  }
}
