import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/auth.dart';
import 'package:odoohackathon24/src/backend/utils/routes/route_const.dart';
import 'package:odoohackathon24/src/frontend/common/custom_form_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "Sign Up",
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomInputForm(
                controller: _nameController,
                icon: Icons.person,
                label: "Name",
                hint: "Enter Your Name",
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomInputForm(
                controller: _emailController,
                icon: Icons.email,
                label: "Email",
                hint: "Enter Your Email",
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomInputForm(
                controller: _passwordController,
                obscureText: true,
                icon: Icons.lock,
                label: "Password",
                hint: "Create Your Password",
              ),
              SizedBox(
                height: height * 0.04,
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    createUser(_nameController.text, _emailController.text,
                            _passwordController.text)
                        .then((value) {
                      if (value == "success") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Account Created")));

                        Future.delayed(
                            const Duration(
                              seconds: 2,
                            ),
                            () => {
                                  Navigator.pushNamed(
                                      context, RouteConstant.login)
                                });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(value)));
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Sign-Up",
                    style: GoogleFonts.montserrat(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account ?",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Log in",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
