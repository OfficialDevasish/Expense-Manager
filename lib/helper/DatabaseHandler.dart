

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler
{
  Database db;


  Future<Database>  create_db() async
  {
    if(db==null)
      {
        Directory dir = await getApplicationDocumentsDirectory();
        String path = join(dir.path,"shop_db");
        var db = await openDatabase(path,version: 1,onCreate: create_table);
        return db;
      }
    else
      {
        return db;
      }
  }
  create_table(Database db, int verssion)async
  {
    db.execute("create table  expense (eid integer primary key autoincrement,expense_head text ,descp text, typ text,amount double,dat text)");
    print("data has loded");
  }

  Future<int> addexpense(head,descp,typ,ammount,dat) async
  {
    var db = await create_db();
    var id = await db.rawInsert("insert into expense (expense_head,descp,typ,amount,dat) values (?,?,?,?,?)",[head,descp,typ,ammount,dat]);
    return id;
  }

  Future<List>getallexpense() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from expense");
    return data.toList();
  }
 Future<int> deleteExpense(eid)async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from expense where eid=?",[eid]);
    return status;
  }

  Future<List>getsingleExpense(updateid) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from expense where eid=?",[updateid]);
    return data.toList();
  }

  Future<int> saveexpense(head,descp,typ,ammount,dat,updateid)async
  {
    var db = await create_db();
    int status = await db.rawUpdate("update expense set expense_head=?,descp=?,typ=?,amount=?,dat=? where eid=?",[head,descp,typ,ammount,dat,updateid]);
    return status ;
  }
}