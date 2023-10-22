import 'package:flutter/material.dart';
import 'package:testt/home_page.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
String _selectedGender = 'Male'; // Default gender

  Future<void> _signUpWithEmailAndPassword() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final firstName = _firstNameController.text.trim();
  final lastName = _lastNameController.text.trim();
  final phoneNumber = _phoneNumberController.text.trim();
  final gender = _selectedGender;
    try {
      String? error = await AuthService().signUpWithEmailAndPassword(email, password,firstName,lastName,phoneNumber, gender);
      if (error == null) {
        // Navigate to the home page on successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>HomePage()),
        );
      } else {
        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    } catch (e) {
      // Handle other errors (e.g., Firebase exceptions)
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextFormField(
  controller: _firstNameController,
  decoration: InputDecoration(labelText: 'First Name'),
  // Add any necessary validation for first name
),
TextFormField(
  controller: _lastNameController,
  decoration: InputDecoration(labelText: 'Last Name'),
  // Add any necessary validation for last name
),
TextFormField(
  controller: _phoneNumberController,
  decoration: InputDecoration(labelText: 'Phone Number'),
  // Add any necessary validation for phone number
),
DropdownButtonFormField<String>(
  value: _selectedGender,
  onChanged: (value) {
    setState(() {
      _selectedGender = value!;
    });
  },
  items: ['Male', 'Female', 'Other'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  decoration: InputDecoration(labelText: 'Gender'),
),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUpWithEmailAndPassword,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
