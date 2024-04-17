import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> _obsecurepass = ValueNotifier<bool>(true);
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passFocusNode.dispose();
    emailFocusNode.dispose();
    passcontroller.dispose();
    _obsecurepass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authviewmodel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SignUp",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailcontroller,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress, 
                decoration: const InputDecoration(
                    border: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.teal)),
                    hintText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(passFocusNode);
                },
              ),
            ),
             SizedBox(
              height: height * 0.00,
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurepass,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: _obsecurepass.value,
                      controller: passcontroller,
                      focusNode: passFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Colors.teal)),
                        prefixIcon: Icon(Icons.lock_open),
                        suffixIcon: InkWell(
                            onTap: () {
                              _obsecurepass.value = !_obsecurepass.value;
                            },
                            child: Icon(_obsecurepass.value
                                ? Icons.visibility_off
                                : Icons.visibility_rounded)),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: height * 0.04,
            ),
            RoundButton(
              title: 'Sign-Up',
              loading: authviewmodel.signuploading,
              onpress: () {
                if (emailcontroller.text.isEmpty) {
                  Utils.toastMessage('Please enter your email');
                } else if (passcontroller.text.isEmpty) {
                  Utils.toastMessage('Please enter your password');
                } else if (passcontroller.text.length < 6) {
                  Utils.toastMessage('Password enter 6 digit password');
                } else {
                  Map data = {
                    'email': emailcontroller.text.toString(),
                    'password': passcontroller.text.toString()
                  };
                  authviewmodel.signupapi(data, context);
                  print("SignUp API hit");
                }
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: Center(child: Text("Already have an account? Login")))
          ],
        ),
      ),
    );
  }
}
