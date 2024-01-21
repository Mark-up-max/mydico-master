import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'ListeChatsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Durée de l'animation
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Lancer l'animation d'apparition
    _animationController.forward().then((_) {
      // Naviguer vers l'écran suivant après l'animation d'apparition
      Timer(Duration(seconds: 2), () {
        // Lancer l'animation de disparition
        _animationController.reverse().then((_) {
          // Naviguer vers l'écran suivant après l'animation de disparition
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ListeChatsScreen()),
          );
        });
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Rendre la barre d'état transparente avec des icônes noires
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    return Scaffold(
      backgroundColor: Colors.white, // Fond de la vue en couleur blanche
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation, // Utilisation de l'animation de fondu
          child: Image.asset(
            'images/logo.jpg',
            width: 14000.0,
            height: 15000.0,
          ),
        ),
      ),
    );
  }
}
