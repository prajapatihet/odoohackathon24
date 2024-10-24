import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/frontend/common/colors.dart';

class ReusableTextField extends StatefulWidget {
  const ReusableTextField(
      {super.key,
      required this.title,
      required this.hint,
      this.isNumber,
      required this.controller,
      required this.formkey});
  final String title, hint;
  final bool? isNumber;
  final TextEditingController controller;
  final Key formkey;
  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: TextFormField(
        style: GoogleFonts.montserrat(
          color: white,
          fontWeight: FontWeight.w600,
        ),
        keyboardType:
            widget.isNumber == null ? TextInputType.text : TextInputType.number,
        decoration:
            InputDecoration(label: Text(widget.title), hintText: widget.hint),
        validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
        controller: widget.controller,
      ),
    );
  }
}
