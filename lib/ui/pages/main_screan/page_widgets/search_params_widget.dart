import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_case/table_organisation/table_organisation_bloc.dart';
import '../../../const/button_styles.dart';

class SearchParams extends StatefulWidget {
  const SearchParams({Key? key}) : super(key: key);

  @override
  State<SearchParams> createState() => _SearchParamsState();
}

class _SearchParamsState extends State<SearchParams> {
  DateTime _selectedDate = DateTime.now();
  bool _searcherByDate = false;
  TextEditingController _organisation = TextEditingController();
  TextEditingController _adres = TextEditingController();
  TextEditingController _chief = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Search by chief"),
                  SizedBox(width: 96),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _chief,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Chief name',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Text("Search by organisation"),
                  SizedBox(width: 50),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _organisation,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Organisation name',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(width: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Search by addres"),
                  SizedBox(width: 50),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _adres,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Organisation addres',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  if (_searcherByDate)
                    Container(
                      width: 170,
                      child: Text(
                        "Search by date: " +
                            "${_selectedDate.toLocal()}".split(' ')[0],
                      ),
                    )
                  else
                    Container(width: 170, child: Text("Search by date: ...")),
                  SizedBox(
                    width: 50.0,
                  ),
                  ElevatedButton(
                    style: appSearchButtonStyle,
                    onPressed: !_searcherByDate
                        ? null
                        : () {
                            _selectDate(context);
                          },
                    child: Text('Select date'),
                  ),
                  Switch(
                    // This bool value toggles the switch.
                    value: _searcherByDate,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        _searcherByDate = value;
                        _selectedDate = DateTime.now();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
              style: appButtonStyle,
              onPressed: () {
                /*     print(_adres.text == "");
                print(_chief.text);
                print(_organisation.text);
                print(_selectedDate);*/
                final tableOrganisationBloc =
                    BlocProvider.of<TableOrganisationBloc>(context);
                tableOrganisationBloc.add(SearchByChiefEvent(
                    adresSearch: _adres.text,
                    chiefSearch: _chief.text,
                    dataSearch: _selectedDate,
                    organisationSearch: _organisation.text,
                    searcherByDate: _searcherByDate));
              },
              child: const Text("Search"))
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
