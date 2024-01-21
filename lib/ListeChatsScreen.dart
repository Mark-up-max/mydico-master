import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:mydico/allemand.dart';
import 'package:mydico/arabe.dart';
import 'package:mydico/chinois.dart';
import 'package:mydico/cuisineafrique.dart';
import 'package:mydico/espagnol.dart';
import 'package:mydico/italien.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'CONJUGUAISON.dart';
import 'DICTIONNAIRE.dart';
import 'anglais.dart';
import 'chat_screen.dart';
import 'chat_screenn.dart';
import 'anglisfrancais.dart';
import 'cuisine.dart';
import 'dico.dart';
import 'package:flare_flutter/flare_actor.dart';


class BasesDeDonne {
  static const dbName = "wilingomode";
  static const dbVersion = 1;
  static const dbTableMessages = "darkmode";
  static const dbTableSettings = "settings";
  static const columnId = "id";
  static const columnName = "name";
  static const columnIsDarkModeEnabled = "isDarkModeEnabled";

  static final BasesDeDonne instance = BasesDeDonne._();
  late Database _database;

  BasesDeDonne._() {
    initDB();
  }

  Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbTableSettings (
        $columnId INTEGER PRIMARY KEY,
        $columnIsDarkModeEnabled INTEGER
      )
    ''');
  }

  Future<void> setDarkModeEnabled(bool isEnabled) async {
    final db = await database;
    await db.insert(dbTableSettings, {
      columnId: 1,
      columnIsDarkModeEnabled: isEnabled ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> isDarkModeEnabled() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(dbTableSettings);
    if (result.isNotEmpty) {
      return result.first[columnIsDarkModeEnabled] == 1;
    }
    return false;
  }
}


//Base de données pour récupérer le dernier message d'anglais
class BaseDeDonneangl {
  static const dbName = "anglais";
  static const dbVersion = 1;
  static const dbTable = "smsanglais";
  static const columnId = "ideanglais";
  static const columnName = "namesanglais";
  static final BaseDeDonneangl instance = BaseDeDonneangl._();
  late Database _database;

  BaseDeDonneangl._() {
    initDB();
  }
  // Récupère la base de données, en la créant si nécessaire
  Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;
    _database = await initDB();
    return _database;
  }
  // Initialise la base de données en créant le fichier et en ouvrant la connexion
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }
  // Méthode appelée lors de la création de la base de données
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbTable (
        text TEXT,
        isUserMessage BOOL,
        time INTEGER,
        soundUrl TEXT
      )
    ''');
  }
  // Lit tous les messages de la base de données
  Future<List<String>> readMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(dbTable, orderBy: 'time DESC');
    return List.generate(maps.length, (i) {
      return maps[i]['text'] as String;
    });
  }
}


//Base de données pour récupérer le dernier message de français
class BaseDeDonnefranc {
  static const dbName = "lingo";
  static const dbVersion = 1;
  static const dbTable = "sms";
  static const columnId = "ide";
  static const columnName = "names";
  static final BaseDeDonnefranc instance = BaseDeDonnefranc._();
  late Database _database;

  BaseDeDonnefranc._() {
    initDB();
  }
  // Récupère la base de données, en la créant si nécessaire
  Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;
    _database = await initDB();
    return _database;
  }
  // Initialise la base de données en créant le fichier et en ouvrant la connexion
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }
  // Méthode appelée lors de la création de la base de données
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbTable (
        text TEXT,
        isUserMessage BOOL,
        time INTEGER,
        soundUrl TEXT
      )
    ''');
  }
  // Lit tous les messages de la base de données
  Future<List<String>> readMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(dbTable, orderBy: 'time DESC');
    return List.generate(maps.length, (i) {
      return maps[i]['text'] as String;
    });
  }
}



//Base de données pour récupérer le dernier message d'espagnol
class BaseDeDonnesp {
  static const dbName = "espagnol";
  static const dbVersion = 1;
  static const dbTable = "smsespagnol";
  static const columnId = "ideespagnol";
  static const columnName = "namesespagnol";
  static final BaseDeDonnesp instance = BaseDeDonnesp._();
  late Database _database;

  BaseDeDonnesp._() {
    initDB();
  }
  // Récupère la base de données, en la créant si nécessaire
  Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;
    _database = await initDB();
    return _database;
  }
  // Initialise la base de données en créant le fichier et en ouvrant la connexion
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }
  // Méthode appelée lors de la création de la base de données
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbTable (
        text TEXT,
        isUserMessage BOOL,
        time INTEGER,
        soundUrl TEXT
      )
    ''');
  }
  // Lit tous les messages de la base de données
  Future<List<String>> readMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(dbTable, orderBy: 'time DESC');
    return List.generate(maps.length, (i) {
      return maps[i]['text'] as String;
    });
  }
}



