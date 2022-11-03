import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../domain/use_case/table_organisation/table_organisation_bloc.dart';

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

class TableCustomers extends StatefulWidget {
  const TableCustomers({Key? key}) : super(key: key);

  @override
  State<TableCustomers> createState() => _TableCustomersState();
}

class _TableCustomersState extends State<TableCustomers> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TableOrganisationBloc, TableOrganisationInitState>(
      listener: (context, state) {
        if (state is TableOrganisationState) {
          stateManager.removeAllRows();
          stateManager.appendRows(state.organisationsRows);
        }
      },
      builder: (context, state) {
        return PlutoGrid(
          mode: PlutoGridMode.selectWithOneTap,
          columns: columns,
          rows: [],
          onSelected: (PlutoGridOnSelectedEvent event) {
            final tableOrganisationBloc =
                BlocProvider.of<TableOrganisationBloc>(context);
            tableOrganisationBloc.add(
                ChangedSelectedOrganisationEvent(selectedRow: event.rowIdx));
            print(event.rowIdx);
          },
          onLoaded: (event) => stateManager = event.stateManager,
        );
      },
    );
  }
}
