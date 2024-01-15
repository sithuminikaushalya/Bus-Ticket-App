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
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Theme:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: themes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(themes[index]),
                  onTap: () {
                    setState(() {
                      selectedTheme = themes[index];
                    });
                    // Implement theme selection logic here
                  },
                  tileColor: selectedTheme == themes[index]
                      ? Colors.blue.withOpacity(0.3) // Highlight selected theme
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
