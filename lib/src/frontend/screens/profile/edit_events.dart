import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/auth.dart';
import 'package:odoohackathon24/src/backend/database.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';
import 'package:odoohackathon24/src/frontend/common/custom_form_field.dart';
import 'package:odoohackathon24/src/frontend/common/custom_header.dart';

class EditEventPage extends StatefulWidget {
  final String image, name, desc, loc, datetime, guests, sponsers, docID;
  final bool isInPerson;
  const EditEventPage(
      {super.key,
      required this.image,
      required this.name,
      required this.desc,
      required this.loc,
      required this.datetime,
      required this.guests,
      required this.sponsers,
      required this.docID,
      required this.isInPerson});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  FilePickerResult? _filePickerResult;
  bool _isInPersonEvent = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _guestController = TextEditingController();
  final TextEditingController _sponsersController = TextEditingController();

  Storage storage = Storage(client);
  bool isUploading = false;
  String userId = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    userId = SavedData.getUserId();
    _nameController.text = widget.name;
    _descController.text = widget.desc;
    _locationController.text = widget.loc;
    _dateTimeController.text = widget.datetime;
    _guestController.text = widget.guests;
    _sponsersController.text = widget.sponsers;
    _isInPersonEvent = widget.isInPerson;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // To pickup date and time form the user
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute);
        setState(() {
          _dateTimeController.text = selectedDateTime.toString();
        });
      }
    }
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      _filePickerResult = result;
    });
  }

// upload event image to storage bucket
  Future uploadEventImage() async {
    setState(() {
      isUploading = true;
    });
    try {
      if (_filePickerResult != null) {
        PlatformFile file = _filePickerResult!.files.first;
        final fileByes = await File(file.path!).readAsBytes();
        final inputFile =
            InputFile.fromBytes(bytes: fileByes, filename: file.name);

        final response = await storage.createFile(
            bucketId: '667fdaca002096955b71',
            fileId: ID.unique(),
            file: inputFile);
        // print(response.$id);
        return response.$id;
      } else {
        // print("Something went wrong");
      }
    } catch (e) {
      // print(e);
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 50,
            ),
            const CustomHeadText(text: "Edit Event"),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () => _openFilePicker(),
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: _filePickerResult != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image(
                            image: FileImage(
                                File(_filePickerResult!.files.first.path!)),
                            fit: BoxFit.fill,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://cloud.appwrite.io/v1/storage/buckets/667fdaca002096955b71/files/${widget.image}/view?project=667f8285001ac7028d7e",
                            fit: BoxFit.fill,
                          ))),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _nameController,
                icon: Icons.event_outlined,
                label: "Event Name",
                hint: "Add Event Name"),
            const SizedBox(
              height: 8,
            ),
            CustomInputForm(
                maxLines: 4,
                controller: _descController,
                icon: Icons.description_outlined,
                label: "Description",
                hint: "Add Description"),
            const SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _locationController,
                icon: Icons.location_on_outlined,
                label: "Location",
                hint: "Enter Location of Event"),
            const SizedBox(
              height: 8,
            ),
            CustomInputForm(
              controller: _dateTimeController,
              icon: Icons.date_range_outlined,
              label: "Date & Time",
              hint: "Pickup Date Time",
              readOnly: true,
              onTap: () => _selectDateTime(context),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _guestController,
                icon: Icons.people_outlined,
                label: "Guests",
                hint: "Enter list of guests"),
            const SizedBox(
              height: 8,
            ),
            CustomInputForm(
                controller: _sponsersController,
                icon: Icons.attach_money_outlined,
                label: "Sponsers",
                hint: "Enter Sponsers"),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "In Person Event",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Switch(
                    activeColor: Colors.white,
                    focusColor: Colors.green,
                    value: _isInPersonEvent,
                    onChanged: (value) {
                      setState(() {
                        _isInPersonEvent = value;
                      });
                    }),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: MaterialButton(
                color: Colors.white,
                onPressed: () {
                  if (_nameController.text == "" ||
                      _descController.text == "" ||
                      _locationController.text == "" ||
                      _dateTimeController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Event Name,Description,Location,Date & time are must.")));
                  } else {
                    if (_filePickerResult == null) {
                      updateEvent(
                              _nameController.text,
                              _descController.text,
                              widget.image,
                              _locationController.text,
                              _dateTimeController.text,
                              userId,
                              _isInPersonEvent,
                              _guestController.text,
                              _sponsersController.text,
                              widget.docID)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Event Updated !!")));
                        Navigator.pop(context);
                      });
                    } else {
                      uploadEventImage()
                          .then((value) => updateEvent(
                              _nameController.text,
                              _descController.text,
                              value,
                              _locationController.text,
                              _dateTimeController.text,
                              userId,
                              _isInPersonEvent,
                              _guestController.text,
                              _sponsersController.text,
                              widget.docID))
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Event Updated !!")));
                        Navigator.pop(context);
                      });
                    }
                  }
                },
                child: Text(
                  "Update Event",
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Danger Zone",
              style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 243, 138, 136),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: MaterialButton(
                color: const Color.fromARGB(255, 243, 138, 136),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              "Are you Sure ?",
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            ),
                            content: Text(
                              "Your event will be deleted",
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    deleteEvent(widget.docID)
                                        .then((value) async {
                                      await storage.deleteFile(
                                          bucketId: "64bcdd3ad336eaa231f0",
                                          fileId: widget.image);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Event Deleted Successfully. ")));
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No")),
                            ],
                          ));
                },
                child: Text(
                  "Delete Event",
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
