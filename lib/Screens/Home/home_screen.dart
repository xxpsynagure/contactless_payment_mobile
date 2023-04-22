import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:contactless_payment_mobile/utils/styles.dart';
import 'package:contactless_payment_mobile/widgets/animated_title.dart';
import './components/wallet_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: defaultPadding *2),
              Text('Contactless Payment 🛒',
                style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Styles.blackColor,
                height: 1
                ),  
              ),
        SizedBox(height: 35),
        const AnimatedTitle(title: 'Your Wallet'), 
        SizedBox(height: 10),
        const Wallet_card(), 
      ],
    ),
          )
          
          
        ),
        

    );
    
  }

}