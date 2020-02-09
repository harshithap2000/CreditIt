import 'package:flutter/material.dart';
import 'package:payme/home/admin.dart';
import 'package:payme/screens/wrapper.dart';
import 'package:payme/services/auth.dart';
import 'package:payme/shared/constants.dart';
import 'package:payme/shared/loading.dart';
class SignIn extends StatefulWidget {

  final Function toggleview;
 
  SignIn(
    {
      this.toggleview,
      
    }
  );
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
 final Authservice _auth = Authservice();
 final formkey=GlobalKey<FormState>(); 

 final Wrapper ob = Wrapper();
String email= "";
String password="";
String error ="";
bool loading= false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown[10],
        elevation: 0.0,
        title: Text("sign in to Brew Crew"),
        actions: <Widget>[ 
          FlatButton.icon(onPressed:(){
            widget.toggleview();
          } , icon: Icon(Icons.person), label: Text("Register"))
        ],
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:email),
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
                 decoration: textInputDecoration.copyWith(hintText:password),
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
                       Navigator.pushReplacement(context, MaterialPageRoute(
                         builder: (_)=>Home()
                           
                       ));
                       
                   }
               },
               color: Colors.pink[400],
               child: Text( 
                 "sign in as admin",
                 style: TextStyle(
                   color: Colors.white
                 ),
               ),
               ),

SizedBox(height:20.0),
               RaisedButton(onPressed: () async{
                     
                   if(formkey.currentState.validate())
                   { setState(() {
                     loading=true;
                     
                   });
                       dynamic result = await _auth.signInWithEmail(email, password);
                       if(result==null)
                       {
                         setState(() {
                         error= "could not sign in with credentials";
                         loading=false;

                         }
                         );
                       }
                       
                   }
               },
               color: Colors.pink[400],
               child: Text( 
                 "sign in as borrower",
                 style: TextStyle(
                   color: Colors.white
                 ),
               ),
               )

            ],

          )
      )
    )
    );
  }
}