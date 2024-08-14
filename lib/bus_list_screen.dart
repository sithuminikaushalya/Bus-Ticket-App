import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'choose_seat_screen.dart';

class Bus {
  final String busNumber;
  final String departureTime;
  final String arrivalTime;
  final String price;

  Bus({
    required this.busNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
  });
}

class BusListScreen extends StatefulWidget {
  final String from;
  final String to;
  final DateTime selectedDate;
  final int passengerCount;

  BusListScreen({
    required this.from,
    required this.to,
    required this.selectedDate,
    required this.passengerCount,
  });

  @override
  _BusListScreenState createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  List<Bus> buses = List.generate(
    10,
    (index) => Bus(
      busNumber: 'Bus #${index + 1}',
      departureTime: '8:00 AM',
      arrivalTime: '2:00 PM',
      price: '50',
    ),
  );

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bus List'),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/list.jpg',
            width: screenWidth * 0.58,
            height: screenHeight * 0.25,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: buses.length,
              itemBuilder: (context, index) {
                return BusCard(
                  bus: buses[index],
                  isSelected: index == selectedIndex,
                  onTapBookNow: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    // Navigate to the choose seat screen and provide the selected bus number
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseSeatScreen(
                          passengerCount: widget.passengerCount,
                          busNumber: buses[index].busNumber,
                          selectedSeats: [],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Displaying filled details with background color
          Container(
            color: Color.fromARGB(
              255,
              238,
              228,
              240,
            ), // Set your desired background color
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From: ${widget.from}',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'To: ${widget.to}',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'Date: ${DateFormat('yyyy-MM-dd').format(widget.selectedDate)}',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'Passenger Count: ${widget.passengerCount}',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BusCard extends StatefulWidget {
  final Bus bus;
  final bool isSelected;
  final VoidCallback onTapBookNow;

  BusCard({
    required this.bus,
    required this.isSelected,
    required this.onTapBookNow,
  });

  @override
  _BusCardState createState() => _BusCardState();
}

class _BusCardState extends State<BusCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.all(screenWidth * 0.03),
      color: widget.isSelected ? Colors.yellow : null,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bus Number: ${widget.bus.busNumber}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.01),
            Text('Departure Time: ${widget.bus.departureTime}'),
            Text('Arrival Time: ${widget.bus.arrivalTime}'),
            Text('Price: ${widget.bus.price}'),
            SizedBox(height: screenWidth * 0.01),
            ElevatedButton(
              onPressed: widget.onTapBookNow,
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
