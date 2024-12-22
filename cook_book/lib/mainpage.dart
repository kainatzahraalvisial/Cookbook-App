import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF607D4A), // Background color
          image: DecorationImage(
            image: AssetImage('assets/images/img2.png'),
            fit: BoxFit.cover,
            opacity: 0.35,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Logo and Decorative Top Part
            Expanded(
              flex: 4, // Adjusted flex to give more space to the top section
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 200,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF38422b), // Decorative arc
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    child: Image.asset(
                      'assets/images/img1.png',
                      width: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            // Welcome Text Section
            const Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to CookPal',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF12372a),
                      fontFamily: 'Montserrat.ExtraBold',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8), // Reduced spacing here
                  Text(
                    'Your trusted companion for\n'
                    'discovering, organizing, and\n mastering recipes effortlessly!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFFFAFADA),
                      fontFamily: 'Montserrat.Light',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Buttons Section
            Expanded(
              flex: 3, // Increased space for the button section
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Adjusted alignment to center
                  children: [
                    // "Get Started?" Text
                    const Text(
                      'Get Started?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFAFADA),
                      ),
                    ),
                    const SizedBox(height: 15), // Adjusted spacing

                    // Login Button (Filled)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF12372A), // Filled button color
                        foregroundColor: const Color(0xFFFAFADA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15), // Adjusted spacing

                    // Signup Button (Non-Filled)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            const Color(0xFF12372A), // Outline color
                        side: const BorderSide(
                            color: Color(0xFF12372A), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
