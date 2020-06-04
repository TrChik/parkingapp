import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'clientModel.dart';


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;
  
  Future<Database> get database async {
    if (_database != null)
    return _database;

    _database = await initDB();
    return _database;
  }

  newClient(Client newClient) async {
    final db = await database;
    var res = await db.insert("Client", newClient.toMap());
    return res;
  }

  recreate() async {
    final db = await database;
    await db.execute("CREATE TABLE Client ("
        "id INTEGER PRIMARY KEY,"
        "status BIT"
        ")"
      );
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client ("
        "id INTEGER PRIMARY KEY,"
        "status BIT"
        ")"
      );

      for(int i = 1; i <= 40; i++) this.newClient(new Client(id: i, status: true));       // status true means place is free, false means its not
    });
  }

  fillDataBase(int number) async {
    for(int i = 1; i <= number; i++) this.newClient(new Client(id: i, status: true));
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : Null;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list = res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }
  
  Future<List<Client>> getFreeClients() async {
    final db = await database;
    var res = await db.query("Client", where: "status = ?", whereArgs: [1]);
    List<Client> list = res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Client>> getNotFreeClients() async {
    final db = await database;
    var res = await db.query("Client", where: "status = ?", whereArgs: [0]);
    List<Client> list = res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  changeStatus(int clid, bool newstatus) async {
    final db = await database;
    Client status = Client(
      id: clid,
      status: newstatus
    );
    var res = await db.update("Client", status.toMap(),
      where: "id = ?", whereArgs: [clid]);
    return res;
  }

  deleteClient(int id) async {
    final db = await database;
    db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

}