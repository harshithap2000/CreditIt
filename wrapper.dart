import 'package:flutter/material.dart';
import 'package:payme/authenticate/authenticate.dart';
import 'package:payme/authenticate/signin.dart';
import 'package:payme/home/borrower.dart';
import 'package:payme/home/admin.dart';
import 'package:payme/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {


 
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
   bool showSignInAdmin=false;
   void togglem()
 {
   setState(() {
     showSignInAdmin = true;
   });
 }
  @override
  Widget build(BuildContext context) {
  
final user = Provider.of<User>(context);
print(user);

    if(user==null)
    return Authenticate();
    else return Home(); 
    

  }
}