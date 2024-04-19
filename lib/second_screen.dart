import 'package:flutter/material.dart';
import 'destination_screen.dart';
import 'settings_screen.dart';
import 'map_screen.dart';

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
        title: null, // Set title to null to remove the text
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 220, 235),
        actions: [
          // Remove the IconButton widget
        ],
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
          Text(
            'Bus Ticket Booking',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF51259B),
            ),
          ),
          SizedBox(height: 30.0), // Add gap between heading and image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/second.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0), // Add gap between image and button
          MaterialButton(
            minWidth: 150, // Set a specific width for the button
            height: 50,
            onPressed: () {
              // Navigate to sign up screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DestinationScreen()),
              );
            },
            color: Color(0xFF51259B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "Book Ticket",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 30.0), // Add gap between button and bottom bar
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