//Base de données pour récupérer le dernier message de chinois
class BaseDeDonnechin {
  static const dbName = "chinois";
  static const dbVersion = 1;
  static const dbTable = "smschinois";
  static const columnId = "idechinois";
  static const columnName = "nameschinois";

  static final BaseDeDonnechin instance = BaseDeDonnechin._();
  late Database _database;

  BaseDeDonnechin._() {
    initDB();
  }

  // Récupère la base de données, en la créant si nécessaire
  Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;
    _database = await initDB();
    return _database;
  }

  // Initialise la base de données en créant le fichier et en ouvrant la connexion
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }

  // Méthode appelée lors de la création de la base de données
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbTable (
        text TEXT,
        isUserMessage BOOL,
        time INTEGER,
        soundUrl TEXT
      )
    ''');
  }

  // Lit tous les messages de la base de données
  Future<List<String>> readMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(dbTable, orderBy: 'time DESC');
    return List.generate(maps.length, (i) {
      return maps[i]['text'] as String;
    });
  }
}



//Base de données pour récupérer le dernier message d'italien
class BaseDeDonneital {
  static const dbName = "ChatScreen ";
  static const dbVersion = 1;
  static const dbTable = "smsChatScreen ";
  static const columnId = "ideChatScreen ";
  static const columnName = "namesChatScreen ";
  static final BaseDeDonneital instance = BaseDeDonneital._();
  late Database _database;

  BaseDeDonneital._() {
    initDB();
  }
  // Récupère la base de données, en la créant si nécessaire
  Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;
    _database = await initDB();
    return _database;
  }
  // Initialise la base de données en créant le fichier et en ouvrant la connexion
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }
  // Méthode appelée lors de la création de la base de données
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbTable (
        text TEXT,
        isUserMessage BOOL,
        time INTEGER,
        soundUrl TEXT
      )
    ''');
  }
  // Lit tous les messages de la base de données
  Future<List<String>> readMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(dbTable, orderBy: 'time DESC');
    return List.generate(maps.length, (i) {
      return maps[i]['text'] as String;
    });
  }
}



//Base de données pour récupérer le dernier message d'arabe
class BaseDeDonnearab {
  static const dbName = "arabe";
  static const dbVersion = 1;
  static const dbTable = "smsarabe";
  static const columnId = "idearabe";
  static const columnName = "namesarabe";
  static final BaseDeDonnearab instance = BaseDeDonnearab._();
  late Database _database;

  BaseDeDonnearab._() {
    initDB();
  }
  // Récupère la base de données, en la créant si nécessaire
  Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;
    _database = await initDB();
    return _database;
  }
  // Initialise la base de données en créant le fichier et en ouvrant la connexion
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }
  // Méthode appelée lors de la création de la base de données
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbTable (
        text TEXT,
        isUserMessage BOOL,
        time INTEGER,
        soundUrl TEXT
      )
    ''');
  }
  // Lit tous les messages de la base de données
  Future<List<String>> readMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(dbTable, orderBy: 'time DESC');
    return List.generate(maps.length, (i) {
      return maps[i]['text'] as String;
    });
  }
}



//Base de données pour récupérer le dernier message d'allemand
class BaseDeDonneall {
  static const dbName = "allemand";
  static const dbVersion = 1;
  static const dbTable = "smsallemand";
  static const columnId = "ideallemand";
  static const columnName = "namesallemand";

  static final BaseDeDonneall instance = BaseDeDonneall._();
  late Database _database;

  BaseDeDonneall._() {
    initDB();
  }

  // Récupère la base de données, en la créant si nécessaire
  Future<Database> get database async {
    if (_database != null && _database.isOpen) return _database;
    _database = await initDB();
    return _database;
  }

  // Initialise la base de données en créant le fichier et en ouvrant la connexion
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }

  // Méthode appelée lors de la création de la base de données
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dbTable (
        text TEXT,
        isUserMessage BOOL,
        time INTEGER,
        soundUrl TEXT
      )
    ''');
  }
  // Lit tous les messages de la base de données
  Future<List<String>> readMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(dbTable, orderBy: 'time DESC');
    return List.generate(maps.length, (i) {
      return maps[i]['text'] as String;
    });
  }
}






