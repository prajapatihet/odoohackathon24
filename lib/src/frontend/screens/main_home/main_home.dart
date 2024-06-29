import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/auth.dart';
import 'package:odoohackathon24/src/backend/database.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';
import 'package:odoohackathon24/src/backend/utils/routes/route_const.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  String userName = "User";
  List<Document> events = [];

  @override
  void initState() {
    userName = SavedData.getUserName();
    refresh();
    super.initState();
  }

  void refresh() {
    getAllEvents().then((value) {
      events = value;
      // isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                logoutUser();
                Navigator.pushReplacementNamed(context, RouteConstant.login);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 34,
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                "Hello $userName!!",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  leading: Text(
                    "${index + 1}",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  title: Text(
                    events[index].data['name'],
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    events[index].data['location'],
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                    ),
                  ),
                ),
                childCount: events.length,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, RouteConstant.createEvent);
            refresh();
          },
          backgroundColor: Color(0xff7f00ff),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
