import 'package:flutter/material.dart';

import '../../../../../domain/use_case/table_organisation/table_organisation_bloc.dart';
import '../../../../const/button_styles.dart';

class AddContractAlert extends StatefulWidget {
  const AddContractAlert({Key? key, required this.tableOrganisationBloc})
      : super(key: key);

  final TableOrganisationBloc tableOrganisationBloc;

  @override
  State<AddContractAlert> createState() =>
      _AddContractAlertState(tableOrganisationBloc: tableOrganisationBloc);
}

class _AddContractAlertState extends State<AddContractAlert> {
  DateTime selectedDate = DateTime.now();
  TextEditingController contractCoast = TextEditingController();

  final TableOrganisationBloc tableOrganisationBloc;

  _AddContractAlertState({required this.tableOrganisationBloc});

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
            tableOrganisationBloc.add(AddContractEvent(
                contractCoast: contractCoast.text, date: selectedDate));
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
