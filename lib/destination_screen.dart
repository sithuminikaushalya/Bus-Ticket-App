import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'bus_list_screen.dart';

class DestinationScreen extends StatefulWidget {
  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  DateTime? _selectedDate;
  int _passengerCount = 1;
  bool _isDateSelected = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _isDateSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Destination'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 202, 186, 223),
                Color.fromARGB(255, 233, 216, 241),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/destination.jpg',
                      width: 400.0, // Adjust the width as needed
                      height: 250.0, // Adjust the height as needed
                    ),
                    SizedBox(height: 2.0),
                    TextField(
                      controller: _fromController,
                      decoration: InputDecoration(
                        labelText: 'From',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: _toController,
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text('Select Date:'),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: Text('Pick Date'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Visibility(
                        visible: !_isDateSelected,
                        child: Row(
                          children: [
                            SizedBox(width: 32.0),
                            Text(
                              'Date: Not selected',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: _isDateSelected ? 8.0 : 16.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Visibility(
                        visible: _isDateSelected,
                        child: Row(
                          children: [
                            SizedBox(width: 20.0),
                            Text(
                              'Date: ${_selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'Not selected'}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text('Passengers:'),
                        SizedBox(width: 8.0),
                        DropdownButton<int>(
                          value: _passengerCount,
                          onChanged: (value) {
                            setState(() {
                              _passengerCount = value!;
                            });
                          },
                          items: List.generate(10, (index) => index + 1)
                              .map((value) => DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_fromController.text.isNotEmpty &&
                            _toController.text.isNotEmpty &&
                            _selectedDate != null) {
                          // Navigate to the bus list screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusListScreen(
                                from: _fromController.text,
                                to: _toController.text,
                                selectedDate: _selectedDate!,
                                passengerCount: _passengerCount,
                              ),
                            ),
                          );
                        } else {
                          // Show an error message or handle validation
                          print('Please fill in all fields.');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          'Search',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                          255,
                          57,
                          19,
                          63,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
