import 'package:pluto_grid/pluto_grid.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/repository/tables_repository.dart';

class TablesRepositoryImplementation implements TablesRepository {
  final String _appSupportDirectory =
      r'C:\Users\kolxz\AndroidStudioProjects\flutter_database1\asset\database';

  late final String path;
  late var _database;
  final databaseFactory = databaseFactoryFfi;

  TablesRepositoryImplementation() {
    path = "$_appSupportDirectory\\demo.db";
  }

  @override
  Future<Map<PlutoRow, List<PlutoRow>>> onStartLoadOrganisationsRows() async {
    sqfliteFfiInit();
    Map<PlutoRow, List<PlutoRow>> loadedList = {};

    _database = await databaseFactory.openDatabase(path);
    try {
      _database.execute('''
  CREATE TABLE IF NOT EXISTS Organisation (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_name TEXT,
      org_adres TEXT,
      org_chief TEXT
  )
  ''');
      _database.execute('''
  CREATE TABLE IF NOT EXISTS Contract (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    organisation_id INTEGER  NOT NULL,
    contract_coast REAL NOT NULL ,
    date_contract TEXT NOT NULL,
    FOREIGN KEY (organisation_id) REFERENCES Organisation (id)
)
  ''');
    } catch (_) {
      print("Table exist");
    }
    final List<Map<String, dynamic>> maps =
        await _database.query('Organisation');

    final List<Map<String, dynamic>> maps2 = await _database.query('Contract');

    for (var item in maps) {
      PlutoRow keyValue = PlutoRow(cells: {
        'text_field': PlutoCell(value: item['org_name']),
        'text_Adres': PlutoCell(value: item['org_adres']),
        'text_Chief': PlutoCell(value: item['org_chief']),
      });
      List<PlutoRow> valueValue = [];
      for (var idem2 in maps2) {
        if (idem2['organisation_id'] == item['id']) {
          PlutoRow valueItem = PlutoRow(cells: {
            'number_field': PlutoCell(value: idem2['contract_coast']),
            'date_field':
                PlutoCell(value: DateTime.parse(idem2['date_contract'])),
          });
          valueValue.add(valueItem);
        }
        loadedList[keyValue] = valueValue;
      }
    }
    await _database.close();
    return loadedList;
  }

  int _searchOrganisationPosition(List<Map<String, dynamic>> table,
      String organisation, String chief, String adres) {
    //  int position = 1;
    for (var item in table) {
      if (item['org_name'] == organisation &&
          item['org_adres'] == adres &&
          item['org_chief'] == chief) {
        return item['id'];
      }
      // position += 1;
    }
    throw "Item not found";
  }

  int _searchContractPosition(
      List<Map<String, dynamic>> table, double coast, DateTime date) {
    for (var item in table) {
      if (item['contract_coast'] == coast &&
          item['date_contract'].toString().substring(0, 10) ==
              date.toString().substring(0, 10)) {
        return item['id'];
      }
      // position += 1;
    }
    throw "Item not found";
  }

  @override
  Future<void> onAddContract(String organisation, String chief, String adres,
      double coast, DateTime date) async {
    _database = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps =
        await _database.query('Organisation');
    int position =
        _searchOrganisationPosition(maps, organisation, chief, adres);
    await _database.insert('Contract', <String, dynamic>{
      'contract_coast': coast,
      'date_contract': date.toString(),
      "organisation_id": position
    });
    await _database.close();
  }

  @override
  onAddOrganisation(String organisation, String chief, String adres) async {
    _database = await databaseFactory.openDatabase(path);
    await _database.insert('Organisation', <String, String>{
      'org_name': organisation,
      'org_adres': adres,
      'org_chief': chief
    });
    await _database.close();
  }

  @override
  onDeleteContract(
      String organisation, String chief, String adres, int index) async {
    _database = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps =
        await _database.query('Organisation');

    final List<Map<String, dynamic>> maps2 = await _database.query('Contract');
    int position =
        _searchOrganisationPosition(maps, organisation, chief, adres);
    List<Map<String, dynamic>> maps2Ranged = [];
    for (var item in maps2) {
      if (item['organisation_id'] == position) {
        maps2Ranged.add(item);
      }
    }
    int idContract = maps2Ranged.elementAt(index).values.elementAt(0);

    await _database
        .delete('Contract', where: ' id = ?', whereArgs: [idContract]);
    await _database.close();
  }

  @override
  onDeleteOrganisation(String organisation, String chief, String adres) async {
    _database = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps =
        await _database.query('Organisation');

    int position =
        _searchOrganisationPosition(maps, organisation, chief, adres);
    await _database
        .delete('Organisation', where: 'id = ?', whereArgs: [position]);
    await _database.delete('Contract',
        where: 'organisation_id = ?', whereArgs: [position]);
    await _database.close();
  }

  @override
  onEditContract(String organisation, String chief, String adres, double coast,
      DateTime date, double coastOld, DateTime dateOld) async {
    _database = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps =
        await _database.query('Organisation');
    final List<Map<String, dynamic>> maps2 = await _database.query('Contract');
    int positionOrganisation =
        _searchOrganisationPosition(maps, organisation, chief, adres);
    List<Map<String, dynamic>> maps2Ranged = [];
    for (var item in maps2) {
      if (item['organisation_id'] == positionOrganisation) {
        maps2Ranged.add(item);
      }
    }
    int positionContract =
        _searchContractPosition(maps2Ranged, coastOld, dateOld);
    await _database.rawUpdate(
        'UPDATE Contract SET contract_coast = ?, date_contract = ? WHERE id = ?',
        [coast, date.toString(), positionContract]);
    await _database.close();
  }

  @override
  onEditOrganisation(String organisation, String chief, String adres,
      String organisationOld, String chiefOld, String adresOld) async {
    _database = await databaseFactory.openDatabase(path);
    final List<Map<String, dynamic>> maps =
        await _database.query('Organisation');
    int position =
        _searchOrganisationPosition(maps, organisationOld, chiefOld, adresOld);
    await _database.rawUpdate(
        'UPDATE Organisation SET org_name = ?, org_adres = ?, org_chief = ? WHERE id = ?',
        [organisation, adres, chief, position]);
    await _database.close();
  }
}
