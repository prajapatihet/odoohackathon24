import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/database.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';
import 'package:odoohackathon24/src/frontend/screens/home_pages/detailed_event_page.dart';

class RSVPEvents extends StatefulWidget {
  const RSVPEvents({super.key});

  @override
  State<RSVPEvents> createState() => _RSVPEventsState();
}

class _RSVPEventsState extends State<RSVPEvents> {
  List<Document> events = [];
  List<Document> userEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    String userId = SavedData.getUserId();
    getAllEvents().then((value) {
      events = value;
      for (var event in events) {
        List<dynamic> participants = event.data["participants"];

        if (participants.contains(userId)) {
          userEvents.add(event);
        }
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RSVP Events")),
      body: ListView.builder(
        itemCount: userEvents.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EventDetails(data: userEvents[index]))),
            title: Text(
              userEvents[index].data["name"],
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
            subtitle: Text(
              userEvents[index].data["location"],
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
            trailing: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
