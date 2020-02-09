import 'package:flutter/material.dart';
import 'package:payme/home/admin.dart';

import 'package:payme/services/auth.dart';
import 'package:payme/shared/constants.dart';
import 'package:payme/shared/loading.dart';


class Register extends StatefulWidget {
 final Function toggleview;
  Register(
    {
      this.toggleview,
    }
  );

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Authservice _auth = Authservice();
final formkey=GlobalKey<FormState>(); 


bool loading=false;

  String email= "";
String password="";
String error = "";
  @override
  Widget build(BuildContext context) {
    return  loading? Loading():Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
         actions: <Widget>[ 
          FlatButton.icon(onPressed:(){
            widget.toggleview();
          } , icon: Icon(Icons.person), label: Text("Sign in")),
        ],
        backgroundColor: Colors.brown.shade500,
        elevation: 0.0,
        title: Text("sign up to Brew Crew"),
      ),
      body:Container( 
        padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration,
                validator: (val)=>val.isEmpty?"enter an email":null,
                 onChanged: (val)
                 {
                     setState(() {
                       email=val;
                     });
                 },
              ),
              SizedBox(height:20.0),
              TextFormField(
                 decoration: textInputDecoration,
                 validator: (val)=>val.length<6?"enter an email 6 chars+ long":null,
                obscureText: true,
                 onChanged: (val)
                 {
                 setState(() {
                   
                   password=val;
                 });
                 },
              ),
               SizedBox(height:20.0),
               RaisedButton(onPressed: () async{
                   if(formkey.currentState.validate())
                   { setState(() {
                     
                     loading=true;
                   });
                    
                       dynamic result = await _auth.registerWithEmail(email, password);
                       
                       if(result==null)
                       {
                         setState(()=> error= "please supply a valid email"
                          
                         );
                       }
                       
                   }
               },
               color: Colors.pink[400],
               child: Text( 
                 "sign up",
                 style: TextStyle(
                   color: Colors.white
                 ),
               ),
               ),

            ],

          )
      )
    )
    );
      
    
  }
}