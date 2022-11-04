import 'package:pluto_grid/pluto_grid.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/repository/tables_repository.dart';

class TablesRepositoryImplementation implements TablesRepository {
  final String _appSupportDirectory =
      r'C:\Users\kolxz\AndroidStudioProjects\flutter_database1\asset\database';

  late final String path;
  late var _database;
  final databaseFactory = databaseFactoryFfi;

/*  TablesRepositoryImplementation() {
    onStartLoad;
  }*/

  @override
  Future<List<PlutoRow>> onStartLoadOrganisationsRows() async {
    List<PlutoRow> loadedList = [];
    path = "$_appSupportDirectory\\demo.db";
    sqfliteFfiInit();
    _database = await databaseFactory.openDatabase(path);
    try {
      _database.execute('''
  CREATE TABLE IF NOT EXISTS Organisation (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_name TEXT,
      org_adres TEXT,
      org_adres TEXT
  )
  ''');
      _database.execute('''
  CREATE TABLE IF NOT EXISTS Contract (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    list_id TEXT NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    content TEXT NOT NULL,
    FOREIGN KEY (organisation_id) REFERENCES Organisation (id)
)
  ''');
    } catch (_) {
      print("Table exist");
    }
    final List<Map<String, dynamic>> maps =
        await _database.query('Organisation');

    loadedList = List.generate(maps.length, (index) {
      return PlutoRow(
        cells: {
          'text_field': PlutoCell(value: maps[index]['org_name']),
          'text_Adres': PlutoCell(value: maps[index]['org_adres']),
          'text_Chief': PlutoCell(value: maps[index]['org_adres']),
        },
      );
    });
    //throw UnimplementedError();
    return loadedList;
  }

  @override
  onAddContract() {
    // TODO: implement onAddContract
    throw UnimplementedError();
  }

  @override
  onAddOrganisation() {
    // TODO: implement onAddOrganisation
    throw UnimplementedError();
  }

  @override
  onDeleteContract() {
    // TODO: implement onDeleteContract
    throw UnimplementedError();
  }

  @override
  onDeleteOrganisation() {
    // TODO: implement onDeleteOrganisation
    throw UnimplementedError();
  }

  @override
  onEditContract() {
    // TODO: implement onEditContract
    throw UnimplementedError();
  }

  @override
  onEditOrganisation() {
    // TODO: implement onEditOrganisation
    throw UnimplementedError();
  }
}
