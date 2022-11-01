import 'package:sqflite_common_ffi/sqflite_ffi.dart';

String? _appSupportDirectory =
    r'C:\Users\kolxz\AndroidStudioProjects\flutter_database1\asset\database';

Future connectBD() async {
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  String path = "${_appSupportDirectory}\\demo.db";
  await databaseFactory.deleteDatabase(path);
  var database = await databaseFactory.openDatabase(path);
  database.execute('''
  CREATE TABLE Product (
      id INTEGER PRIMARY KEY,
      title TEXT
  )
  ''');

  await database.insert('Product', <String, Object?>{'title': 'Product 1'});
  await database.insert('Product', <String, Object?>{'title': 'Product 2'});

  var result = await database.query('Product');
  print(result);
  // prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
  await database.close();
  return result;
}
