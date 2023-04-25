import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  static String? palmId;
  static double? wallet;

}

class UserFirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadUserData() async {
    try {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final email = currentUser.email;
      print(email);
      final userRef =
          _firestore.collection('users').where('email', isEqualTo: email);
      final userSnapshot = await userRef.get();
      final userData = userSnapshot.docs.first.data();
      User.palmId = userData['palm_id'];
      final walletRef = _firestore.collection('users').doc(User.palmId);
      final walletSnapshot = await walletRef.get();
      // final walletData = walletSnapshot.data();
      // if (walletData != null) {
      // User.wallet = walletData['wallet'];
      // }
      User.wallet = (walletSnapshot.data()!['wallet'] as num).toDouble();
      // print(User.palmId);
      // print(User.wallet);
    } 
    } on Exception catch(ex){
      print(ex);
    }
  }

  Future<void> updateWallet(double moneyToAdd) async {
  final walletRef = _firestore.collection('users').doc(User.palmId);
  final walletSnapshot = await walletRef.get();
  // final walletData = walletSnapshot.data();
  double previousWalletAmount = (walletSnapshot.data()!['wallet'] as num).toDouble();
  double newWalletAmount = previousWalletAmount + moneyToAdd;
  await walletRef.update({'wallet': newWalletAmount});
  User.wallet = newWalletAmount;
}


}
