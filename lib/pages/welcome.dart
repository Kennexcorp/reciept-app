import 'package:flutter/material.dart';
import 'package:my_reciepts/pages/login.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
 Widget _currentPage;
  int _currentIndex = 0;
  List _listPages = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listPages..add(Login());
    _currentPage = Login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('Bottom Navigation')),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0), child: Login())),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
        //     // BottomNavigationBarItem(
        //     //     icon: Icon(Icons.app_registration), label: 'Signup'),
        //   ],
        //   onTap: (selectedIndex) => _changePage(selectedIndex),
        // ),
        
        );
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }
}
