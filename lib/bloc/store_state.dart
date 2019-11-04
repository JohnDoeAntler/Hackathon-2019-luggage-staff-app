import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  StoreState([List props = const []]) : super(props);
}

class InitialStoreState extends StoreState {}

class LoadingStoreState extends StoreState {}

class LoadedStoreState extends StoreState {
  final String token;

  LoadedStoreState(this.token);
}

class ErrorStoreState extends StoreState {
  final String message;
  
  ErrorStoreState(this.message);
}
