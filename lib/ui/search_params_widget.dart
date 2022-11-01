import 'package:flutter/material.dart';
import 'package:flutter_database1/const/button_styles.dart';

class SearchParams extends StatefulWidget {
  const SearchParams({Key? key}) : super(key: key);

  @override
  State<SearchParams> createState() => _SearchParamsState();
}

class _SearchParamsState extends State<SearchParams> {
  DateTime selectedDate = DateTime.now();
  bool searcherByDate = false;

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
                  if (searcherByDate)
                    Container(
                      width: 170,
                      child: Text(
                        "Search by date: " +
                            "${selectedDate.toLocal()}".split(' ')[0],
                      ),
                    )
                  else
                    Container(width: 170, child: Text("Search by date: ...")),
                  SizedBox(
                    width: 50.0,
                  ),
                  ElevatedButton(
                    style: appSearchButtonStyle,
                    onPressed: !searcherByDate
                        ? null
                        : () {
                            _selectDate(context);
                          },
                    child: Text('Select date'),
                  ),
                  Switch(
                    // This bool value toggles the switch.
                    value: searcherByDate,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        searcherByDate = value;
                        selectedDate = DateTime.now();
                      });
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
