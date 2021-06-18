import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _loadLogo(width),
        Text('Reciepts', style: TextStyle(fontSize: 30.0),),
        LoginForm(),
      ],
    ));
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Login ID field is required';
              }

              return null;
            },
            decoration: InputDecoration(labelText: 'Login ID'),
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Password field is required';
              }

              return null;
            },
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            // height: 5.0,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Logging you in...')));
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(5.0)),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _loadLogo(double width) {
  return Image(
    image: AssetImage('assets/logo.png'),
    width: width / 2,
  );
}
