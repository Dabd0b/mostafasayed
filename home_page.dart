import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';
import 'product.dart';
import 'product_item.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

 
}
class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? displayName;
  String? email;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await _firestore.collection('users').doc(user.uid).get();
// breakpoint at 116 utils.dart
      setState(() {
        displayName = userData['FirstName'] + ' ' + userData['LastName'];
        email = userData['Email'];
      });
    }
  }

   final List<Product> products = [
  Product(
    id: '1',
    name: 'Product 1',
    description: 'Description for Product 1',
    price: 19.99,
    imageUrl: 'https://example.com/product1.jpg',
  ),
  // Add more products here
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the shopping cart page
              // Implement this navigation as needed
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to the profile page
              // Implement this navigation as needed
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(displayName ?? 'User'),
              accountEmail: Text(email ?? 'No Email'),
              currentAccountPicture: CircleAvatar(
                // Replace with user's profile picture
                backgroundImage: NetworkImage('https://example.com/profile.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigate to the home page or close the drawer if already on the home page
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Address'),
              onTap: () {
                // Navigate to the address section
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment'),
              onTap: () {
                // Navigate to the payment section
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Current Orders'),
              onTap: () {
                // Navigate to the current orders section
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Past Orders'),
              onTap: () {
                // Navigate to the past orders section
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Wishlist'),
              onTap: () {
                // Navigate to the wishlist section
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to the settings section
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language (Arabic/English)'),
              onTap: () {
                // Implement language settings
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Contact Us'),
              onTap: () {
                // Navigate to the help & contact us section
                // Implement this navigation as needed
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () async {
                await AuthService().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
                
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // Number of columns in the grid
    crossAxisSpacing: 10.0, // Spacing between columns
    mainAxisSpacing: 10.0, // Spacing between rows
    ),
  itemCount: products.length,
  itemBuilder: (ctx, index) {
    final product = products[index];
    return ProductItem(product: product); // Create a custom ProductItem widget
  },
),

    );
  }
}
