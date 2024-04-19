import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'booking_confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final List<int> selectedSeats;
  final String busNumber;
  final int numberOfTickets;
  final double perTicketAmount;

  final String from;
  final String to;
  final DateTime selectedDate;
  final int passengerCount;
  // final List<int> selectedSeats;

  PaymentScreen({
    required this.selectedSeats,
    required this.busNumber,
    required this.numberOfTickets,
    required this.perTicketAmount,
     required this.from,
    required this.to,
    required this.selectedDate,
    required this.passengerCount,
    // required this.selectedSeats,
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
  String selectedPaymentMethod = 'Credit Card'; // Default payment method

  @override
  Widget build(BuildContext context) {
    double totalAmount = widget.numberOfTickets * widget.perTicketAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/payment.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Seats: ${widget.selectedSeats.toString()}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Bus Number: ${widget.busNumber}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Number of Tickets: ${widget.numberOfTickets}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Per Ticket Amount: \$${widget.perTicketAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Payment Method:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
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
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Open the card details modal
                showModalBottomSheet(
                  context: context,
               builder: (BuildContext context) => CardDetailsModal(
  selectedSeats: widget.selectedSeats,
  busNumber: widget.busNumber,
  numberOfTickets: widget.numberOfTickets,
  perTicketAmount: widget.perTicketAmount,
  from: widget.from,
  to: widget.to,
  selectedDate: widget.selectedDate,
  passengerCount: widget.passengerCount,
),

               );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18),
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
  final List<int> selectedSeats;
  final String busNumber;
  final int numberOfTickets;
  final double perTicketAmount;
  final String from;
  final String to;
  final DateTime selectedDate;
  final int passengerCount;

  CardDetailsModal({
    required this.selectedSeats,
    required this.busNumber,
    required this.numberOfTickets,
    required this.perTicketAmount,
    required this.from,
    required this.to,
    required this.selectedDate,
    required this.passengerCount,
  });
  
  @override
 _CardDetailsModalState createState() => _CardDetailsModalState(
        // Pass parameters to the state
        selectedSeats: selectedSeats,
        busNumber: busNumber,
        numberOfTickets: numberOfTickets,
        perTicketAmount: perTicketAmount,
        from: from,
        to: to,
        selectedDate: selectedDate,
        passengerCount: passengerCount,
      );
}

class _CardDetailsModalState extends State<CardDetailsModal> {
  
  late TextEditingController cardNumberController;
  late TextEditingController validUntilController;
  late TextEditingController cardHolderController;
  late TextEditingController cvvController;
  bool saveCardDetails = false;

  // Parameters to initialize the state
  final List<int> selectedSeats;
  final String busNumber;
  final int numberOfTickets;
  final double perTicketAmount;
  final String from;
  final String to;
  final DateTime selectedDate;
  final int passengerCount;

  _CardDetailsModalState({
    required this.selectedSeats,
    required this.busNumber,
    required this.numberOfTickets,
    required this.perTicketAmount,
    required this.from,
    required this.to,
    required this.selectedDate,
    required this.passengerCount,
  });

  
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
    FirebaseDatabase database = FirebaseDatabase.instance;
Future<void> _addPaymentDataToDatabase() async {
  try {
   
    DatabaseReference ref = database.reference().child('payments').push();


await ref.set({
      'from': from,
      'to': to,
      'date': DateFormat('yyyy-MM-dd').format(selectedDate),
      'passengerCount': passengerCount,
      'selectedSeats': selectedSeats.join(', '),
      'timestamp': ServerValue.timestamp,
      "cost":passengerCount*23
    }).then((_) {
      print('Success: Data added to Firebase');
    });

  } catch (e) {
    print('Error adding data to Firebase: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter Card Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: validUntilController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Valid Until (MM/YY)'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: cardHolderController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Cardholder Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'CVV'),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 20),
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
                       _addPaymentDataToDatabase();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Payment Successful!'),
            SizedBox(height: 20),
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
