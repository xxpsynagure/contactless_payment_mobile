import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class User {
  static String? palmId;
  static double? wallet;
  static List<dynamic> transactions = [];
}

class UserFirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadUserWallet() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final email = currentUser.email;
        final userRef =
          _firestore.collection('users').where('email', isEqualTo: email);
        final userSnapshot = await userRef.get();
        final userData = userSnapshot.docs.first.data();
        User.palmId = userData['palm_id'];
        final walletRef = _firestore.collection('users').doc(User.palmId);
        final walletSnapshot = await walletRef.get();
        User.wallet = (walletSnapshot.data()!['wallet'] as num).toDouble();
        // print('wallet added');
      }     
    } on Exception catch(ex){
      print(ex);
    }
  }

  Future<void> loadUserTransactions() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final email = currentUser.email;
        final userRef =
          _firestore.collection('users').where('email', isEqualTo: email);
        final userSnapshot = await userRef.get();
        final userData = userSnapshot.docs.first.data();
        User.palmId = userData['palm_id'];
              
        final transactionSnapshot = await FirebaseFirestore.instance.collection('users').doc(User.palmId).collection('transactions').orderBy('time_stamp', descending: true).get();
        List<dynamic> transactionsList = [];

        for (var transaction in transactionSnapshot.docs){
          String trans = transaction.data().toString().replaceAll(new RegExp(r'[{}]+'),'');
          // print(transaction.data().toString());
          List<dynamic> listt= trans.split(RegExp(r',\s(?![^()]*\))'));
          Map<String, dynamic> transactionMap = {};
          listt.forEach((data) {
            List<dynamic> val = data.split(': ');
            if(val[0] == 'time_stamp') {
              int seconds = int.parse(val[1].split("seconds=")[1].split(",")[0]);
              int nanoseconds = int.parse(val[1].split("nanoseconds=")[1].split(")")[0]);
              Timestamp timestamp = Timestamp(seconds, nanoseconds);
              DateTime dateTime = timestamp.toDate();
              DateTime localDateTime = dateTime.add(Duration(hours: 5, minutes: 30));
              transactionMap[val[0]] = localDateTime;
            }
            else {
              transactionMap[val[0]] = val[1];
            }
          });
          // print(transactionMap.toString());

          transactionsList.add(transactionMap);
        }    
        User.transactions = transactionsList;
      } 
    } on Exception catch(ex){
      print(ex);
    }
  }

  Future<void> updateWallet(double moneyToAdd) async {
  final walletRef = _firestore.collection('users').doc(User.palmId);
  final walletSnapshot = await walletRef.get();
  double previousWalletAmount = (walletSnapshot.data()!['wallet'] as num).toDouble();
  double newWalletAmount = previousWalletAmount + moneyToAdd;
  await walletRef.update({'wallet': newWalletAmount});
  User.wallet = newWalletAmount;

  Map<String, dynamic> currentTransactionData = {
      "amount": moneyToAdd,
      "time_stamp": DateTime.now(),
      "type": "credit"
    };

    CollectionReference transactionCollection = FirebaseFirestore.instance.collection("users").doc(User.palmId).collection("transactions");
    transactionCollection.add(currentTransactionData);
}


}
