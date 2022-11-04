import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_database1/data/repositoy/tables_repositoy_impl.dart';
import 'package:flutter_database1/domain/use_case/table_organisation/table_organisation_bloc.dart';
import 'package:flutter_database1/main.dart';

import '../../../../domain/repository/tables_repository.dart';
import '../../../const/button_styles.dart';
import 'alert_dialogs/add_contract.dart';
import 'alert_dialogs/add_organisation.dart';
import 'alert_dialogs/edit_contract.dart';
import 'alert_dialogs/edit_organisation.dart';

class TablesEditor extends StatefulWidget {
  const TablesEditor({
    Key? key,
  }) : super(key: key);

  @override
  State<TablesEditor> createState() => _TablesEditorState();
}

class _TablesEditorState extends State<TablesEditor> {
  final TablesRepository repository = TablesRepositoryImplementation();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {
                final tableOrganisationBloc =
                    BlocProvider.of<TableOrganisationBloc>(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddOrganisationAlert(
                          tableOrganisationBloc: tableOrganisationBloc);
                    });
              },
              child: const Text("New organisation")),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {
                final tableOrganisationBloc =
                    BlocProvider.of<TableOrganisationBloc>(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return EditOrganisationAlert(
                          tableOrganisationBloc: tableOrganisationBloc);
                    });
              },
              child: const Text("Edit organisation")),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {
                final tableOrganisationBloc =
                    BlocProvider.of<TableOrganisationBloc>(context);
                tableOrganisationBloc
                    .add(DeleteOrganisationEvent(repository: repository));
              },
              child: const Text("Delete organisation")),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {
                final tableOrganisationBloc =
                    BlocProvider.of<TableOrganisationBloc>(context);
                // _addContractAlert(tableOrganisationBloc);
                showDialog(
                    context: navigatorKey.currentContext!,
                    builder: (context) => AddContractAlert(
                        tableOrganisationBloc: tableOrganisationBloc));
              },
              child: const Text("New contract")),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {
                final tableOrganisationBloc =
                    BlocProvider.of<TableOrganisationBloc>(context);
                // _addContractAlert(tableOrganisationBloc);
                showDialog(
                    context: navigatorKey.currentContext!,
                    builder: (context) => EditContractAlert(
                        tableOrganisationBloc: tableOrganisationBloc));
              },
              child: const Text("Edit contract")),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {
                final tableOrganisationBloc =
                    BlocProvider.of<TableOrganisationBloc>(context);
                tableOrganisationBloc
                    .add(DeleteContractEvent(repository: repository));
              },
              child: const Text("Delete contract")),
        ],
      ),
    );
  }
}
