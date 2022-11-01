import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../domain/use_case/table_organisation/table_organisation_bloc.dart';

List<PlutoColumn> columns = [
  /// Text Column definition
  PlutoColumn(
    title: 'Organisation',
    field: 'text_field',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Adres',
    field: 'text_Adres',
    type: PlutoColumnType.text(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Chief',
    field: 'text_Chief',
    type: PlutoColumnType.text(),
  ),
];

List<PlutoRow> rows = [
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

class TableCustomers extends StatefulWidget {
  const TableCustomers({Key? key, required this.tableOrganisationBloc})
      : super(key: key);

  final TableOrganisationBloc tableOrganisationBloc;
  @override
  State<TableCustomers> createState() =>
      _TableCustomersState(tableOrganisationBloc: tableOrganisationBloc);
}

class _TableCustomersState extends State<TableCustomers> {
  int currentRow = -1;
  // var tableOrganisationBloc = TableOrganisationBloc();
  final TableOrganisationBloc tableOrganisationBloc;
  late List<PlutoRow> rows;

  _TableCustomersState({required this.tableOrganisationBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableOrganisationBloc, TableOrganisationState>(
      bloc: tableOrganisationBloc,
      builder: (context, state) {
        if (state is TableOrganisationInitialState) {
          rows = state.rowsConsumers;
        }
        if (state is TableOrganisationInitial) {
          rows = state.rowsInic;
        }
        return PlutoGrid(
          mode: PlutoGridMode.selectWithOneTap,
          columns: columns,
          rows: state is TableOrganisationInitialState
              ? rows = state.rowsConsumers
              : rows,
          onSelected: (PlutoGridOnSelectedEvent event) {
            print(state.toString());
            print(event.rowIdx);
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            //print(event.rowIdx);
          },
        );
      },
    );
  }
/*  var _rows = rows;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      mode: PlutoGridMode.selectWithOneTap,
      columns: columns,
      rows: _rows,
      onSelected: (PlutoGridOnSelectedEvent event) {
        print(rows.toString());
        setState(() {
          _rows = rows;
        });
      },
      onChanged: (PlutoGridOnChangedEvent event) {
        //print(event.rowIdx);
      },
    );
  }*/
}
