import 'package:flutter/material.dart';

import '../../../../../domain/use_case/table_organisation/table_organisation_bloc.dart';

class EditOrganisationAlert extends StatelessWidget {
  const EditOrganisationAlert({Key? key, required this.tableOrganisationBloc})
      : super(key: key);

  final TableOrganisationBloc tableOrganisationBloc;
  @override
  Widget build(BuildContext context) {
    TextEditingController organisation = TextEditingController();
    TextEditingController adres = TextEditingController();
    TextEditingController chief = TextEditingController();
    return AlertDialog(
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
            tableOrganisationBloc.add(EditClientEvent(
                adres: adres.text,
                chief: chief.text,
                organisation: organisation.text));
          },
          child: const Text('Edit'),
        ),
      ],
    );
  }
}
