import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_app/bloc/bloc.dart';
import 'package:staff_app/ui/home.dart';
import 'package:staff_app/ui/login.dart';
import 'package:staff_app/ui/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final StoreBloc storeBloc = StoreBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: storeBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/log': (context) => HomePage()
        },
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    storeBloc.dispose();
  }
}