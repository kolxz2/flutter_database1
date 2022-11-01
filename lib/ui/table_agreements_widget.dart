import "package:flutter/material.dart";
import 'package:pluto_grid/pluto_grid.dart';

List<PlutoColumn> columns = [
  /// Number Column definition
  PlutoColumn(
    title: 'Contract coast',
    field: 'number_field',
    type: PlutoColumnType.number(),
  ),

  /// Datetime Column definition
  PlutoColumn(
    title: 'Contract date',
    field: 'date_field',
    type: PlutoColumnType.date(),
  ),
];

List<PlutoRow> rows = [
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2020),
      'date_field': PlutoCell(value: '2020-08-06'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2021),
      'date_field': PlutoCell(value: '2020-08-07'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
  PlutoRow(
    cells: {
      'number_field': PlutoCell(value: 2022),
      'date_field': PlutoCell(value: '2020-08-08'),
    },
  ),
];

class TableAgreements extends StatefulWidget {
  const TableAgreements({Key? key}) : super(key: key);

  @override
  State<TableAgreements> createState() => _TableAgreementsState();
}

class _TableAgreementsState extends State<TableAgreements> {
  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
        columns: columns,
        rows: rows,
        onChanged: (PlutoGridOnChangedEvent event) {
          // print(event);
        },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          print(event);
        });
  }
}
