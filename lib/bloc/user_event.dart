import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

class GetUser extends UserEvent {
  final int userId;

  GetUser(this.userId);
}