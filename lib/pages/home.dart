import 'package:flutter/material.dart';
import 'package:my_reciepts/pages/salesPage.dart';
import 'settings.dart';
import 'invoices.dart';
import 'dashboard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _currentPage;
  int _currentIndex = 0;
  List _listPages = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listPages..add(Dashboard())..add(InvoiceList())..add(SalesPage());
    _currentPage = Dashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('Bottom Navigation')),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0), child: _currentPage)),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Sales'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt), label: 'Invoices'),
            
          ],
          onTap: (selectedIndex) => _changePage(selectedIndex),
        ),
        
        );
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }
}
