import 'package:flutter/material.dart';
import 'package:staff_app/bloc/bloc.dart';
import 'package:staff_app/ui/log.dart';
import 'package:staff_app/ui/tiers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget w = TiersPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Luggage Management System"),
              accountEmail: Text("Hackathon 2019"),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0x00, 0x64, 0x5A, 1)
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      "https://pbs.twimg.com/profile_images/526631556341719040/PGyxRgFH_400x400.jpeg",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Reward tiers'),
              leading: Icon(Icons.account_balance),
              onTap: () {
                setState(() {
                  w = TiersPage();
                });
                Navigator.pop(context);
              },
            ),
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black12)
                )
              ),
            ),
            ListTile(
              title: Text('Log'),
              leading: Icon(Icons.history),
              onTap: () {
                setState(() {
                  w = LogPage();
                });
                Navigator.pop(context);
              },
            ),
            Container(
              height: 1.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black12)
                )
              ),
            ),
            ListTile(
              title: Text('Sign Out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                final storeBloc = BlocProvider.of<StoreBloc>(context);
                storeBloc.dispatch(ResetStore());
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        switchInCurve: Curves.easeInQuint,
        switchOutCurve: Curves.easeInQuint,
        duration: Duration(
          seconds: 1
        ),
        child: w,
      )
    );
  }
}