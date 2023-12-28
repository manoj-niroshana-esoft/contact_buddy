import 'package:contact_buddy/screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../db_helper/database_handler.dart';
import '../model/user.dart';
import 'home_screen.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late	DatabaseHandler	handler;
TextEditingController nameTextController= TextEditingController();
TextEditingController ageTextController= TextEditingController();
TextEditingController countryTextController= TextEditingController();

  @override
  void	initState()	{
    super.initState();
    handler	=	DatabaseHandler();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTextController.dispose();
    ageTextController.dispose();
    countryTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding:	const	EdgeInsets.only(left:	20.0,	right:	20.0),
          child:	Column(
            crossAxisAlignment:	CrossAxisAlignment.center,
            mainAxisAlignment:	MainAxisAlignment.center,
            children:	[
              TextFormField(
                controller:	nameTextController,
                decoration:	const	InputDecoration(
                  labelText:	'name',
                  focusedBorder:	OutlineInputBorder(
                      borderSide:	BorderSide(color:	Colors.blue)),
                  enabledBorder:	OutlineInputBorder(
                    borderSide:	BorderSide(color:	Colors.grey),
                  ),
                ),
              ),
              const	SizedBox(
                height:	20.0,
              ),
              TextFormField(
                controller:	ageTextController,
                decoration:	const	InputDecoration(
                  labelText:	'email',
                  focusedBorder:	OutlineInputBorder(
                      borderSide:	BorderSide(color:	Colors.blue)),
                  enabledBorder:	OutlineInputBorder(
                    borderSide:	BorderSide(color:	Colors.grey),
                  ),
                ),
              ),
              const	SizedBox(
                height:	20.0,
              ),
              TextFormField(
                controller:	countryTextController,
                decoration:	const	InputDecoration(
                  labelText:	'password',
                  focusedBorder:	OutlineInputBorder(
                      borderSide:	BorderSide(color:	Colors.blue)),
                  enabledBorder:	OutlineInputBorder(
                    borderSide:	BorderSide(color:	Colors.grey),
                  ),
                ),
              ),
              const	SizedBox(
                height:	20.0,
              ),
              SizedBox(
                width:	100.0,
                height:	60.0,
                child:	ElevatedButton(
                  onPressed:	()	{
                    handler.initializeDB().whenComplete(()	async	{
                      User	secondUser	=	User(
                          name:	nameTextController.text,
                          email:	ageTextController.text,
                          password:	countryTextController.text);
                      List<User>	listOfUsers	=	[secondUser];
                      handler.insertUser(listOfUsers);
                      setState(()	{});
                    });

                    // Show success message after successfully added user.
                    final snackBar = SnackBar(
                      content:
                      const Text('User Sign Up Success'),
                      backgroundColor: (Colors.green),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:	(context)	=>	const	LoginScreen()),
                    );
                  },
                  style:	ElevatedButton.styleFrom(
                    backgroundColor:	Colors.blue[600],
                    shape:	BeveledRectangleBorder(
                      borderRadius:	BorderRadius.circular(2),
                    ),
                  ),
                  child:	const	Text(
                    "SAVE",
                    style:	TextStyle(color:	Colors.white),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
