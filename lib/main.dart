import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'books_screen.dart';
import 'about_screen.dart';
import 'chatbot_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 93, 114, 27),),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BooksScreen(),
    chatbotScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Store', 
        style: TextStyle(
                  color: Color.fromARGB(255, 45, 45, 45),
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
                ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 160, 212, 5),
              ),
              accountName: Text(
                'Menu',
                style: TextStyle(
                  color: Color.fromARGB(255, 49, 58, 66),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              accountEmail: Text(
                'Store',
                style: TextStyle(fontSize: 16,
                  color: Color.fromARGB(255, 49, 58, 66),),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/library.png'),
              ),
            ),
            const ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage('assets/photo.png')),
              title: Text(
                'AKASH RASHMIKARA',
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                'Administrator',
                style: TextStyle(fontSize: 13),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Home'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Store'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Chatbot'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('About'),
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}