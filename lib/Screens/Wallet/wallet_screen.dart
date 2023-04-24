import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  @override
  void initState() {
    super.initState();
    _integration.intiateRazorPay();
    _userService = UserFirestoreService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userService.loadUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('My Widget')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          final user = snapshot.data;
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
        SizedBox(height: defaultPadding),
        Text('Your Balance: Rs. ${user?.wallet ?? 'loading...'}',
        textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Styles.blackColor,
            height: 1
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        const AnimatedTitle(title: 'Refill Wallet'), 
        SizedBox(height: defaultPadding),
        
      FloatingActionButton(
        onPressed: () {
          _integration.openSession(amount: 100);
        },
        tooltip: 'Razorpay',
        child: const Icon(Icons.add),
      ),
      ],  
    )
    ),
    );
        }
      },
    );
  }
}