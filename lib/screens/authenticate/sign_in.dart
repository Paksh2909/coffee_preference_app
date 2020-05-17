import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Sign in to Brew Crew"),
        backgroundColor: Colors.brown[400],
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Register"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (value) => value.isEmpty ? "Enter an email" : null,
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (value) => value.length < 6
                    ? "Enter a password with 6+ characters"
                    : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    print("valid");
                    dynamic result = await _auth.signInWithEmail(email, password);
                    if (result == null) {
                      setState(() {
                        error = "Could not sign in with those credentials";
                        loading = false;

                      });
                    }
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
