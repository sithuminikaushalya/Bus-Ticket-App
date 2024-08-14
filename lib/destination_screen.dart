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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/destination.jpg',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      controller: _fromController,
                      decoration: InputDecoration(
                        labelText: 'From',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextField(
                      controller: _toController,
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Date:'),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Pick Date'),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Visibility(
                      visible: !_isDateSelected,
                      child: Row(
                        children: [
                          SizedBox(width: screenWidth * 0.05),
                          Text('Date: Not selected'),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: _isDateSelected
                            ? screenHeight * 0.01
                            : screenHeight * 0.02),
                    Visibility(
                      visible: _isDateSelected,
                      child: Row(
                        children: [
                          SizedBox(width: screenWidth * 0.05),
                          Text(
                            'Date: ${_selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'Not selected'}',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Text('Passengers:'),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: DropdownButton<int>(
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
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_fromController.text.isNotEmpty &&
                              _toController.text.isNotEmpty &&
                              _selectedDate != null) {
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all fields.'),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02),
                          child: Text(
                            'Search',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 57, 19, 63),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
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
