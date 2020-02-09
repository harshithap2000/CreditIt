import 'package:flutter/material.dart';
import 'package:payme/home/brewList.dart';
import 'package:payme/home/settings_form.dart';
import 'package:payme/services/auth.dart';
class Borrower extends StatelessWidget {

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

      
     return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Borrower"),
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
            FlatButton.icon(onPressed:_showSettingsPanel, icon: Icon(Icons.settings), label: Text("settings")),
          ],
        ),
 body: BrewList(),
           );
  }



  
}