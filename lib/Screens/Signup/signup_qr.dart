import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './signup_screen.dart';
import 'components/sign_up_top_image.dart';
import '../../utils/styles.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../Login/login_screen.dart';




class SignUpQR extends StatefulWidget {
  const SignUpQR({Key? key}) : super(key: key);

  @override 
  State<StatefulWidget> createState() => _SignUpQRState();
}

var status = 'Scan QR Code';
late Response response;
var dio = Dio();
var data = '';

Future CheckCode(qrdata) async {
  try {
    data = qrdata;
    data = data.split(': ')[1];

    // var param = {
    //   "palm_id" : "$data",
    // };
    //   //api link
    // response = await dio.post(
    //   'https://api.contactlesspayment.in/veryfypalm/',
    //   options: Options(
    //     headers: {
    //       HttpHeaders.contentTypeHeader: "application/json",
    //     }
    //   ),
    //   data: jsonEncode(param),
    // );

    // if (response.statusCode == 200) 
    if(data != '')
    {
      qrCode.value = 'Success';
      Future.delayed(Duration(seconds: 4), () {
        qrCode.value = 'Scan QR Code';
      });
      return;
    }
    else{
      qrCode.value = 'Invalid QR Code';
      Future.delayed(Duration(seconds: 4), () {
        qrCode.value = 'Scan Qr Code';
      });
      return;
    }
    } on SocketException catch (_) {
    qrCode.value = 'No Internet Connection';
    throw Exception('No Internet Connection');
  } on Exception catch (e) {
    qrCode.value = 'Invalid QR Code';
    Future.delayed(Duration(seconds: 4), () {
      qrCode.value = 'Scan Qr Code';
    });
    qrCode.value = 'Invalid QR Code';
    Future.delayed(Duration(seconds: 4), () {
      qrCode.value = 'Scan Qr Code';
    });
    throw Exception('Invalid QR Code');
  }
}

ValueNotifier qrCode = ValueNotifier('Scan Qr Code');

class _SignUpQRState extends State<SignUpQR> {
  @override
  void initState() {
    qrCode.value = 'Scan Qr Code';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SignUpScreenTopImage(),
            // const Text(
            //       'Scan Result',
            //       style: TextStyle(
            //         fontSize: 16,
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //       ),
            // ),
            const SizedBox(height: defaultPadding * 2),
            ValueListenableBuilder(
                  valueListenable: qrCode,
                  builder: (context, value, child) => Text(
                    qrCode.value.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: qrCode.value == 'Success'
                          ? Colors.green
                          : qrCode.value == 'Scan Qr Code'
                              ? Colors.black
                              : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            const SizedBox(height: defaultPadding *2),
            GestureDetector(
              onTap: () => scanQRCode(),
              child: Container(
                width: 170,
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                child: Text(
                  'Tap to scan',     
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding ),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
  ),
  );

  Future<void> scanQRCode() async {
    var qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#6F35A5',
      'Cancel',
      true,
      ScanMode.QR,
    );

    if (!mounted) return;

    setState(() {
      qrCode = qrCode;
    });

    // print(qrCode);
    // print(data);

    await CheckCode(qrCode);
    // if (response.statusCode == 200) 
    if (data != '')
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(
            qrdata: data,
          ),
        ),
      );
    }
  }
}