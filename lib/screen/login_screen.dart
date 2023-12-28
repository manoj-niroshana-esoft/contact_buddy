import 'package:contact_buddy/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../db_helper/database_handler.dart';
import '../model/user.dart';
import 'package:passwordfield/passwordfield.dart';
import 'add_user_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late DatabaseHandler handler;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.message,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 32.0),
            ),
            const Text(
              "Contact Buddy",
              style: TextStyle(fontSize: 25.0),
            ),
            const SizedBox(
              height: 50.0,
            ),
            TextFormField(
              controller: userNameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your Email',
                suffixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              validator: (value) {
                return value!.isEmpty ? "Please Enter Email" : null;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            // TextFormField(
            //   controller: passwordController,
            //   keyboardType: TextInputType.visiblePassword,
            //   decoration: const InputDecoration(
            //     labelText: 'Password',
            //     hintText: 'Enter your password',
            //     prefixIcon: Icon(Icons.password),
            //     focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.orangeAccent)),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.grey),
            //     ),
            //   ),
            // ),
            PasswordField(
              controller: passwordController,
              color: Colors.blue,
              passwordConstraint: r'.*[@$#.*].*',
              hintText: 'Enter your password',
              border: PasswordBorder(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue.shade100,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 2, color: Colors.blue.shade200),
                ),
              ),
              errorMessage: 'must contain special character either . * @ # \$',
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forget Password',
              ),
            ),
            SizedBox(
              width: w,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  if (userNameController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    handler.initializeDB().whenComplete(() async {
                      User secondUser = User(
                          name: "",
                          email: userNameController.text,
                          password: passwordController.text);
                      bool isAuthenticated =
                          await handler.authenticateUser(secondUser);
                      if (isAuthenticated) {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                        log("username:-->${userNameController.text} Logged Success");
                      } else {
                        final snackBar = SnackBar(
                          content:
                              const Text('Incorrect Username or Password !'),
                          backgroundColor: (Colors.red),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      // setState(()	{});
                    });
                  } else {
                    final snackBar = SnackBar(
                      content:
                          const Text('Please enter the username and password'),
                      backgroundColor: (Colors.red),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have account?'),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddUserScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }
}
