import 'package:flutter/material.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  List<String> themes = ['Light', 'Dark', 'Night'];
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
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
              'Select a Theme:',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: themes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      themes[index],
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedTheme = themes[index];
                      });
                      // Implement theme selection logic here
                    },
                    tileColor: selectedTheme == themes[index]
                        ? Colors.blue
                            .withOpacity(0.3) // Highlight selected theme
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
