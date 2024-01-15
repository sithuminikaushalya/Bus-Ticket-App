import 'package:flutter/material.dart';
import 'login_signup_screen.dart'; // Import the LoginSignupScreen class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Ticket App',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Remove the title from the AppBar
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 220, 235),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFE4DCEE),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 20.0), // Add a gap between the status bar and the text
            Text(
              'JOURNEYEASE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Color(0xFF51259B),
              ),
            ),
            SizedBox(height: 40.0), // Add a gap between the text and the image
            Expanded(
              child: Container(
                width: double.infinity,
                height: 50.0, // Adjust the height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the LoginSignupScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF51259B),
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
                padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text("Get Started"),
            ),
            SizedBox(height: 60.0), // Add a gap below the button
          ],
        ),
      ),
    );
  }
}
