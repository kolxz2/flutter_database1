import 'package:flutter/material.dart';

import 'page_widgets/search_params_widget.dart';
import 'page_widgets/table_agreements_widget.dart';
import 'page_widgets/table_customers_widget.dart';
import 'page_widgets/tables_editor_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(flex: 2, child: TableCustomers()),
                Expanded(child: TableAgreements()),
              ],
            ),
          ),
          SearchParams(),
          TablesEditor()
        ],
      ),
    );
  }
}
