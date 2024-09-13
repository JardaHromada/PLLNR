import 'package:flutter/material.dart'; // dart import

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:plnn_test1/screens/auth_page.dart';
import 'package:plnn_test1/screens/settings_screen.dart';
import 'screens/home_screen.dart'; 
import 'screens/sign_in_screen.dart'; //screen import
import 'screens/login_screen.dart';
import 'screens/mytasks_screen.dart';
import 'screens/groups_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/chat_screen.dart';

import 'package:firebase_core/firebase_core.dart'; // firebase import
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLLNR' ,
      locale: Locale('cs'), // Set the locale to Czech
      supportedLocales: [
        Locale('en'), // English
        Locale('cs'), // Czech
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      routes: {
        '/signIn': (context) => SignInScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/auth': (context) => AuthPage(),
        '/mytasks': (context) => MyTaskScreen(),
        '/groups': (context) => GroupsScreen(),
        '/settings': (context) => SettingsScreen(),
        '/chat': (context) => ChatScreen(),
        '/goals': (context) => GoalsScreen(),
      },
    );
  }
}
