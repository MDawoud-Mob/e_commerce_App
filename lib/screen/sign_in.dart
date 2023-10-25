import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/snackbar.dart';
import 'package:flutter_application_1/firebase/facebook_signin.dart';
import 'package:flutter_application_1/provider/google_signin.dart';
import 'package:flutter_application_1/screen/forgot_password.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../app_images.dart';
import 'home.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isvisbality = false;
  bool isLoading = false;
  final emailController = TextEditingController();

  final passWordController = TextEditingController();

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passWordController.text,
      );
      showSnachBar(context, 'Doneee! ...');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnachBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnachBar(context, 'Wrong password provided for that user.');
      } else {
        showSnachBar(context, 'Error ...!');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignin = Provider.of<GoogleSignInProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 141, 95),
        title: Text(
          'Sign in',
          style: GoogleFonts.kaushanScript(
            textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.5),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Email';
                  }
                  return null;
                }),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.email),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 186, 200, 207),
                    enabledBorder: OutlineInputBorder(
                        borderSide: Divider.createBorderSide(context)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    hintText: 'Enter Your Email'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ((value) {
                  if (value!.length < 8) {
                    return 'Enter at least 8 characters';
                  }
                  return null;
                }),
                controller: passWordController,
                keyboardType: TextInputType.text,
                obscureText: isvisbality ? true : false,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisbality = !isvisbality;
                        });
                      },
                      icon: isvisbality
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 186, 200, 207),
                    enabledBorder: OutlineInputBorder(
                        borderSide: Divider.createBorderSide(context)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    hintText: 'Enter Your Password'),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 54, 192, 59))),
                  onPressed: () async {
                    await signIn();
                    if (!mounted) return;
                    context.toView(const Home());
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 247, 118, 109),
                        )
                      : const Text(
                          'sign in',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
              TextButton(
                  onPressed: () {
                    context.toView(const ForgotPassword());
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do not have an account?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        context.toView(const Register());
                      },
                      child: const Text('Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: TextDecoration.underline))),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Color.fromARGB(255, 210, 145, 221),
                    thickness: 2,
                  )),
                  Text('OR',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                      child: Divider(
                    color: Color.fromARGB(255, 201, 127, 214),
                    thickness: 2,
                  ))
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                GestureDetector(
                  onTap: () {
                    googleSignin.googlelogin();
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.red, width: 2.5)),
                      child: const ClipOval(
                        child: Image(
                          image: AssetImage(Assets.imagesPct1),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: ()async {
                await    signInWithFacebook();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 192, 119),
                              width: 2.1)),
                      child: const Image(
                        image: AssetImage(Assets.imagesFacebook),
                        fit: BoxFit.cover,
                        height: 45,
                        width: 57,
                      )),
                ),
              ]),
            ]),
          ),
        ),
      ),
    ));
  }
}
