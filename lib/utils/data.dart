import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? palmId;
  double? wallet;

  User({this.palmId, this.wallet});

}

class UserFirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> loadUserData() async {
    try {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final email = currentUser.email;
      print(email);
      final userRef =
          _firestore.collection('users').where('email', isEqualTo: email);
      final userSnapshot = await userRef.get();
      final userData = userSnapshot.docs.first.data();
      final palmId = userData['palm_id'];
      final walletRef = _firestore.collection('users').doc(palmId);
      final walletSnapshot = await walletRef.get();
      // final walletData = walletSnapshot.data();
      // if (walletData != null) {
      // User.wallet = walletData['wallet'];
      // }
      final wallet = (walletSnapshot.data()!['wallet'] as num).toDouble();
      print(palmId);
      print(wallet);
      return User(palmId: palmId, wallet: wallet);
    } 
    } on Exception catch(ex){
      print(ex);
    }
    return User();
  }

  Future<void> updateUserData(String palmId, double newWalletAmount) async {
    await _firestore.collection('users').doc(palmId).update({
      'wallet': newWalletAmount,
    });
  }
}
