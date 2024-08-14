import 'package:flutter/material.dart';
import 'language_screen.dart';
import 'theme_screen.dart';
import 'account_info_screen.dart';
import 'change_password_screen.dart';
import 'card_details_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromARGB(255, 230, 220, 235),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildListTile(
              context,
              icon: Icons.language,
              title: 'Language',
              subtitle: 'English',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageScreen()),
                );
              },
            ),
            Divider(),
            _buildListTile(
              context,
              icon: Icons.color_lens,
              title: 'Theme',
              subtitle: 'Light',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThemeScreen()),
                );
              },
            ),
            Divider(),
            // Add more general settings as needed

            SizedBox(height: screenHeight * 0.03),

            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildListTile(
              context,
              icon: Icons.person,
              title: 'Account Info',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountInfoScreen()),
                );
              },
            ),
            Divider(),
            _buildListTile(
              context,
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                );
              },
            ),
            Divider(),
            _buildListTile(
              context,
              icon: Icons.credit_card,
              title: 'Card Details',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardDetailsScreen()),
                );
              },
            ),
            // Add more account settings as needed
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ListTile(
      leading: Icon(icon, size: screenWidth * 0.07),
      title: Text(
        title,
        style: TextStyle(fontSize: screenWidth * 0.045),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style:
                  TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
            )
          : null,
      onTap: onTap,
    );
  }
}
