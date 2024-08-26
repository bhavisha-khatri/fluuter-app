import 'package:flutter/material.dart';
import 'package:login/register.dart';
import 'package:login/Home.dart';
import 'package:login/resources/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }

  isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('email')) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Home())
      );
    }
  }

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
                  "Welcom\nBack",
                  style: TextStyle(color: Colors.white,fontSize: 33.0),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,
                  left: 35.0,
                  right: 35.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _email,
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
                        controller: _password,
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
                              "Sign In",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 27.0,fontWeight: FontWeight.w700),
                          ),
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey.shade700,
                            child: IconButton(
                              color: Colors.white,
                                onPressed: () async{

                                var nm = _email.text.toString();
                                var pass = _password.text.toString();

                                Map<String, dynamic>? insertedUser = await dbHelper.getUserByEmail(nm);

                                if (insertedUser != null) {
                                  print("Inserted User");
                                  print(insertedUser);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      // Start a timer to close the dialog after 3 seconds
                                      Future.delayed(Duration(seconds: 3), () async {
                                        Navigator.of(context).pop(); // Automatically close the dialog

                                        // Save email and password to SharedPreferences
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        await prefs.setString("email", nm);
                                        await prefs.setString("password", pass);

                                        // Navigate to the next screen
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => Home())
                                        );
                                      });

                                      return AlertDialog(
                                        title: Text('Success'),
                                        content: Text("You're logged in successfully!"),
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        content: Text('Invalid Credentials. Please try again.'),
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
                              MaterialPageRoute(builder: (context)=>register())
                            );
                            
                          }, child: Text("Sign Up",style: TextStyle(
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
