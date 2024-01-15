import 'package:flutter/material.dart';
import 'payment_screen.dart';

class ChooseSeatScreen extends StatelessWidget {
  final int passengerCount;
  final String busNumber;
  final List<int> selectedSeats;

  ChooseSeatScreen({
    required this.passengerCount,
    required this.busNumber,
    required this.selectedSeats,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Seat'),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/seat.png',
            height: 200,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Adjusted to 5 columns
                crossAxisSpacing: 8.0, // Space between seats
                mainAxisSpacing: 8.0, // Space between rows
              ),
              itemCount: 60,
              itemBuilder: (context, index) {
                if (index < 60) {
                  // Rows 1 to 12 with 5 seats and space for a middle seat
                  return SeatWidget(
                    seatNumber: index + 1,
                    isSpaceBetweenPairs: index % 5 == 1 || index % 5 == 3,
                    isSelected: selectedSeats.contains(index + 1),
                    isSelectable: isSeatSelectable(),
                    onTap: () => onSeatTap(context, index + 1),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
          // Spacer below the seat selection grid
          SizedBox(height: 16.0),
          // Book Now button
          ElevatedButton(
            onPressed: () {
              // Navigate to payment screen with selected seats
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    selectedSeats: selectedSeats,
                    busNumber: busNumber,
                    numberOfTickets: passengerCount,
                    perTicketAmount:
                        25.0, // Adjust this value based on your logic
                  ),
                ),
              );
            },
            child: Text('Book Now'),
          ),
          // Spacer below the Book Now button
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  bool isSeatSelectable() {
    // Implement your logic here to determine if the seat is selectable based on passenger count
    // For example, check if the length of selectedSeats is within the allowed range of passengers
    return selectedSeats.length <
        passengerCount; // Adjust the condition as needed
  }

  void onSeatTap(BuildContext context, int seatNumber) {
    // Implement logic to handle seat selection based on passenger count
    if (selectedSeats.contains(seatNumber)) {
      // Deselect the seat
      selectedSeats.remove(seatNumber);
    } else {
      // Select the seat only if it's within the allowed range
      if (isSeatSelectable()) {
        // Add seat to the selectedSeats list
        selectedSeats.add(seatNumber);
      } else {
        // Show an alert if the passenger tries to exceed the allowed count
        showSeatSelectionAlert(context);
      }
    }
  }

  void showSeatSelectionAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seat Selection Alert'),
          content: Text(
            'You cannot select more seats than the allowed passenger count.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class SeatWidget extends StatelessWidget {
  final int seatNumber;
  final bool isSpaceBetweenPairs;
  final bool isSelected;
  final bool isSelectable;
  final VoidCallback onTap;

  SeatWidget({
    required this.seatNumber,
    required this.isSpaceBetweenPairs,
    required this.isSelected,
    required this.isSelectable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelectable ? onTap : null,
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 81, 11, 139)
              : isSelectable
                  ? Color.fromARGB(255, 134, 119, 210)
                  : Color.fromARGB(255, 216, 214, 214),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
