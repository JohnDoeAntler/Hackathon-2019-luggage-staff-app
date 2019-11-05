import 'package:equatable/equatable.dart';
import 'package:staff_app/model/purchase_log.dart';

abstract class PurchaseLogState extends Equatable {
  PurchaseLogState([List props = const []]) : super(props);
}

class InitialPurchaseLogState extends PurchaseLogState {}

class LoadingPurchaseLogState extends PurchaseLogState {}

class LoadedPurchaseLogState extends PurchaseLogState {
  final List<PurchaseLog> purchaseLogs;

  LoadedPurchaseLogState(this.purchaseLogs) : super([purchaseLogs]);
}