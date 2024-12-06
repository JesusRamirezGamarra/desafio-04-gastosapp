import 'dart:io';

import 'package:gastosappg10/models/gasto_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbAdmin {
  Database? myDatabase;

  static final DbAdmin _instance = DbAdmin._();

  DbAdmin._();
  factory DbAdmin() {
    return _instance;
  }

  Future<Database?> _checkDatabase() async {
    if (myDatabase == null) {
      myDatabase = await _initDatabase();
    }
    return myDatabase;
  }

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory);
    String pathDatabase = join(directory.path, "GastosDB.db");
    print(pathDatabase);
    return await openDatabase(pathDatabase, version: 1,
        onCreate: (Database db, int version) {
      db.execute("""CREATE TABLE GASTOS (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            price REAL,
            datetime TEXT,
            type TEXT
          )""");
    });
  }

  //INSERCIÓN DE DATOS
  // Future<int> insertarGasto(GastoModel gasto) async {
  //   Database? db = await _checkDatabase();
  //   int res = await db!.insert(
  //     "GASTOS",
  //     gasto.conertirAMap(),
  //     // {
  //     //   "title": "Deuda BCP",
  //     //   "price": 1200.50,
  //     //   "datetime": "01/12/2024",
  //     //   "type": "Bancos",
  //     // },
  //   );
  //   print(res);
  //   return res;
  // }
  Future<int> insertarGasto(GastoModel gasto) async {
  Database? db = await _checkDatabase();
  int res = await db!.insert("GASTOS", gasto.conertirAMap());
  gasto.id = res; 
  print("Gasto insertado con ID: $res");
  return res;
  }


  //OBTENER DATOS
  Future<List<GastoModel>> obtenerGastos() async {
    Database? db = await _checkDatabase();
    // List<Map<String, dynamic>> data = await db!
    //     .query("GASTOS", columns: ["title", "price"], where: "type='Bancos'");

    // List data = await db!
    //     .rawQuery("SELECT TITLE, TYPE FROM GASTOS WHERE TYPE = 'Bancos'");

    List<Map<String, dynamic>> data = await db!.query("GASTOS");

    List<GastoModel> gastosModelList = data
        .map(
          (e) => GastoModel.fromDB(e),
        )
        .toList();

    print(gastosModelList);
    return gastosModelList;
  }

  // // UPDATE GASTO
  // Future<int> updGasto() async {
  //   Database? db = await _checkDatabase();
  //   int res = await db!.update(
  //     "GASTOS",
  //     {"title": "Mercado", "price": 100.5},
  //     where: "id=2",
  //   );
  //   print(res);
  //   return res;
  // }

  // //DELETE GASTO
  // Future<int> delGasto() async {
  //   Database? db = await _checkDatabase();
  //   int res = await db!.delete("GASTOS", where: 'id=1');
  //   print(res);
  //   return res;
  // }

 // UPDATE GASTO
  Future<int> updGasto(GastoModel gasto) async {
    Database? db = await _checkDatabase();
    int res = await db!.update(
      "GASTOS",
      gasto.conertirAMap(),
      where: "id = ?",
      whereArgs: [gasto.id],
    );
    return res;
  }

  // DELETE GASTO
  Future<int> delGasto(int id) async {
    Database? db = await _checkDatabase();
    int res = await db!.delete(
      "GASTOS",
      where: "id = ?",
      whereArgs: [id],
    );
    return res;
  }  
}
