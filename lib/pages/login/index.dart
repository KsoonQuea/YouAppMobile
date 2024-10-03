import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

import 'package:youapp_mobile/components/gradient_bg.dart';
import 'package:youapp_mobile/components/gradient_button.dart';
import 'package:youapp_mobile/pages/register/index.dart';
import 'package:youapp_mobile/services/api_service.dart' as api_service;
import 'package:youapp_mobile/components/custom_snackbar.dart' as custom_snackbar;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // Controllers to handle user input for email and password
  final TextEditingController emailController     = TextEditingController();
  final TextEditingController passwordController  = TextEditingController();

  bool passwordVisibleOff  = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // elevation: 20,
        backgroundColor: Colors.transparent,
        flexibleSpace: Padding(padding: EdgeInsets.only( left: 16, top: 36 ), child: 
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              icon: Icon(Icons.arrow_back_ios, size: 16, color: Colors.white),
              label: Text('Back', style: TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: 
      GradientBackground(
        child:  Padding(
          padding : EdgeInsets.all(16.0),
          child   : Form(
            key   : _formKey,
            child : Column(
              mainAxisAlignment : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 20, left: 10), child: 
                  Text(
                    "Login", 
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                    ), 
                    textAlign: TextAlign.start
                  ),
                ),

                // Email TextField
                TextField(
                  controller  : emailController,
                  decoration  : InputDecoration(
                    labelText : 'Email',
                    border    : OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Password TextField
                TextField(
                  obscureText : passwordVisibleOff, 
                  controller  : passwordController,
                  decoration  : InputDecoration(
                    labelText : 'Password',
                    border    : OutlineInputBorder(),
                    suffixIcon: IconButton(icon: Icon(passwordVisibleOff ? Icons.visibility_off : Icons.visibility), color: Colors.white54, onPressed: () {
                      setState(() => passwordVisibleOff = !passwordVisibleOff);
                    }),
                  ), // To obscure password input
                ),
                SizedBox(height: 16),

                Padding(padding: EdgeInsets.only(top: 10), child: 
                  GradientButton(
                    width: double.infinity,
                    height: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        _submitLoginForm(context);
                      },
                      child: Text("Login", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),

                // Register Part
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: 
                    RichText(text: 
                      TextSpan(
                        style: TextStyle(color: Colors.white70),
                        children: [
                          TextSpan(text: 'No account? '),
                          TextSpan(
                            text: 'Register here',
                            style: TextStyle(
                              color: Colors.yellow[400],
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        
          ),
        ),
      ),
    );
  }

  Future<void> _submitLoginForm(context) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'email'   : emailController.text,
        'password': passwordController.text,
      };

      dynamic api_response;

      try{
        api_response = await api_service.ApiService().postLogin(userData);
        developer.log("After API Updated", name: "Message");

        api_response['message'] == "User has been created successfully" ? custom_snackbar.CustomSnackbar().showSuccessMessage(api_response['message'], context) : custom_snackbar.CustomSnackbar().showFailMessage(api_response['message'], context);
      }
      catch (e) {
        developer.log('$e', name: "Issue Catch");
      }

      
    }
  }
}
