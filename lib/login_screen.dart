import 'package:easy_journey/firebase_ref.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'second_screen.dart';
import 'Sign_Up_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30, // Set your desired app bar height
      ),
      body: LoginPage(),
    );
  }
}



class LoginPage extends StatelessWidget {
   final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

@override
  void onReady() {
    initAuth();
    // super.onReady();
  }

  late FirebaseAuth _auth;

  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;
  void initAuth() async {
  await Future.delayed(const Duration(seconds: 2));
  _auth = FirebaseAuth.instance; // Initialize _auth before using it
  _authStateChanges = _auth.authStateChanges();
  _authStateChanges.listen((User? user) {
    _user.value = user;
  });
}


signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _authAccount.idToken,
            accessToken: _authAccount.accessToken);
        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(),
        ),
      );
      }  
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
      
}

saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
    print("save user ok");
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: phoneNumberController.text, password: passwordController.text);

      // Login successful, navigate to the second screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(),
        ),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // Handle invalid credentials
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Credentials'),
              content: Text('Please check your phone number and password.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60, // Set your desired app bar height
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(), // Empty container to hide the custom back arrow
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Login to your account",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          inputFile(
                            label: "Email",
                            width: double.infinity,
                            controller: phoneNumberController,
                          ),
                          SizedBox(height: 10),
                          inputFile(
                            label: "Password",
                            obscureText: true,
                                controller: passwordController,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 40,
                        onPressed: () {
                          loginUser(context);
                          // Navigate to SecondScreen after login
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SecondScreen(),
                          //   ),
                          // );
                        },
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Padding(
                      // padding: EdgeInsets.symmetric(horizontal: 40),
                      // child: MaterialButton(
                      //   minWidth: double.infinity,
                      //   height: 40,
                      //   onPressed: () {
                      //     signInWithGoogle(context);
                      //     // Add Google login logic here
                      //   },
                      //   color: const Color.fromARGB(
                      //       255, 200, 190, 189), // Change color as needed
                      //   elevation: 0,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Icon(Icons.account_circle, color: Colors.white),
                        //     SizedBox(width: 10),
                        //     Text(
                        //       "Login with Google",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 16,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        InkWell(
                          onTap: () {
                            // Navigate to sign up screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            " Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0),
                    Container(
                      height: 0, // Set the gap below the image
                    ),
                    Container(
                      height: 250, // Set the height for the image
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            10), // Set the gap between the image and buttons
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for text field
Widget inputFile({label, obscureText = false, width = double.infinity, required TextEditingController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        width: width,
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
