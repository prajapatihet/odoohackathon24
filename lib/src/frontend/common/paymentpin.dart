import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/frontend/common/colors.dart';
import 'package:odoohackathon24/src/frontend/common/confirm_payment.dart';
import 'package:odoohackathon24/src/frontend/common/faliure_payment.dart';

class PinEntryPage extends StatefulWidget {
  const PinEntryPage({super.key});

  @override
  State<PinEntryPage> createState() => _PinEntryPageState();
}

class _PinEntryPageState extends State<PinEntryPage> {
  TextEditingController pinController = TextEditingController();
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your 6-digit PIN',
                  style: GoogleFonts.montserrat(fontSize: 20, color: white),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: pinController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  obscureText: isObscured,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: '______',
                    hintStyle: GoogleFonts.montserrat(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 24, letterSpacing: 20, color: white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: () {
                String enteredPin = pinController.text;
                if (enteredPin.length == 6) {
                  // Proceed with PIN validation
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessPage(),
                    ),
                  );
                } else {
                  // Show error message
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FailurePage(),
                    ),
                  );
                }
              },
              child: Text(
                'Proceed To Pay',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
