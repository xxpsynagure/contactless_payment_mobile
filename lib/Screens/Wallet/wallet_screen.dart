import 'dart:async';
import 'package:contactless_payment_mobile/Screens/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:contactless_payment_mobile/Screens/Wallet/razorpay.dart';
import 'package:contactless_payment_mobile/utils/styles.dart';
import 'package:contactless_payment_mobile/widgets/animated_title.dart';
import '../../../utils/data.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final RazorPayIntegration _integration = RazorPayIntegration();
  late final UserFirestoreService _userService;
  TextEditingController amountController = TextEditingController();
  num amount = 100;
  late Timer _timer;
  late double? wallet = User.wallet;

  @override
  void initState() {
    super.initState();
    _integration.intiateRazorPay();
    _userService = UserFirestoreService();
    wallet = User.wallet;
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _userService.loadUserWallet();
        wallet = User.wallet;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<void>(
    //   future: _userService.loadUserWallet(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Scaffold(
    //         body: Center(child: CircularProgressIndicator()),
    //       );
    //     } else {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Contactless Payment Wallet 👛',
        textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Styles.blackColor,
            height: 1
          ),
        ),
        SizedBox(height: defaultPadding*4),
        Text('Your Balance: Rs. ${wallet ?? 'loading...'}',
        textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Styles.blackColor,
            height: 1
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        const AnimatedTitle(title: 'Refill Wallet'), 
        SizedBox(height: defaultPadding),

  
      Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: amountController,
            onSaved: (amount) {},
            // validator: MultiValidator([
            //   RequiredValidator(errorText: "* Required"),
            // ]),
            decoration: InputDecoration(
              hintText: "Amount in Rs.",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.money),
              ),
            ),
          ),
      ),
    Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: FloatingActionButton(
        onPressed: () {
          if(amountController.text != "") {
          amount = num.tryParse(amountController.text.trim())!;
          }
          _integration.openSession(amount: amount);
            
        },
        tooltip: 'Razorpay',
        child: const Icon(Icons.add),
      ),
      ),
  
  ],
),
      
    ),
    );
        // }
//       },
//     );
  }
}