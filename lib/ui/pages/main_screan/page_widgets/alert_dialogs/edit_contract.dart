import 'package:flutter/material.dart';

import '../../../../../data/repositoy/tables_repositoy_impl.dart';
import '../../../../../domain/repository/tables_repository.dart';
import '../../../../../domain/use_case/table_organisation/table_organisation_bloc.dart';
import '../../../../const/button_styles.dart';

class EditContractAlert extends StatefulWidget {
  const EditContractAlert({Key? key, required this.tableOrganisationBloc})
      : super(key: key);

  final TableOrganisationBloc tableOrganisationBloc;

  @override
  State<EditContractAlert> createState() =>
      _EditContractAlert(tableOrganisationBloc: tableOrganisationBloc);
}

class _EditContractAlert extends State<EditContractAlert> {
  DateTime selectedDate = DateTime.now();
  TextEditingController contractCoast = TextEditingController();

  final TableOrganisationBloc tableOrganisationBloc;
  final TablesRepository repository = TablesRepositoryImplementation();

  _EditContractAlert({required this.tableOrganisationBloc});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text('New organisation data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 200,
            child: TextField(
              controller: contractCoast,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contract coast',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 200,
              child: ElevatedButton(
                style: appSearchButtonStyle,
                onPressed: () {
                  _selectDate(context);
                },
                child: Text('${selectedDate.toLocal()}'.split(' ')[0]),
              )),
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
            tableOrganisationBloc.add(EditContractEvent(
                contractCoast: contractCoast.text,
                date: selectedDate,
                repository: repository));
          },
          child: const Text('Edit'),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
