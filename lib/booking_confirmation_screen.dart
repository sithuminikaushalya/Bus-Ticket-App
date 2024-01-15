import 'package:flutter/material.dart';
import 'second_screen.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final VoidCallback onConfirmPayment;

  BookingConfirmationScreen({required this.onConfirmPayment});

  @override
  _BookingConfirmationScreenState createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/success.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16), // Add a gap between image and text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'You have booked your bus seat with JourneyEase.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center the text
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your booking has been confirmed!'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Show an alert when the Confirm Payment button is pressed
                      _showPaymentConfirmationAlert(context);
                    },
                    child: Text('Confirm Payment'),
                  ),
                  SizedBox(height: 20), // Add a gap between buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondScreen()),
                      );
                    },
                    child: Text('Go to Home Screen'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the payment confirmation alert
  void _showPaymentConfirmationAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: _navigatorKey,
          title: Text('Confirm Payment'),
          content: Text('Are you sure you want to confirm the payment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the onConfirmPayment callback to handle payment confirmation logic
                widget.onConfirmPayment();
                Navigator.pop(context); // Close the alert
                _showSuccessSnackBar(context); // Show success message
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the success SnackBar
  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment successfully completed!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Close the AlertDialog
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
