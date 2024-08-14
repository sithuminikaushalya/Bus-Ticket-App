import 'package:flutter/material.dart';

class SeatButton extends StatelessWidget {
  final int seatNumber;
  final bool isSelected;
  final VoidCallback onSeatSelected;

  SeatButton({
    required this.seatNumber,
    required this.isSelected,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSeatSelected,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Container(
        width: 60.0, // Adjust the width as needed
        height: 60.0, // Adjust the height as needed
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            seatNumber.toString(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
