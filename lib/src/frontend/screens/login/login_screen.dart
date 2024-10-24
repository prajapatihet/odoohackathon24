import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/auth.dart';
import 'package:odoohackathon24/src/backend/utils/routes/route_const.dart';
import 'package:odoohackathon24/src/frontend/common/colors.dart';
import 'package:odoohackathon24/src/frontend/common/custom_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "Login",
                style: GoogleFonts.montserrat(
                  fontSize: 32,
                  color: white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomInputForm(
                controller: _emailController,
                icon: Icons.email,
                label: "Email",
                hint: "Enter Your Email",
              ),
              SizedBox(
                height: height * 0.025,
              ),
              CustomInputForm(
                controller: _passwordController,
                obscureText: true,
                icon: Icons.lock,
                label: "Password",
                hint: "Enter Your Password",
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forget Password",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    loginUser(_emailController.text, _passwordController.text)
                        .then((value) {
                      if (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Login Successful !!!")));

                        Future.delayed(
                            const Duration(
                              seconds: 2,
                            ),
                            () => {
                                  Navigator.pushReplacementNamed(
                                      context, RouteConstant.mainHome)
                                });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Login Failed Try Again.")));
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: white,
                    backgroundColor: blueButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Log-In",
                    style: GoogleFonts.montserrat(
                      fontSize: 21,
                      color: white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteConstant.register);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Sign Up",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: blue,
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
