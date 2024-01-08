// second_screen.dart
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bus Ticket Booking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Color(0xFF51259B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 220, 235),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildCustomBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Container(
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
          Expanded(
            child: Container(
              width: double.infinity,
              height: 100.0, // Adjust the height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/second.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement the logic for ticket booking
              // You might navigate to a new screen for ticket booking
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF51259B),
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text("Book Ticket"),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Color(0xFF51259B),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          // Handle navigation to different sections here
          if (index == 0) {
            // Navigate to the second screen (self)
          } else if (index == 1) {
            // Navigate to another screen if needed
          } else if (index == 2) {
            // Navigate to yet another screen if needed
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map), // Custom icon for the second screen
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
