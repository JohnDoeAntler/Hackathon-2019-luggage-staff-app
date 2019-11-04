import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StoreEvent extends Equatable {
  StoreEvent([List props = const []]) : super(props);
}

class GetStore extends StoreEvent {
  final String username;
  final String password;
  
  GetStore({
    @required this.username,
    @required this.password,
  });
}

class ResetStore extends StoreEvent {}