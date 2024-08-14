import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountInfoScreen extends StatefulWidget {
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  String phoneNumber = '+1 123 456 7890';
  String location = '123 Main Street, Cityville';
  String name = 'John Doe';
  String email = 'john.doe@email.com';
  File? _image;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius =
        screenWidth * 0.15; // Adjust avatar size based on screen width

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Information'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: Colors.blue,
                  child: _image != null
                      ? ClipOval(
                          child: Image.file(
                            _image!,
                            width: avatarRadius * 2,
                            height: avatarRadius * 2,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: avatarRadius * 1.2,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, size: screenWidth * 0.06),
                    title: Text('Name',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                    subtitle: Text(name,
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    onTap: () {
                      _showNameDialog();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on, size: screenWidth * 0.06),
                    title: Text('Location',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                    subtitle: Text(location,
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    onTap: () {
                      _showLocationDialog();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading:
                        Icon(Icons.calendar_today, size: screenWidth * 0.06),
                    title: Text('Date of Birth',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                    subtitle: Text('January 1, 1990',
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(1990, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null &&
                          pickedDate != DateTime(1990, 1, 1)) {
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
                    leading: Icon(Icons.email, size: screenWidth * 0.06),
                    title: Text('Email',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                    subtitle: Text(email,
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    onTap: () {
                      _showEmailDialog();
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone, size: screenWidth * 0.06),
                    title: Text('Phone Number',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                    subtitle: Text(phoneNumber,
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    onTap: () {
                      _showPhoneNumberDialog();
                    },
                  ),
                  // Add more account information details as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