class ListeChatsScreen extends StatefulWidget {
  @override
  _ListeChatsScreenState createState() => _ListeChatsScreenState();
}

class _ListeChatsScreenState extends State<ListeChatsScreen> with SingleTickerProviderStateMixin {
  final List<String> chats = [
    'Dictionnaire Français',
    'Dictionnaire Anglais',
    'Dictionnaire Espagnol',
    'Dictionnaire Chinois',
    'Dictionnaire Italien',
    'Dictionnaire Arabe',
    'Dictionnaire Allemand',
  ];

  final List<String> chatImages = [
    'images/avatar.png',
    'images/ima.jpg',
    'images/dico.jpg',
    'images/dictionnaire.jpg',
    'images/ima.jpg',
    'images/OIP (2).jpg',
    'images/dictionnaire.jpg',
  ];

  int _currentPage = 0; // Indice de la page actuelle

  late TabController _tabController;
  bool isDarkModeEnabled = false;
  String dernierEnregistrement = '';
  String dernierEnregistrementangl = '';
  String dernierEnregistrementesp = '';
  String dernierEnregistrementchin = '';
  String dernierEnregistrementital = '';
  String dernierEnregistrementarab = '';
  String dernierEnregistrementall = '';
  final String email = 'markmbala027@gmail.com'; // Remplacez par votre adresse e-mail



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    initDarkMode(); // Utilisez await pour attendre la fin de l'initialisation
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      recupererDernierEnregistrement();
      recupererDernierEnregistrementangl();
      recupererDernierEnregistrementesp();
      recupererDernierEnregistrementchin();
      recupererDernierEnregistrementital();
      recupererDernierEnregistrementarab();
      recupererDernierEnregistrementall();
    });
  }


  Future<void> initDarkMode() async {
    await BasesDeDonne.instance.initDB(); // Initialisation de la base de données
    bool darkModeEnabled = await BasesDeDonne.instance.isDarkModeEnabled();
    setState(() {
      isDarkModeEnabled = darkModeEnabled;
    });
  }

