
import 'package:flutter/material.dart';

import 'package:payme/home/brewList.dart';
import 'package:payme/home/settings_form.dart';

import 'package:payme/models/brew.dart';
import 'package:payme/services/auth.dart';
import "package:payme/services/database.dart";
import "package:provider/provider.dart";

class Home extends StatelessWidget {

  final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
void _showSettingsPanel()
{
  showModalBottomSheet(context: context, builder: (_)
  {  
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
           child: SettingsForm()
    );

  });
}


    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Admin"),
          centerTitle: true,
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[ 
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("log out"),
              onPressed: () async
              {
                  await _auth.signOut();
                  
              },
            ),
            
           
          ],
        ),
     body: BrewList(),
      ),
    );
  }
}