import 'package:contact_buddy/model/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'contact_buddy.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE	TABLE	users(id	INTEGER	PRIMARY	KEY	AUTOINCREMENT,	name	TEXT	NOT NULL,	email	TEXT NOT NULL, password TEXT NOT NULL); CREATE	TABLE	contacts(id	INTEGER	PRIMARY	KEY	AUTOINCREMENT,	name	TEXT	NOT NULL,	email	TEXT NOT NULL, phoneNo TEXT NOT NULL, company TEXT);",
        );
        await database.execute(
          "CREATE	TABLE	contacts(id	INTEGER	PRIMARY	KEY	AUTOINCREMENT,	name	TEXT	NOT NULL,	email	TEXT NOT NULL, phoneNo TEXT NOT NULL, company TEXT);",
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('users', user.toMap());
    }
    return result;
  }

  Future<List<User>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(
      'users',
      where: "id	=	?",
      whereArgs: [id],
    );
  }

  /// Authenticate user while login
  Future<bool> authenticateUser(User user) async {
    final db = await initializeDB();
    var data = await db.rawQuery(
        'SELECT * FROM users where email=? and password=?',
        [user.email, user.password]);
    if (data.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  // Insert Contacts in db
  Future<int> insertContact(List<Contact> contacts) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var contact in contacts) {
      result = await db.insert('contacts', contact.toMap());
    }
    return result;
  }

  // Get All Contacts
  Future<List<Contact>> retrieveContacts() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('contacts');
    return queryResult.map((e) => Contact.fromMap(e)).toList();
  }

  Future<void> deleteContact(int id) async {
    final db = await initializeDB();
    await db.delete(
      'contacts',
      where: "id	=	?",
      whereArgs: [id],
    );
  }

}
