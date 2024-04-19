import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_signup_screen.dart'; // Import the LoginSignupScreen class
import 'package:firebase_app_check/firebase_app_check.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA-xsGK7tO4RnJ50HiBqJtQlcTA5cQOCts", 
      appId: "1:727786959765:android:accac9acc9b0ea7e617c9c", 
      messagingSenderId: "727786959765",
      projectId:"busticketbookingapporg.appspot.com",
      databaseURL:"https://busticketbookingapporg-default-rtdb.firebaseio.com"
      ),

      
  );
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
        // your preferred provider. Choose from:
        // 1. Debug provider
        // 2. Device Check provider
        // 3. App Attest provider
        // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Bus Ticket App',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      appBar: AppBar(
        
        // Remove the title from the AppBar
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 230, 220, 235),
      ),
      body: Container(
        
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFE4DCEE),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 20.0), // Add a gap between the status bar and the text
            Text(
              'JOURNEYEASE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Color(0xFF51259B),
              ),
            ),
            SizedBox(height: 40.0), // Add a gap between the text and the image
            Expanded(
              child: Container(
                width: double.infinity,
                height: 50.0, // Adjust the height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            MaterialButton(
            minWidth: 150, // Set a specific width for the button
            height: 50,
            onPressed: () {
              // Navigate to sign up screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginSignupScreen()),
              );
            },
            color: Color(0xFF51259B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "Get Started",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
            SizedBox(height: 60.0), // Add a gap below the button
          ],
        ),
      ),
    );
  }
}
