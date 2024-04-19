import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountInfoScreen extends StatefulWidget {
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  String phoneNumber = '+1 123 456 7890'; // Initial phone number
  String location = '123 Main Street, Cityville'; // Initial location
  String name = 'John Doe'; // Initial name
  String email = 'john.doe@email.com'; // Initial email
  File? _image; // Variable to store the selected image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Information'),
      ),
      resizeToAvoidBottomInset: false, // Add this line
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _pickImage(); // Call the function to pick an image
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: _image != null
                    ? ClipOval(
                        child: Image.file(
                          _image!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Name'),
              subtitle: Text(name),
              onTap: () {
                _showNameDialog();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              subtitle: Text(location),
              onTap: () {
                _showLocationDialog();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Date of Birth'),
              subtitle: Text('January 1, 1990'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(1990, 1, 1),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null && pickedDate != DateTime(1990, 1, 1)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Selected date: ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}'),
                    ),
                  );
                }
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(email),
              onTap: () {
                _showEmailDialog();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone Number'),
              subtitle: Text(phoneNumber),
              onTap: () {
                _showPhoneNumberDialog();
              },
            ),
            // Add more account information details as needed
          ],
        ),
      ),
    );
  }

  // Function to show dialog for name input
  _showNameDialog() async {
    TextEditingController nameController = TextEditingController(text: name);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Name'),
          content: TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to show dialog for location input
  _showLocationDialog() async {
    TextEditingController locationController =
        TextEditingController(text: location);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Location'),
          content: TextField(
            controller: locationController,
            keyboardType: TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  location = locationController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to show dialog for email input
  _showEmailDialog() async {
    TextEditingController emailController = TextEditingController(text: email);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Email'),
          content: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  email = emailController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to show dialog for phone number input
  _showPhoneNumberDialog() async {
    TextEditingController phoneNumberController =
        TextEditingController(text: phoneNumber);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Phone Number'),
          content: TextField(
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  phoneNumber = phoneNumberController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to pick an image from the gallery
  _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
