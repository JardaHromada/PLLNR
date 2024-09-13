import 'package:flutter/material.dart'; //flutter import
import 'package:firebase_auth/firebase_auth.dart'; //firabase import

class GroupsScreen extends StatelessWidget {
  GroupsScreen({super.key});

final user = FirebaseAuth.instance.currentUser!;

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF0E181E),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildProfileSection(context),
          Expanded(child: Container()), // Placeholder for the main content
          _buildBottomBar(context),
        ],
      ),
    ),
  );
}


  Widget _buildProfileSection(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    color: Color(0xFF0E181E),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Přihlášen jako: ${user.email!}',
          style: const TextStyle(
            color: Color(0xFFE0F0FF),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
          ),
        ),
        IconButton(
          icon: Icon(Icons.logout, color: Color(0xFFE0F0FF)), // Log out icon
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/home'); // Redirect to home page after logout
            } catch (e) {
              // Handle errors if any occur during sign out
              print('Error signing out: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to sign out. Please try again.')),
              );
            }
          },
        ),
      ],
    ),
  );
}

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xFF12222B),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarButton(context, 'skupiny', Icons.group, '/groups', isSpecial: true),
          _buildBottomBarButton(context, 'cíle', Icons.flag, '/goals'),
          _buildBottomBarButton(context, 'úkoly', Icons.task, '/mytasks'),
          _buildBottomBarButton(context, 'chat', Icons.chat, '/chat'),
          _buildBottomBarButton(context, 'nastavení', Icons.settings, '/settings'),
        ],
      ),
    );
  }

  Widget _buildBottomBarButton(BuildContext context, String label, IconData icon, String route, {bool isSpecial = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSpecial)
          Container(
            width: 64,
            height: 32,
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 35, 74, 97),
            borderRadius: BorderRadius.circular(32), 
          ),
            child: IconButton(
              icon: Icon(icon, size: 24, color: Colors.white),
              onPressed: () {
              },
            ),
          )
        else
          IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
          ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFD7E2FF),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.50,
          ),
        ),
      ],
    );
  }
}

