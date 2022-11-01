import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Contract extends Equatable {
  int clientNum;
  int contractNum;
  DateTime date;
  double sum;

  Contract(
      {required this.clientNum,
      required this.contractNum,
      required this.date,
      required this.sum});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
