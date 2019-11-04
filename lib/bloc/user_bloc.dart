import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:staff_app/model/user.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUser) {
      yield LoadingUserState();
      final response = await http.get('http://119.246.37.218:3000/users/${event.userId}');
      yield LoadedUserState(User.fromJson(json.decode(response.body))); 
    }
  }
}
