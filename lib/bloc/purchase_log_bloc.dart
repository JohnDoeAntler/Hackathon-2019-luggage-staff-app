import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:staff_app/model/purchase_log.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class PurchaseLogBloc extends Bloc<PurchaseLogEvent, PurchaseLogState> {
  @override
  PurchaseLogState get initialState => InitialPurchaseLogState();

  @override
  Stream<PurchaseLogState> mapEventToState(
    PurchaseLogEvent event,
  ) async* {
    if (event is GetPurchaseLogs) {
      yield LoadingPurchaseLogState();
      final response = await http.get('http://119.246.37.218:3000/purchase_logs?store_id=${event.storeId}');
      List<PurchaseLog> purchaseLogs = List();
      for (dynamic purchaseLog in json.decode(response.body)) {
        purchaseLogs.add(PurchaseLog.fromJson(purchaseLog));
      }
      yield LoadedPurchaseLogState(purchaseLogs);
    }
  }
}
