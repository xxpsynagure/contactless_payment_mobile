import 'dart:async';

import 'package:contactless_payment_mobile/Screens/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:contactless_payment_mobile/utils/styles.dart';
import 'package:contactless_payment_mobile/widgets/animated_title.dart';
import '../../../utils/data.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late final UserFirestoreService _userService;
  late Timer _timer;
  late List<dynamic> transactionList = User.transactions;

  @override
  void initState() {
    super.initState();
    _userService = UserFirestoreService();
    transactionList = User.transactions;
    _timer = Timer.periodic(Duration(seconds: 5), (timer) { 
      setState((){
        _userService.loadUserTransactions();
        transactionList = User.transactions;
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
    //   future: _userService.loadUserTransactions(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Scaffold(
    //         body: Center(child: CircularProgressIndicator()),
    //       );
    //     } else {
    return SafeArea(
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Transaction History 💳',
        textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Styles.blackColor,
            height: 1
          ),
        ),
        SizedBox(height: defaultPadding*3),
        Expanded(
          child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
         child: Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Date and Time'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Amount'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Type'),
              ),
            ),
          ],
        ),
        for (var record in transactionList)
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(record['time_stamp'].toString()),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(record['amount']),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(record['type']),
                ),
              ),
            ],
          ),
      ],
),
        ),
        ),
        SizedBox(height: defaultPadding*2),
    ],  
    ),
    ),
    ),
    );
    //   }
    //   },
    // );
    
  }
  }

