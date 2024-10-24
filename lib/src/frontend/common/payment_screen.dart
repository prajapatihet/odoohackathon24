import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/frontend/common/colors.dart';
import 'package:odoohackathon24/src/frontend/common/paymentpin.dart';

class PaymentScreen extends StatelessWidget {
  final String receiverName;
  final String amountPay;

  const PaymentScreen({
    super.key,
    required this.receiverName,
    required this.amountPay,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.1),
          Image.asset(
            'assets/images/user.png',
            height: height * 0.1,
          ),
          const SizedBox(height: 18),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'Paying to  ',
                style: GoogleFonts.montserrat(
                  fontSize: 21,
                  color: white,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: receiverName,
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger(
                      child: SnackBar(content: Text('Paying $amountPay')));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PinEntryPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.lock,
                  size: 18,
                  color: white,
                ),
                label: Text(
                  'Pay ₹$amountPay',
                  style: GoogleFonts.montserrat(
                    fontSize: 21,
                    color: white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/poweredbyupi2.png',
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
