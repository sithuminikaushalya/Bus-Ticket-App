import 'package:flutter/material.dart';
import 'seat_button.dart';
import 'payment_screen.dart'; // Import the PaymentScreen

class ChooseSeatScreen extends StatefulWidget {
  final String from;
  final String to;
  final DateTime selectedDate;
  final int passengerCount;

  ChooseSeatScreen({
    required this.from,
    required this.to,
    required this.selectedDate,
    required this.passengerCount,
  });

  @override
  _ChooseSeatScreenState createState() => _ChooseSeatScreenState();
}


class _ChooseSeatScreenState extends State<ChooseSeatScreen> {
  List<int> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Seat'),
      ),
      body: Container(
        width: 390.0, // Adjust the width as needed
        height: 844.0, // Adjust the height as needed
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    int seatNumber = index + 1;
                    bool isSelected = selectedSeats.contains(seatNumber);

                    return SeatButton(
                      seatNumber: seatNumber,
                      isSelected: isSelected,
                      onSeatSelected: () {
                        setState(() {
                          if (isSelected) {
                            selectedSeats.remove(seatNumber);
                          } else {
                            selectedSeats.add(seatNumber);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to PaymentScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
            from: widget.from,
            to: widget.to,
            numberOfTickets: widget.passengerCount,
            busNumber: "11",
            perTicketAmount: 23.0,
            selectedDate: widget.selectedDate,
            passengerCount: widget.passengerCount,
            selectedSeats: selectedSeats,
          ),
                    ),
                  );
                },
                child: Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
