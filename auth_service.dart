import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Sign up with email and password
  Future<String?> signUpWithEmailAndPassword(String email, String password,String firstName,String lastName,String phoneNumber,String gender,) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Get the current user
      final User? user = _auth.currentUser;
 // Send email verification
    await user?.sendEmailVerification();
    
      // Update user profile display name
      await user?.updateProfile(displayName: '$firstName $lastName');

      // Store additional user information in Cloud Firestore
      await _firestore.collection('users').doc(user?.uid).set({
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Tel_No': phoneNumber,
        'Gender': gender,
      });
  
      return null; // Success
    } catch (e) {
      return e.toString(); // Error message
    }
  }

  // Sign in with email and password
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } catch (e) {
      return e.toString(); // Error message
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
