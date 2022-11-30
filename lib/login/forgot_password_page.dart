import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Password reset link sent. Check your Email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        elevation: 7,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Enter your email for a password reset link!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
          ),
        ),
        MaterialButton(
          onPressed: passwordReset,
          color: Colors.deepPurple,
          child: const Text(
            'Reset Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
