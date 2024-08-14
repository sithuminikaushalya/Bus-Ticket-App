import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> languages = ['English', 'Sinhala', 'Tamil'];
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings'),
        backgroundColor: Color.fromARGB(255, 230, 220, 235),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Language:',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      languages[index],
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedLanguage = languages[index];
                      });
                      // Implement language selection logic here
                    },
                    tileColor: selectedLanguage == languages[index]
                        ? Colors.blue.withOpacity(0.3)
                        : null,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.005,
                      horizontal: screenWidth * 0.02,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
