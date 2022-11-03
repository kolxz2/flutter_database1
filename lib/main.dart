import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_database1/ui/pages/main_screan/main_screan_widget.dart';
import 'package:window_size/window_size.dart';

import 'domain/use_case/table_organisation/table_organisation_bloc.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Demo');
    setWindowMinSize(const Size(1000, 1000));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocWrapper(),
      navigatorKey: navigatorKey,
    );
  }
}

class BlocWrapper extends StatelessWidget {
  const BlocWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TableOrganisationBloc(),
        ),
      ],
      child: MainScreen(),
    );
  }
}
