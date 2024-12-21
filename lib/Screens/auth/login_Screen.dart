import 'dart:convert';
import 'package:e_com/API/API_Connection.dart';
import 'package:e_com/Screens/auth/register_Screen.dart';
import 'package:e_com/Screens/home_Screen.dart';
import 'package:e_com/Screens/onBoarding_Screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class logInScreen extends StatefulWidget {
  const logInScreen({super.key});

  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isselect = false;

  //function for fetchuser from database
  loginUser() async{
    try{
      var response = await http.post(
          Uri.parse(APIConnection.fetchUserAPI),
        body: {
          "user_email":_emailController.text.toString(),
          "user_password":_passwordController.text.toString()
        }
      );

      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        if(responseBody["success"]){

          List resBodyData = responseBody["data"];

          if(resBodyData[0]["user_password"] == responseBody["userEnteredPasswors"]){

            Fluttertoast.showToast(msg: "Login Successfully");

            SharedPreferences sharedPref = await SharedPreferences.getInstance();
            sharedPref.setBool("ISLOGIN", true);
            sharedPref.setString("USERNAME", resBodyData[0]["user_name"]);
            sharedPref.setString("USER-EMAIL", resBodyData[0]["user_email"]);

            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => homeScreen()),(route)=>false);
          }else{
            Fluttertoast.showToast(msg: "Password is incorrect");
          }
        }else{
          Fluttertoast.showToast(msg: "Gmail id not registerd ,plese register first");
        }
      }else{
        Fluttertoast.showToast(msg: "Somthing want wrong");
      }
    }catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //sharedpref ("Skip to login")
  skipLoginScreen() async{
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    bool isLogin = sharedpref.getBool("ISLOGIN") ?? false;

    if(isLogin == false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const onBoarding(),));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homeScreen(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 160),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/user.png")
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30,left: 10),
              child: Text("Welcome back you've been missed!",style: TextStyle(color: Theme.of(context).highlightColor,fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Theme.of(context).disabledColor,
                          controller: _emailController,
                          style:  TextStyle(color: Theme.of(context).highlightColor),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).highlightColor,
                              )
                            ),
                            fillColor: Theme.of(context).canvasColor,
                            filled: true,
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Theme.of(context).disabledColor
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).highlightColor),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).highlightColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          cursorColor: Theme.of(context).disabledColor,
                          style:  TextStyle(color: Theme.of(context).highlightColor),
                          obscureText: isselect ? false:true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isselect = !isselect;
                                  });
                                },
                                icon: isselect ? Icon(Icons.visibility_outlined,color: Theme.of(context).disabledColor,):Icon(Icons.visibility_off_outlined,color: Theme.of(context).disabledColor,)
                            ),
                            fillColor: Theme.of(context).canvasColor,
                            filled: true,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Theme.of(context).disabledColor
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).highlightColor
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).highlightColor
                              )
                            ),
                            // suffix: isselect == true ? Icon(Icons.visibility_outlined):Icon(Icons.visibility_off_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              'Sign In',
                              style: TextStyle(
                                 color: Theme.of(context).highlightColor,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Theme.of(context).highlightColor,
                              child: IconButton(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Perform sign-in logic here
                                   //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const homeScreen(),));
                                   // Fluttertoast.showToast(msg: "Login Successfuly");
                                    loginUser();
                                    // skipLoginScreen();
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const registerScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Theme.of(context).disabledColor,
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Add forgot password logic here
                              },
                              child:  Text(
                                'Forgot Password',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Theme.of(context).disabledColor,
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
