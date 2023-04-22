import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:contactless_payment_mobile/Screens/Wallet/wallet_screen.dart';
import '../../../utils/styles.dart';
import '../../../utils/layouts.dart';
import '../../../utils/data.dart';


class Wallet_card extends StatelessWidget {
  const Wallet_card({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: InkWell(
        onTap: () {
           Navigator.push(
              context, MaterialPageRoute(builder: (_) => const WalletScreen())); 
        }, 
        child:
          TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, _) {
              return Stack(
                children: [
                  Container(
                    height: 150,
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Container(
                          height: 135,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Styles.bgColor,
                              borderRadius: BorderRadius.circular(27)),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                              right: 15,
                              left: Layouts.getSize(context).width * 0.4,
                              top: 15,
                              bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wallet',
                                style: TextStyle(
                                    fontSize: value*27,
                                    fontWeight: FontWeight.bold,
                                    color: Styles.blackColor,
                                    height: 1),
                              ),
                              SizedBox(height: defaultPadding),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 1500),
                                opacity: value,
                                child: Text(
                                  'Balance: Rs. $balance',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Styles.blackColor,
                                      fontSize: 16),
                                ),
                              ),
                              if(balance<100) AnimatedOpacity(
                                duration: const Duration(milliseconds: 1500),
                                opacity: value,
                                child: Text(
                                  'Your balance is too low, try adding more!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Styles.blackColor,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: value*12,
                          top: value*12,
                          child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Styles.bgWithOpacityColor,
                              child: SvgPicture.asset(
                                'assets/icons/arrow_right.svg',
                                height: value*14,
                                width: value*14,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 0,
                    child: SvgPicture.asset(
                      'assets/icons/signup.svg',
                      height: value*150,
                    ),
                  ),
                ],
              );
            }
          ),
          ),
    
    );
       
  }
}