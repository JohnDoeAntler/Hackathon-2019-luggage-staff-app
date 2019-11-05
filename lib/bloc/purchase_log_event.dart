import 'package:equatable/equatable.dart';

abstract class PurchaseLogEvent extends Equatable {
  PurchaseLogEvent([List props = const []]) : super(props);
}

class GetPurchaseLogs extends PurchaseLogEvent {
  final int storeId;

  GetPurchaseLogs(this.storeId) : super([storeId]);
}