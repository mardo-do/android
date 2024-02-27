import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Enregistrement '),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.red, Colors.orange],
                ),
              ),
            )),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  bool _termsChecked = false;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Non'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Non obligatwa';
                } else if (value.length < 2) {
                  return 'Non dwe gen omwen 2 karakter';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Prenon'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Prenon obligatwa';
                } else if (value.length < 2) {
                  return 'Prenon dwe gen omwen 2 karakter';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email obligatwa';
                } else if (!_isValidEmail(value)) {
                  return 'Email pa valide';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Modpas'),
              obscureText: true,
              onChanged: (value) {
                _password = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Modpas obligatwa';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Konfime Modpas'),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Konfimasyon Modpas obligatwa';
                } else if (value != _password) {
                  return 'Konfimasyon Modpas pa matche';
                }
                return null;
              },
            ),
            CheckboxListTile(
              title: Text("Mwen dakò tèm ak kondisyon yo."),
              value: _termsChecked,
              onChanged: (bool? value) {
                setState(() {
                  _termsChecked = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            ElevatedButton(
              onPressed: () {
                if (!_termsChecked) {
                  // Si checkbox pa tcheke, afiche yon mesaj d'èr
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Ou dwe tcheke tèm yo avan ou sibmiti fòm lan.')),
                  );
                } else {
                  // Si checkbox tcheke, verifye si fòm valide
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, proceed with submission.
                    // Your submission logic goes here.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Submitting Form')),
                    );
                    // Re-initialize the form after submission
                    _formKey.currentState!.reset();
                    _termsChecked = false;
                  }
                }
              },
              child: Text('valide'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Simple regex for email validation.
    // This is a basic example. For more comprehensive email validation, consider using a library.
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }
}
