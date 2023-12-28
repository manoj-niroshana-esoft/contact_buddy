import 'package:contact_buddy/model/contact.dart';
import 'package:contact_buddy/screen/add_contact_screen.dart';
import 'package:contact_buddy/screen/edit_contact_screen.dart';
import 'package:contact_buddy/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../db_helper/database_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseHandler handler;
  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Contact List'), // Set the title of the app bar
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Set the menu icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: handler.retrieveContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: w,
                      height: 120.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name	- ${snapshot.data![index].name} ,"),
                          Text(
                              "Email	- ${snapshot.data![index].email.toString()}"),
                          Text(
                              "Contact No	- ${snapshot.data![index].phoneNo.toString()}"),
                          Text(
                              "Company	- ${snapshot.data![index].company.toString()}"),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        handler.deleteContact(
                                            snapshot.data![index].id!);
                                        setState(() {
                                          snapshot.data!
                                              .remove(snapshot.data![index]);
                                        });
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const EditContactScreen(editId: 1)),
                                        );
                                        // handler.deleteUser(
                                        //     snapshot.data![index].id!);
                                        // setState(() {
                                        //   snapshot.data!
                                        //       .remove(snapshot.data![index]);
                                        // });
                                      },
                                      icon: const Icon(Icons.edit_note),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        Share.share('Name : ${snapshot.data![index].name.toString()} Contact No : ${snapshot.data![index].phoneNo.toString()}',
                                            subject: 'Share Contact');
                                      },
                                      icon: const Icon(Icons.share_outlined),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactScreen()),
          );
        },
      ),
    );
  }
}
