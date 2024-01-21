import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'allemand.dart';
import 'anglais.dart';
import 'arabe.dart';
import 'chat_screen.dart';
import 'anglisfrancais.dart';
import 'chinois.dart';
import 'espagnol.dart';
import 'italien.dart';

class DICTIONNAIRE extends StatelessWidget {
  final List<String> chats = [
    '[Français - Chinois]',
    '[Français - Anglais]',
    '[Français - Allemand]',
    '[Français - Espagnol]',
    '[Français - Italien]',
    '[Français - Arabe]'
  ];

  final List<String> chatImages = [
    'images/chinois.png',
    'images/télécharger.jpg',
    'images/imana.jpg',
    'images/avnoir.png',
    'images/avnoir.png',
    'images/télécharger.png',
  ];

  bool isDarkModeEnabled;
  DICTIONNAIRE({required this.isDarkModeEnabled});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: isDarkModeEnabled? Colors.black : Colors.white,
          leading: IconButton(
            icon: Icon(
                Icons.arrow_back,
                color: isDarkModeEnabled? Colors.white : Colors.black
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Dictionnaire Bilingue',  style: TextStyle(
            color: isDarkModeEnabled ? Colors.white : Colors.black,
          ),
          ),
          centerTitle: true, // Centrer le texte dans la AppBar
        ),
        body: Center(
          child: SvgPicture.asset('images/Sale.svg'),
        )
    );
  }
}

