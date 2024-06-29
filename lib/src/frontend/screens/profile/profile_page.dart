import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/auth.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';
import 'package:odoohackathon24/src/backend/utils/routes/route_const.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String email = "";
  @override
  void initState() {
    super.initState();
    name = SavedData.getUserName();
    email = SavedData.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
                Text(
                  email,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteConstant.rsvpEvents);
                    },
                    title: Text(
                      "RSVP Events",
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                  //  SavedData.getUserIsOrganized()==true?
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteConstant.manageEvents);
                    },
                    title: Text(
                      "Manage Events",
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  )
                  // : Container(),
                  ,
                  ListTile(
                    onTap: () {
                      logoutUser();
                      Navigator.pushReplacementNamed(
                          context, RouteConstant.login);
                    },
                    title: Text(
                      "Logout",
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
