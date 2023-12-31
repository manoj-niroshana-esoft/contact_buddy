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
          "CREATE	TABLE	users(id	INTEGER	PRIMARY	KEY	AUTOINCREMENT,	name	TEXT	NOT NULL,	email	TEXT NOT NULL, password TEXT NOT NULL); ",
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

  Future<void> updateContact(Contact contact) async {
    // Get a reference to the database.
    final Database db = await initializeDB();

    // Update the given Contact.
    await db.update(
      'contacts',
      contact.toMap(),
      // Ensure that the Contact has a matching id.
      where: 'id = ?',
      // Pass the Contact's id as a whereArg to prevent SQL injection.
      whereArgs: [contact.id],
    );
  }

  // A method that retrieves all the Contact from the Contact table.
  Future<Contact> getContact(int id) async {
    // Get a reference to the database.
    final Database db = await initializeDB();

    // Query the table for The Contact.
    var data = await db.rawQuery('SELECT * FROM contacts where id=?', [id]);
    // return Contact(
    //   name: data['name'] ,
    //   company: data['age'] as int,
    //   email: data['age'] as int,
    //   phoneNo: data['age'] as int,
    // );
    return Contact(name: "", email: "", phoneNo: "phoneNo", company: "company");
  }
}
