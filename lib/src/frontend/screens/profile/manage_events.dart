import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/database.dart';
import 'package:odoohackathon24/src/frontend/screens/home_pages/detailed_event_page.dart';
import 'package:odoohackathon24/src/frontend/screens/profile/edit_events.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  List<Document> userCreatedEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    manageEvents().then((value) {
      userCreatedEvents = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Events")),
      body: ListView.builder(
        itemCount: userCreatedEvents.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EventDetails(data: userCreatedEvents[index]))),
            title: Text(
              userCreatedEvents[index].data["name"],
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
            subtitle: Text(
              "${userCreatedEvents[index].data["participants"].length} Participants",
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
            trailing: IconButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditEventPage(
                              image: userCreatedEvents[index].data["image"],
                              name: userCreatedEvents[index].data["name"],
                              desc:
                                  userCreatedEvents[index].data["description"],
                              loc: userCreatedEvents[index].data["location"],
                              datetime:
                                  userCreatedEvents[index].data["datetime"],
                              guests: userCreatedEvents[index].data["guests"],
                              sponsers:
                                  userCreatedEvents[index].data["sponsers"],
                              isInPerson:
                                  userCreatedEvents[index].data["isInPerson"],
                              docID: userCreatedEvents[index].$id,
                            )));
                refresh();
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
