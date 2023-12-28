import 'package:contact_buddy/model/contact.dart';
import 'package:flutter/material.dart';

import '../db_helper/database_handler.dart';
import '../model/user.dart';
import 'home_screen.dart';

class EditContactScreen extends StatefulWidget {
  final  int editId;
  const EditContactScreen({super.key,  required this.editId});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late DatabaseHandler handler;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController companyTextController = TextEditingController();
  TextEditingController contactTextController = TextEditingController();

  int get editId => this.editId;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.getContact(editId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTextController.dispose();
    companyTextController.dispose();
    contactTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text('Contact List'), // Set the title of the app bar
          // automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout), // Set the menu icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameTextController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: "Enter Name",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: "Enter Email",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: contactTextController,
                decoration: const InputDecoration(
                  labelText: 'Contact No',
                  hintText: "Enter Contact No",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: companyTextController,
                decoration: const InputDecoration(
                  labelText: 'Company',
                  hintText: "Enter Company Name",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 100.0,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    handler.initializeDB().whenComplete(() async {
                      Contact contact = Contact(
                        name: nameTextController.text,
                        email: emailTextController.text,
                        phoneNo: contactTextController.text,
                        company: companyTextController.text,
                      );
                      List<Contact> listOfContacts = [contact];
                      handler.insertContact(listOfContacts);
                      setState(() {});
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
