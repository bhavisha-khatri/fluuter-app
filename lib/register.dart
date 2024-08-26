import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/resources/DatabaseHelper.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {

  TextEditingController _name = TextEditingController();
  TextEditingController _ema = TextEditingController();
  TextEditingController _passw = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/login.png"),
          // fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35.0,top: 130.0),
              child: Container(
                child: Text(
                  "Create\nAccount",
                  style: TextStyle(color: Colors.white,fontSize: 33.0),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45,
                      left: 35.0,
                      right: 35.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _name,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      TextField(
                        controller: _ema,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      TextField(
                        controller: _passw,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 27.0,fontWeight: FontWeight.w700),
                          ),
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey.shade700,
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () async {

                                  Map<String, dynamic> user = {
                                    'name': _name.text,
                                    'email': _ema.text,
                                    'password': _passw.text
                                  };
                                  await dbHelper.insertUser(user);

                                  Map<String, dynamic>? insertedUser = await dbHelper.getUserByEmail(_ema.text);

                                  if (insertedUser != null) {
                                    print('Data successfully inserted: ${insertedUser['email']}');

                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => login())
                                    );
                                  } else {
                                    print('Data insertion failed');
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text('Failed to create account. Please try again.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }

                                },
                                icon: Icon(Icons.arrow_forward)),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: (){

                            // Navigator.pushNamed(context, "/register");

                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>login())
                            );

                          }, child: Text("Sign In",style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),)),
                          TextButton(onPressed: (){}, child: Text("Forgot Password",style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
