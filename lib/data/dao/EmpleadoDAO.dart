

import 'package:ghmedic/data/dao/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class EmpledoDAO {

  static final table = 'empleado';

  static final columnId = 'PKEmpleado';
  static final columnName = 'Nombre';
  static final columnDepartment= 'Departamento';
  static final columnCountry= 'Pais';
  static final columnSex= 'Sexo';
  static final columnEntryDate= 'FechaIngreso';
  static final columnState= 'Estado';

  DatabaseHelper instance = DatabaseHelper.instance;

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }


  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<Map<String, dynamic>> querySingleRows(String id) async {
    Database db = await instance.database;
    var list =await db.query(table,where: '$columnId = ?', whereArgs: [id],limit: 1);
    return list.first;
  }

  insertBatch(List<Map<String,dynamic>> rows) async{
    Database db = await instance.database;
    Batch batch = db.batch();
    rows.forEach((element) {
      batch.insert(table, element);
    });
    await batch.commit();

  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

}