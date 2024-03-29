import 'package:contactless_payment_mobile/Screens/History/transactions.dart';
import 'package:flutter/material.dart';
import 'package:contactless_payment_mobile/theme/color.dart';
import 'package:contactless_payment_mobile/utils/constant.dart';
import 'package:contactless_payment_mobile/Screens/Home/components/bottombar_item.dart';
import 'package:contactless_payment_mobile/Screens/Home/home_screen.dart';
import 'package:contactless_payment_mobile/Screens/Wallet/wallet_screen.dart';
import 'package:contactless_payment_mobile/Screens/Settings/settings_screen.dart';
import 'package:contactless_payment_mobile/utils/data.dart';
class RootApp extends StatefulWidget {
  const RootApp({ Key? key }) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp>  with TickerProviderStateMixin {
  int activeTab = 0;
  late final UserFirestoreService _userService;

  List barItems = [
    {
      "icon" : "assets/icons/home-border.svg",
      "active_icon" : "assets/icons/home.svg",
      "page" : const Home(),
      "title" : ""
    },
    {
      "icon" : "assets/icons/wallet.svg",
      "active_icon" : "assets/icons/wallet.svg",
      "page" : const WalletScreen(),
      "title" : ""
    },
    {
      "icon" : "assets/icons/history.svg",
      "active_icon" : "assets/icons/history.svg",
      "page" : const TransactionScreen(),
      "title" : ""
    },
    {
      "icon" : "assets/icons/setting-border.svg",
      "active_icon" : "assets/icons/setting.svg",
      "page" : const SettingsScreen(),
      "title" : "",
    }, 
  ];
//====== set animation=====
   late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _userService = UserFirestoreService();
     _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page){
    return FadeTransition(
      child: page,
      opacity: _animation
    );
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      activeTab = index;
      _userService.loadUserWallet();
      _userService.loadUserTransactions();
    });
    _controller.forward();
  }
 
//====== end set animation=====
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: getBarPage(),
      // bottomNavigationBar: getBottomBar1()
      floatingActionButton: getBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget getBarPage(){
    return 
      IndexedStack(
        index: activeTab,
        children: 
          List.generate(barItems.length, 
            (index) => animatedPage(barItems[index]["page"])
          )
      );
  }
 
  Widget getBottomBar() {
    return Container(
      height: 55, width: double.infinity,
      margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
        color: bottomBarColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: 
          List.generate(barItems.length, 
            (index) => BottomBarItem( activeTab == index ? barItems[index]["active_icon"] : barItems[index]["icon"], "", isActive: activeTab == index, activeColor: primary,
              onTap: (){
                onPageChanged(index);
              },
            )
          )
        ),
    );
  }
}