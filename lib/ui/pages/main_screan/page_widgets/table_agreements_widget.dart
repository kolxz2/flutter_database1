import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../domain/use_case/table_organisation/table_organisation_bloc.dart';

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

class TableAgreements extends StatefulWidget {
  const TableAgreements({Key? key}) : super(key: key);

  @override
  State<TableAgreements> createState() => _TableAgreementsState();
}

class _TableAgreementsState extends State<TableAgreements> {
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TableOrganisationBloc, TableOrganisationInitState>(
      listener: (context, state) {
        if (state is TableContractState) {
          stateManager.removeAllRows();
          stateManager.appendRows(state.contractsRows);
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
            tableOrganisationBloc
                .add(ChangedSelectedContractEvent(selectedRow: event.rowIdx));
            //  print(event.rowIdx);
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            // print(event);
          },
          onLoaded: (PlutoGridOnLoadedEvent event) =>
          stateManager = event.stateManager,
        );
      },
    );
  }
}
