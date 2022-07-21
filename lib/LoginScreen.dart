import 'package:dementia_app/CreateAccount.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   
   final TextEditingController _email=TextEditingController();
   final TextEditingController _password =TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height / 50,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: size.width / 1.2,
            child:  IconButton(
              icon: const Icon(Icons.arrow_back_ios),onPressed: () {}),),

          SizedBox(
            height: size.height / 4,
          ),

          Container(
            width: size.width / 1.3,
            child: const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(
           width: size.width / 1.3,
           child: const Text("Sign in to continue!..", style: TextStyle(
            color: Colors.grey,
            fontSize: 25,
            fontWeight: FontWeight.w500,
           ),),
          ),
          SizedBox(
            height: size.height / 10,
          ),
         Container(
           width: size.width,
           alignment: Alignment.center,
           child: field(size, "email", Icons.account_box,_email),
         ),

         Padding(
           padding: const EdgeInsets.symmetric(vertical: 18.0),
           child: Container(
            width: size.width,
            alignment: Alignment.center,
            child: field(size, "password", Icons.lock,_password),
           ),
         ),


         SizedBox(
          height: size.height / 10,
         ),
         customButton(size),

        SizedBox(
          height: size.height / 40,
        ),
        GestureDetector( onTap: () => 
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> CreateAccount())),
          child: const Text("Create Account",  
          style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w500),),
        )
        ],
      ),
    );
  }
Widget customButton (Size size){
  return Container(
    height:size.height /14,
    width: size.width / 1.2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.blue,
    ),
    alignment: Alignment.center,
    child: const Text("Login",style: TextStyle(color: Colors.white, 
    fontSize: 18,
    fontWeight: FontWeight.bold,
    )));
  
}

Widget field (Size size, String hintText, IconData icon, TextEditingController cont)
 {

  return GestureDetector(
    onTap: () {},
    child: Container(
      height: size.height / 11,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
          
        ),
      ),
    ),
  );

 }
}