import 'package:equatable/equatable.dart';
import 'package:flutter_database1/domain/model/contract.dart';

//ignore: must_be_immutable
class Organisation extends Equatable {
  int index;
  String organisation;
  String address;
  String chief;
  List<Contract>? listContracts;

  Organisation(
      {required this.index,
      required this.address,
      required this.chief,
      required this.organisation,
      required this.listContracts});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
