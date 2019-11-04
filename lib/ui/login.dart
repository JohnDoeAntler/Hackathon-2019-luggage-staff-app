import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_app/bloc/bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String username;
  String password;

  @override
  Widget build(BuildContext context) {

    final storeBloc = BlocProvider.of<StoreBloc>(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(0x00, 0x64, 0x5A, 1),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Opacity(
              opacity: 0.2,
              child: Image.network(
                'https://images.pexels.com/photos/65438/pexels-photo-65438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox.expand(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  CircleAvatar(
                    radius: 80,
                    child: FlutterLogo(
                      size: 160,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Welcome back, User',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 32,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.confirmation_number),
                            labelText: 'Username',
                            hintText: 'Please enter the username here.',
                            labelStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white54
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white70
                          ),
                          autofocus: true,
                          onChanged: (username) {
                            setState(() {
                              this.username = username;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.confirmation_number),
                            labelText: 'Password',
                            hintText: 'Please enter the password here.',
                            labelStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white54
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white70
                          ),
                          onChanged: (password) {
                            setState(() {
                              this.password = password;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Enim aute consectetur cupidatat sunt quis ut anim ea irure deserunt ullamco adipisicing eiusmod irure. Qui eiusmod ipsum non aliquip dolor do irure irure. Enim nisi ex mollit excepteur et aliqua id irure.',
                          style: TextStyle(
                            color: Colors.white54
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        BlocListener(
                          bloc: storeBloc,
                          listener: (context, state) {
                            if (state is ErrorStoreState) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(state.message),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close')
                                      ),
                                    ],
                                  );
                                }
                              );
                            } else if (state is LoadedStoreState) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: BlocBuilder(
                            bloc: storeBloc,
                            builder: (context, state) {
                              if(state is LoadingUserState) {
                                return CircularProgressIndicator();
                              } else {
                                return LoginButton(username, password);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

class LoginButton extends StatelessWidget {
  
  final String username;
  final String password;

  const LoginButton(
    this.username,
    this.password
  );

  @override
  Widget build(BuildContext context) {

    final storeBloc = BlocProvider.of<StoreBloc>(context);

    return ButtonTheme(
      minWidth: 400,
      height: 50,
      child: FlatButton(
        color: Colors.transparent,
        onPressed: () {
          storeBloc.dispatch(GetStore(
            username: this.username,
            password: this.password
          ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.blueAccent)
        ),
        splashColor: Colors.blueAccent,
        child: Text(
          'Login'.toUpperCase(),
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}