import 'package:flutter/material.dart';
import 'package:examples/main-page.dart';

class LoginHome extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();

  final _logincontroller = TextEditingController();
  String _login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Form(
            key: _keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/git-icon.png',
                  width: 110.0,
                  height: 110.0,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _logincontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'username',
                    ),
                    onSaved: (value) => _login = value,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    _keyForm.currentState.save();
                    print(_login);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Home(login: _login)),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
