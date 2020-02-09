import 'package:flutter/material.dart';


import 'package:payme/services/database.dart';
import 'package:payme/shared/constants.dart';
import "package:payme/models/user.dart";
import 'package:payme/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> purposes = ["marriage", "health", "education", "sports"];

//form values
  String _currentName;
  String _currentPurpose;
  int _currentAmount;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
        
            UserData userData = snapshot.data;

            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Enter the details",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? "enter  name" : null,
                    onChanged: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentPurpose ?? userData.purpose,
                      items: purposes.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text("$sugar "),
                        );
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => _currentPurpose = val)),
                  Slider(
                    value: (_currentAmount ?? 100).toDouble(),
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentAmount = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateuserdata(
                          _currentPurpose ?? userData.purpose,
                          _currentName ?? userData.name,
                          _currentAmount ?? userData.amount,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Submit"),
                  )
                ],
              ),
            );
         
        });
  }
}
