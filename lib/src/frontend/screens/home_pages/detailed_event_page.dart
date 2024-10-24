import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/database.dart';
import 'package:odoohackathon24/src/backend/qr_code.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';
import 'package:odoohackathon24/src/frontend/common/basic_info.dart';
import 'package:odoohackathon24/src/frontend/common/colors.dart';
import 'package:odoohackathon24/src/frontend/common/datetime_format.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  final Document data;
  const EventDetails({
    super.key,
    required this.data,
  });

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool isRSVPedEvent = false;
  String id = "";
  bool hasPaid = false;

  bool isUserPresent(List<dynamic> participants, String userId) {
    return participants.contains(userId);
  }

  @override
  void initState() {
    id = SavedData.getUserId();
    hasPaid = isUserPresent(widget.data.data["participants"], id);
    isRSVPedEvent = isUserPresent(widget.data.data["participants"], id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    black0_5,
                    BlendMode.darken,
                  ),
                  child: Image.network(
                    "https://cloud.appwrite.io/v1/storage/buckets/667fdaca002096955b71/files/${widget.data.data["image"]}/view?project=667f8285001ac7028d7e",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 25,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: white,
                  ),
                ),
              ),
              Positioned(
                bottom: 45,
                left: 8,
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${formatDate(widget.data.data["datetime"])}",
                      style: GoogleFonts.montserrat(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    const Icon(
                      Icons.access_time_outlined,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${formatTime(widget.data.data["datetime"])}",
                      style: GoogleFonts.montserrat(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 8,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${widget.data.data["location"]}",
                      style: GoogleFonts.montserrat(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.data.data["name"],
                            style: GoogleFonts.montserrat(
                              color: white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(
                              "https://www.google.com/maps/search/?api=1&query=${widget.data.data["location"]}",
                            );
                          },
                          child: const Icon(
                            Icons.location_on,
                            color: white,
                            size: 34,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.data.data["description"],
                      style: GoogleFonts.montserrat(
                        color: white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${widget.data.data["participants"].length} people are attending.",
                      style: GoogleFonts.montserrat(
                        color: white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Special Guests ",
                      style: GoogleFonts.montserrat(
                        color: white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${widget.data.data["guests"] == "" ? "None" : widget.data.data["guests"]}",
                      style: GoogleFonts.montserrat(
                        color: white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Sponsers ",
                      style: GoogleFonts.montserrat(
                        color: white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${widget.data.data["sponsers"] == "" ? "None" : widget.data.data["sponsers"]}",
                      style: GoogleFonts.montserrat(
                        color: white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "More Info ",
                                style: GoogleFonts.montserrat(
                                  color: white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Event Type : ${widget.data.data["isInPerson"] == true ? "In Person" : "Virtual"}",
                                style: GoogleFonts.montserrat(
                                  color: white,
                                ),
                              ),
                              widget.data.data['isPaid']
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Amount : ₹${widget.data.data["isPaid"] == true ? widget.data.data['amount']! : ""}",
                                          style: GoogleFonts.montserrat(
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Time : ${formatTime(widget.data.data["datetime"])}",
                                style: GoogleFonts.montserrat(
                                  color: white,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Location : ${widget.data.data["location"]}",
                                style: GoogleFonts.montserrat(
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                          isRSVPedEvent
                              ? QRCode(
                                  qrSize: 120,
                                  qrData: SavedData.getUserId(),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    widget.data.data['isPaid'] && !hasPaid
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: MaterialButton(
                                    color: blueButton,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UserInfo(),
                                        ),
                                      );
                                      rsvpEvent(
                                        widget.data.data["participants"],
                                        widget.data.$id,
                                      ).then((value) {
                                        if (value) {
                                          setState(() {
                                            hasPaid = true;
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Something went worng. Try Agian.",
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: Text(
                                      "Pay ₹${widget.data.data['amount']}",
                                      style: GoogleFonts.montserrat(
                                        color: white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "*Please note that refunds will only be provided if the event is canceled; otherwise, no refunds will be issued.",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : isRSVPedEvent
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: MaterialButton(
                                        color: blueButton,
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "You are attending this event.",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Attending Event",
                                          style: GoogleFonts.montserrat(
                                            color: white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: MaterialButton(
                                    color: blueButton,
                                    onPressed: () {
                                      rsvpEvent(
                                        widget.data.data["participants"],
                                        widget.data.$id,
                                      ).then((value) {
                                        if (value) {
                                          setState(() {
                                            isRSVPedEvent = true;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text("RSVP Successful !!!"),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Something went worng. Try Agian."),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: Text(
                                      "RSVP Event",
                                      style: GoogleFonts.montserrat(
                                        color: white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    const SizedBox(
                      height: 20,
                    ),
                    // widget.data.data['isPaid']
                    //     ? Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 10),
                    //         child: Column(
                    //           children: [
                    //             SizedBox(
                    //               height: 50,
                    //               width: double.infinity,
                    //               child: MaterialButton(
                    //                 color: blueButton,
                    //                 onPressed: () {
                    //                   Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                       builder: (context) => PaymentScreen(
                    //                         receiverName:
                    //                             widget.data.data["name"],
                    //                         amountPay:
                    //                             widget.data.data["amount"],
                    //                       ),
                    //                     ),
                    //                   );
                    //                 },
                    //                 child: Text(
                    //                   "Pay ₹${widget.data.data['amount']}",
                    //                   style: GoogleFonts.montserrat(
                    //                     color: white,
                    //                     fontWeight: FontWeight.w700,
                    //                     fontSize: 20,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(height: 5),
                    //             Text(
                    //               "*Please note that refunds will only be provided if the event is canceled; otherwise, no refunds will be issued.",
                    //               style: GoogleFonts.montserrat(
                    //                 fontSize: 12,
                    //                 color: Colors.grey,
                    //                 fontStyle: FontStyle.italic,
                    //                 fontWeight: FontWeight.w300,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
