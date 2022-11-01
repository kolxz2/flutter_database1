import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/table_organisation/table_organisation_bloc.dart';
import '../../search_params_widget.dart';
import '../../table_agreements_widget.dart';
import '../../table_customers_widget.dart';
import '../../tables_editor_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final tableOrganisationBloc = TableOrganisationBloc();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => tableOrganisationBloc,
          ),
        ],
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: TableCustomers(
                          tableOrganisationBloc: tableOrganisationBloc,
                        )),
                    Expanded(child: TableAgreements()),
                  ],
                ),
              ),
              SearchParams(),
              TablesEditor(
                tableOrganisationBloc: tableOrganisationBloc,
              )
            ],
          ),
        ));
  }
}
