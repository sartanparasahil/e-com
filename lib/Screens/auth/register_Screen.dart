import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../API/API_Connection.dart';
import '../home_Screen.dart';
import 'login_Screen.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isselect = false;

  //function for add user
  adduser() async {
    try {
      var response = await http.post(
          Uri.parse(APIConnection.addUserAPI),
          body: {
            "user_name": _nameController.text.toString(),
            "user_email": _emailController.text.toString(),
            "user_password": _passwordController.text.toString(),
          }
      );

      if (response.statusCode == 200) {

        var responseBody = jsonDecode(response.body);

        if(responseBody["success"] == true){
          Fluttertoast.showToast(msg: "Singup successfully");
        }else{
          Fluttertoast.showToast(msg: "Failed to add user");
        }
      } else {
        Fluttertoast.showToast(msg: "Somthing Wrong");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
                padding: const EdgeInsets.only(left: 20,top: 90),
                child: Container(
                  height: 110,
                  width: 110,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:  AssetImage("assets/happy-user.png",)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 10),
                child: Text("Ready to dive in? Start by signing up!",style: TextStyle(color: Theme.of(context).highlightColor,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              const SizedBox(
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
                            controller: _nameController,
                            style: TextStyle(
                              color: Theme.of(context).highlightColor
                            ),
                            cursorColor: Theme.of(context).disabledColor,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:  BorderSide(
                                  color: Theme.of(context).highlightColor,
                                ),
                              ),
                              fillColor: Theme.of(context).canvasColor,
                              filled: true,
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Theme.of(context).disabledColor
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                           const SizedBox(
                            height: 30,
                          ),
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
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+\w{2,4}')
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
                            style: const TextStyle(),
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
                                'Sign Up',
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
                                      adduser();
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const homeScreen(),));
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
                                      const logInScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign In',
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