//Fonction pour dernier enregistrement de français
  Future<void> recupererDernierEnregistrement() async {
    await BaseDeDonnefranc.instance.initDB(); // Initialisation de la base de données
    final messages = await BaseDeDonnefranc.instance.readMessages();
    setState(() {
      dernierEnregistrement = messages.first;
    });
  }


  //Fonction pour dernier enregistrement d'anglais
  Future<void> recupererDernierEnregistrementangl() async {
    await BaseDeDonnefranc.instance.initDB(); // Initialisation de la base de données
    final messages = await BaseDeDonneangl.instance.readMessages();
    setState(() {
      dernierEnregistrementangl = messages.first;
    });
  }


  //Fonction pour dernier enregistrement d'espagnole
  Future<void> recupererDernierEnregistrementesp() async {
    await BaseDeDonnefranc.instance.initDB(); // Initialisation de la base de données
    final messages = await BaseDeDonnesp.instance.readMessages();
    setState(() {
      dernierEnregistrementesp = messages.first;
    });
  }


  //Fonction pour dernier enregistrement de chinois
  Future<void> recupererDernierEnregistrementchin() async {
    await BaseDeDonnefranc.instance.initDB(); // Initialisation de la base de données
    final messages = await BaseDeDonnechin.instance.readMessages();
    setState(() {
      dernierEnregistrementchin = messages.first;
    });
  }


  //Fonction pour dernier enregistrement d'italien
  Future<void> recupererDernierEnregistrementital() async {
    await BaseDeDonnefranc.instance.initDB(); // Initialisation de la base de données
    final messages = await BaseDeDonneital.instance.readMessages();
    setState(() {
      dernierEnregistrementital = messages.first;
    });
  }


  //Fonction pour dernier enregistrement de chinois
  Future<void> recupererDernierEnregistrementarab() async {
    await BaseDeDonnefranc.instance.initDB(); // Initialisation de la base de données
    final messages = await BaseDeDonnearab.instance.readMessages();
    setState(() {
      dernierEnregistrementarab = messages.first;
    });
  }


  //Fonction pour dernier enregistrement d'allemand
  Future<void> recupererDernierEnregistrementall() async {
    await BaseDeDonnefranc.instance.initDB(); // Initialisation de la base de données
    final messages = await BaseDeDonneall.instance.readMessages();
    setState(() {
      dernierEnregistrementall = messages.first;
    });
  }




  void toggleDarkMode() async {
    bool darkModeEnabled = !isDarkModeEnabled;
    await BasesDeDonne.instance.setDarkModeEnabled(darkModeEnabled);
    setState(() {
      isDarkModeEnabled = darkModeEnabled;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  // La fonction pour couper le texte avec des points de suspension
  String couperTexte(String texte, int longueurMax) {
    if (texte.length <= longueurMax) {
      return texte;
    } else {
      return '${texte.substring(0, longueurMax)}...';
    }
  }


  // Gérer l'affichage du bouton flottant
  void _handleTabChange() {
    setState(() {
      _currentPage = _tabController.index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final List<String> chattext = [
      dernierEnregistrement,
      dernierEnregistrementangl,
      dernierEnregistrementesp,
      dernierEnregistrementchin,
      dernierEnregistrementital,
      dernierEnregistrementarab,
      dernierEnregistrementall,
    ];

    // Rendre la barre d'état transparente avec des icônes noires ou inverse
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    isDarkModeEnabled ? FlutterStatusbarcolor.setStatusBarWhiteForeground(true) : FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    isDarkModeEnabled ? FlutterStatusbarcolor.setNavigationBarColor(Colors.teal) : FlutterStatusbarcolor.setNavigationBarColor(Colors.teal);
    isDarkModeEnabled ? FlutterStatusbarcolor.setNavigationBarWhiteForeground(false) : FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkModeEnabled ? Colors.teal : Colors.teal,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: isDarkModeEnabled ? AssetImage('images/fondclair.jpg') : AssetImage('images/ima.jpg'),
              ),
              SizedBox(width: 8.0),
              Text(
                'Wilingo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: isDarkModeEnabled ? Colors.white : Colors.white,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.white60,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  'Discussions',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Paramètres',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.teal,
            ),
            TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                  itemCount: chats.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (chats[index] == 'Dictionnaire Anglais') {
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  anglais(chatName: 'Français - Anglais', index: 0, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  anglais(chatName: 'Français - Anglais', index: 0, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == 'Cuisine') {
                          String jeuUrl = 'https://www.cuisineaz.com/recettes/filets-de-poulet-panes-55434.aspx';
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => cuisine(url: jeuUrl, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => cuisine(url: jeuUrl, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == 'Dictionnaire Allemand') {
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  allemand(chatName: 'Français - Allemand', index: 0, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  allemand(chatName: 'Français - Allemand', index: 0, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == 'Dictionnaire Espagnol') {
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  espagnol(chatName: 'Français - Espagnol', index: 0, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  espagnol(chatName: 'Français - Espagnol', index: 0, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == 'Dictionnaire Chinois') {
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  chinois(chatName: 'Français - Chinois', index: 0, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  chinois(chatName: 'Français - Chinois', index: 0, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == 'Conjugaison') {
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CONJUGUAISON(isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CONJUGUAISON(isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == 'Dictionnaire Italien') {
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  italien(chatName: 'Français - Italien', index: 0, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  italien(chatName: 'Français - Italien', index: 0, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == 'Dictionnaire Français') {
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(chatName: 'Français', index: 0, isDarkModeEnabled: true,),
                              ),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(chatName: 'Français', index: 0, isDarkModeEnabled: false,),
                              ),
                            );
                          }
                        }

                        else if (chats[index] == 'Dictionnaire Arabe') {
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  arabe(chatName: 'Français - Arabe', index: 0, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  arabe(chatName: 'Français - Arabe', index: 0, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        /*else if (chats[index] == 'Traducteur') {
                          String jeuUrl = 'https://www.deepl.com/translator';
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TraducteurScreen(url: jeuUrl, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TraducteurScreen(url: jeuUrl, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == 'Jeux') {
                          String jeuUrl = 'https://jeux.larousse.fr/';
                          if(isDarkModeEnabled){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => cuisine(url: jeuUrl, isDarkModeEnabled: true,)),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => cuisine(url: jeuUrl, isDarkModeEnabled: false,)),
                            );
                          }
                        }

                        else if (chats[index] == '[Paramètre 1]') {
                          toggleDarkMode();
                        }*/
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        elevation: 25.0,
                        color: Colors.white.withOpacity(0.85),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(chatImages[index]),
                            radius: 14,
                          ),
                          //Titre et sous titre des catégories
                          title: Center(
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    chats[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AutofillHints.birthday,
                                      fontSize: 17.0,
                                      color: isDarkModeEnabled ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0), // Ajustez cet espacement selon vos préférences
                                Text(
                                  couperTexte(chattext[index], 70), // Remplacez 50 par la longueur maximale souhaitée
                                  style: TextStyle(
                                    fontSize: 14.0, // Ajustez la taille du sous-titre selon vos préférences
                                    color: isDarkModeEnabled ? Colors.black : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  color: Colors.teal,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 80.0),
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      CircleAvatar(
                        backgroundImage: isDarkModeEnabled ? AssetImage('images/fondclair.jpg') : AssetImage('images/ima.jpg'),
                        radius: 50.0,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Wilingo',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: isDarkModeEnabled ? Colors.white : Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 32.0),
                        elevation: 25.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        /*child: ListTile(
                          onTap: toggleDarkMode,
                          leading: Icon(
                            isDarkModeEnabled ? Icons.check_box : Icons.check_box_outline_blank,
                            color: isDarkModeEnabled ? Colors.blueAccent : Colors.grey,
                          ),
                          title: Text(
                            isDarkModeEnabled ? 'Désactiver le mode sombre' : 'Activer le mode sombre',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: isDarkModeEnabled ? Colors.white : Colors.black,
                            ),
                          ),
                        ),*/
                        child: ListTile(
                          onTap: toggleDarkMode,
                          title: Center(
                            child: Text(
                              'Sauvegarder mes discussion',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: isDarkModeEnabled ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.0),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 32.0),
                        elevation: 25.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ListTile(
                          onTap: _launchEmailApp, // Appel de la fonction pour ouvrir l'application de messagerie
                          title: Center(
                            child: Text(
                              'Contactez-nous',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: _currentPage == 0
            ?Stack(
          children: [
            FloatingActionButton(
              onPressed: () {
                // Ajoutez ici le code à exécuter lorsque le bouton est pressé
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        DICTIONNAIRE(isDarkModeEnabled: true,),
                    ));
                print('Bouton flottant pressé !');
              },
              child: Icon(Icons.messenger), // Remplacez par l'icône de votre choix
              elevation: 20.0, // Ajustez la valeur selon vos préférences
              backgroundColor: Colors.teal, // Ajoutez la couleur de fond verte
            ),
          ],
        ) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void _launchEmailApp() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(params.toString())) {
      await launch(params.toString());
    } else {
      throw 'Impossible de lancer l\'application de messagerie';
    }
  }
}

class TraducteurScreen extends StatelessWidget {
  final String url;
  final bool isDarkModeEnabled;

  TraducteurScreen ({required this.url, required this.isDarkModeEnabled});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkModeEnabled ? Colors.black54 : Colors.white,
        title: Text('Traducteur',
            style:
            TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkModeEnabled ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}


class JeuxScreen extends StatelessWidget {
  final String url;
  final bool isDarkModeEnabled;

  JeuxScreen ({required this.url, required this.isDarkModeEnabled});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkModeEnabled ? Colors.black54 : Colors.white,
        title: Text('Jeux',
            style:
            TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
            )),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}



