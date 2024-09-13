import 'package:flutter/material.dart'; // import flutter

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            children: [
              
              const SizedBox(height: 74),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                decoration: ShapeDecoration(
                  color: const Color(0xFF12222B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(56),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'PLLNR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 74),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2F4156),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Přihlásit se',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD7E2FF),
                        fontSize: 30,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signIn');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2F4156),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Registrovat se',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD7E2FF),
                        fontSize: 30,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
