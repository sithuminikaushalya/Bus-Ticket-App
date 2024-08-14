import 'package:flutter/material.dart';
import 'booking_confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final List<int> selectedSeats;
  final String busNumber;
  final int numberOfTickets;
  final double perTicketAmount;

  PaymentScreen({
    required this.selectedSeats,
    required this.busNumber,
    required this.numberOfTickets,
    required this.perTicketAmount,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> paymentMethods = [
    'Credit Card',
    'PayPal',
    'Google Pay',
    'Other'
  ];
  String selectedPaymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    double totalAmount = widget.numberOfTickets * widget.perTicketAmount;

    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: screenHeight * 0.25, // Responsive height
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/payment.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Responsive spacing
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Seats: ${widget.selectedSeats.toString()}',
                  style: TextStyle(
                      fontSize: screenWidth * 0.045), // Responsive font size
                ),
                SizedBox(height: screenHeight * 0.01), // Responsive spacing
                Text(
                  'Bus Number: ${widget.busNumber}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Number of Tickets: ${widget.numberOfTickets}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Per Ticket Amount: \$${widget.perTicketAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Payment Method:',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
                SizedBox(height: screenHeight * 0.01),
                DropdownButton<String>(
                  value: selectedPaymentMethod,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPaymentMethod = newValue!;
                    });
                  },
                  items: paymentMethods.map((String method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: ElevatedButton(
              onPressed: () {
                // Open the card details modal
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => CardDetailsModal(),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardDetailsModal extends StatefulWidget {
  @override
  _CardDetailsModalState createState() => _CardDetailsModalState();
}

class _CardDetailsModalState extends State<CardDetailsModal> {
  late TextEditingController cardNumberController;
  late TextEditingController validUntilController;
  late TextEditingController cardHolderController;
  late TextEditingController cvvController;
  bool saveCardDetails = false;

  @override
  void initState() {
    super.initState();
    cardNumberController = TextEditingController();
    validUntilController = TextEditingController();
    cardHolderController = TextEditingController();
    cvvController = TextEditingController();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    validUntilController.dispose();
    cardHolderController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter Card Details',
              style: TextStyle(
                  fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),
            TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextField(
              controller: validUntilController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Valid Until (MM/YY)'),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextField(
              controller: cardHolderController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Cardholder Name'),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'CVV'),
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                Checkbox(
                  value: saveCardDetails,
                  onChanged: (value) {
                    setState(() {
                      saveCardDetails = value!;
                    });
                  },
                ),
                Text('Save Card Details'),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {
                // Implement logic to handle the submission of card details and saveCardDetails state
                String cardNumber = cardNumberController.text;
                String validUntil = validUntilController.text;
                String cardHolder = cardHolderController.text;
                String cvv = cvvController.text;

                // You can use these values as needed (e.g., send them to a payment API)
                print('Card Number: $cardNumber');
                print('Valid Until: $validUntil');
                print('Cardholder Name: $cardHolder');
                print('CVV: $cvv');
                print('Save Card Details: $saveCardDetails');

                // Navigate to the Booking Confirmation Screen
                Navigator.pop(context); // Close the modal
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingConfirmationScreen(
                      onConfirmPayment: () {
                        // Implement payment confirmation logic here
                        // This callback will be called when the user confirms the payment
                        // Navigate to the next screen or perform any additional actions
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentSuccessScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Payment Successful!'),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the Payment Screen
                Navigator.pop(context);
              },
              child: Text('Back to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
