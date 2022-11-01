part of 'table_organisation_bloc.dart';

@immutable
abstract class TableOrganisationState {}

class TableOrganisationInitial extends TableOrganisationState {
  List<PlutoRow> rowsInic = rowse;
}

class TableOrganisationInitialState extends TableOrganisationState {
  List<PlutoRow> rowsConsumers;

  TableOrganisationInitialState(this.rowsConsumers);
}

List<PlutoRow> rowse = [
  PlutoRow(
    cells: {
      'text_field': PlutoCell(value: 'Text cell value1'),
      'text_Adres': PlutoCell(value: 'item1'),
      'text_Chief': PlutoCell(value: '2020-08-06'),
    },
  ),
  PlutoRow(
    cells: {
      'text_field': PlutoCell(value: 'Text cell value2'),
      'text_Adres': PlutoCell(value: 'item2'),
      'text_Chief': PlutoCell(value: '2020-08-07'),
    },
  ),
];
