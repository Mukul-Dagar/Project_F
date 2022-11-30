import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/components/side_menu.dart';

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
          ),
          drawer: const SideMenu(),
          body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(

                    elevation: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text('Contact Us', style: TextStyle(fontSize: 25),),
                          Text('Phone No. : +91 123456789',style: TextStyle(fontSize: 18),),
                          Text('Email : projectf@gmail.com',style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(15),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  color: Colors.deepPurple[300],
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
