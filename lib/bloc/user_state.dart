import 'package:equatable/equatable.dart';
import 'package:staff_app/model/user.dart';

abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);
}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
  final User user;

  LoadedUserState(this.user);
}
