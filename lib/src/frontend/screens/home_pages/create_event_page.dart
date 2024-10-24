import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odoohackathon24/src/backend/auth.dart';
import 'package:odoohackathon24/src/backend/database.dart';
import 'package:odoohackathon24/src/backend/saved_data.dart';
import 'package:odoohackathon24/src/frontend/common/colors.dart';
import 'package:odoohackathon24/src/frontend/common/custom_form_field.dart';
import 'package:odoohackathon24/src/frontend/common/custom_header.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  FilePickerResult? _filePickerResult;
  Uint8List? _webImagePickerResult;
  bool _isInPersonEvent = true;
  bool _isPaid = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _guestController = TextEditingController();
  final TextEditingController _sponsersController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Storage storage = Storage(client);
  bool isUploading = false;
  String userId = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    userId = SavedData.getUserId();
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
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
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
      if (_filePickerResult != null && _filePickerResult!.files.isNotEmpty) {
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

//  image picker for web platform
//   void pickImageForWeb() async {
//     Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
//     if (bytesFromPicker != null) {
//       setState(() {
//         _webImagePickerResult = bytesFromPicker;
//       });
//     }
//   }
  // upload image for web platform

  // Future uploadImageWeb() async {
  //   try {
  //     if (_webImagePickerResult != null) {
  //       final inputFile = InputFile.fromBytes(
  //           bytes: _webImagePickerResult!, filename: "event_image.jpg");

  //       final response = await storage.createFile(
  //           bucketId: '64bcdd3ad336eaa231f0',
  //           fileId: ID.unique(),
  //           file: inputFile);
  //       // print(response.$id);
  //       return response.$id;
  //     } else {
  //       // print("Something went wrong");
  //     }
  //   } catch (e) {
  //     // print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              const CustomHeadText(text: "Create Event"),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  if (kIsWeb) {
                    // pickImageForWeb();
                  } else {
                    _openFilePicker();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .3,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 222, 222),
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
                      : _webImagePickerResult != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                _webImagePickerResult!,
                                fit: BoxFit.fill,
                              ),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 42,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Add Event Image",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                controller: _nameController,
                icon: Icons.event_outlined,
                label: "Event Name",
                hint: "Add Event Name",
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                maxLines: 4,
                controller: _descController,
                icon: Icons.description_outlined,
                label: "Description",
                hint: "Add Description",
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                controller: _locationController,
                icon: Icons.location_on_outlined,
                label: "Location",
                hint: "Enter Location of Event",
              ),
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
                hint: "Enter list of guests",
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "In Person Event",
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
              Row(
                children: [
                  const Text(
                    "Paid Events",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Spacer(),
                  Switch(
                      activeColor: Colors.white,
                      focusColor: Colors.green,
                      value: _isPaid,
                      onChanged: (value) {
                        setState(() {
                          _isPaid = value;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              _isPaid
                  ? CustomInputForm(
                      controller: _amountController,
                      icon: Icons.payment_outlined,
                      label: "Pay",
                      hint: "Enter Amount",
                    )
                  : CustomInputForm(
                      controller: _sponsersController,
                      icon: Icons.attach_money_outlined,
                      label: "Sponsers",
                      hint: "Enter Sponsers",
                    ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: MaterialButton(
                    color: blueButton,
                    onPressed: () {
                      if (_nameController.text == "" ||
                          _descController.text == "" ||
                          _locationController.text == "" ||
                          _dateTimeController.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Event Name,Description,Location,Date & time are must.")));
                      } else {
                        if (kIsWeb) {
                          // uploadImageWeb()
                          //     .then((value) => createEvent(
                          //         _nameController.text,
                          //         _descController.text,
                          //         value,
                          //         _locationController.text,
                          //         _dateTimeController.text,
                          //         userId,
                          //         _isInPersonEvent,
                          //         _guestController.text,
                          //         _sponsersController.text))
                          //     .then((value) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text("Event Created !!")));
                          //   Navigator.pop(context);
                          // });
                        } else {
                          uploadEventImage()
                              .then(
                            (value) => createEvent(
                              _nameController.text,
                              _descController.text,
                              value ?? "66629e1a0000e9198561",
                              _locationController.text,
                              _dateTimeController.text,
                              userId,
                              _isInPersonEvent,
                              _isPaid,
                              _guestController.text,
                              _sponsersController.text,
                              _amountController.text,
                            ),
                          )
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Event Created !!")));
                            Navigator.pop(context);
                          });
                        }
                      }
                    },
                    child: Text(
                      "Create New Event",
                      style: GoogleFonts.montserrat(
                        color: white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
