import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_database1/domain/use_case/table_organisation/table_organisation_bloc.dart';
import 'package:flutter_database1/ui/table_customers_widget.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../const/button_styles.dart';

class TablesEditor extends StatefulWidget {
  const TablesEditor({Key? key, required this.tableOrganisationBloc})
      : super(key: key);

  final TableOrganisationBloc tableOrganisationBloc;
  @override
  State<TablesEditor> createState() =>
      _TablesEditorState(tableOrganisationBloc: tableOrganisationBloc);
}

class _TablesEditorState extends State<TablesEditor> {
  // final tableOrganisationBloc = TableOrganisationBloc();

  final TableOrganisationBloc tableOrganisationBloc;

  _TablesEditorState({required this.tableOrganisationBloc});
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
              onPressed: _addOrganisationAlert,
              child: const Text("New organisation")),
          const SizedBox(
            width: 50,
          ),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {},
              child: const Text("Edit organisation")),
          const SizedBox(
            width: 50,
          ),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {},
              child: const Text("New contract")),
          const SizedBox(
            width: 50,
          ),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {
                var listRows = rows;
                final item = PlutoRow(
                  cells: {
                    'text_field': PlutoCell(value: 'event.organisation'),
                    'text_Adres': PlutoCell(value: 'event.adres'),
                    'text_Chief': PlutoCell(value: 'event.chief'),
                  },
                );
                listRows.add(item);
              },
              child: const Text("Edit contract")),
          const SizedBox(
            width: 50,
          ),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {},
              child: const Text("Search")),
        ],
      ),
    );
  }

  _addOrganisationAlert() {
    TextEditingController organisation = TextEditingController();
    TextEditingController adres = TextEditingController();
    TextEditingController chief = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (context) => TableOrganisationBloc(),
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              title: const Text('New organisation data'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      controller: organisation,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Organisation name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: adres,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Organisation addres',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: chief,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Organisation chief',
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print(organisation.text);
                    print(adres.text);
                    print(chief.text);
                    tableOrganisationBloc.add(AddClientEvent(
                        adres: adres.text,
                        chief: chief.text,
                        organisation: organisation.text));
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        });
  }
}
