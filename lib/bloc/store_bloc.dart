import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  @override
  StoreState get initialState => InitialStoreState();

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetStore) {
      yield LoadingStoreState();

      final response = await http.get('http://119.246.37.218:3000/auth?username=${event.username}&password=${event.password}');
      final obj = json.decode(response.body);

      if (!obj.containsKey('error')) {
        yield LoadedStoreState(obj['token']);
      } else {
        yield ErrorStoreState(obj['error']);
      }
    } else if (event is ResetStore) {
      print('tes');
      yield InitialStoreState();
    }
  }
}
