import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/database.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';
import 'package:odoohackathon24/src/backend/utils/routes/route_const.dart';
import 'package:odoohackathon24/src/frontend/common/event_container.dart';

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
    userName = SavedData.getUserName().split(" ")[0];
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
                Navigator.pushNamed(context, RouteConstant.profile);
              },
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 34,
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello $userName!!",
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Exlpore event around you",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            refresh();
                          },
                          child: const Icon(
                            Icons.refresh,
                            size: 28,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => EventContainer(
                  data: events[index],
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
          backgroundColor: const Color(0xff7f00ff),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
