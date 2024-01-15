import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';

class LoginSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to JOURNEYEASE!'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 199, 186, 222),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Find your journey with ease.",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 15,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: MediaQuery.of(context).size.height /
                1.8, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/welcome.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          MaterialButton(
            minWidth: 150, // Set a specific width for the button
            height: 50,
            onPressed: () {
              // Navigate to login screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            // defining the shape
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 20),
          MaterialButton(
            minWidth: 150, // Set a specific width for the button
            height: 50,
            onPressed: () {
              // Navigate to sign up screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            color: Color(0xFF51259B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "Sign up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
