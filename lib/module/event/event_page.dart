import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:event_management_app/auth.dart';
import 'package:event_management_app/module/database/database.dart';
import 'package:event_management_app/module/local_data_save/saved_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_header_text.dart';
import '../widgets/input_form.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _guestController = TextEditingController();
  final TextEditingController _sponsorsController = TextEditingController();
  final _key = GlobalKey<FormState>();

  FilePickerResult? _filePickerResult;
  bool _isInPersonEvent = false;

  Storage storage = Storage(client);
  bool isUploading = false;

  String userId = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    userId = LocalDataSaved.getUserID();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime =
        await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(pickedDateTime.year, pickedDateTime.month, pickedDateTime.day, pickedTime.hour, pickedTime.minute);
        setState(() {
          _dateTimeController.text = selectedDateTime.toString();
        });
      }
    }
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
    setState(() {
      _filePickerResult = result;
    });
  }

  ///to upload image in the db
  Future uploadEventImage() async {
    setState(() {
      isUploading = true;
    });
    try {
      if (_filePickerResult != null) {
        const bucketId = '6517a3530e7703544b64';
        PlatformFile file = _filePickerResult!.files.first;
        final fileBytes = await File(file.path!).readAsBytes();
        final inputFiles = InputFile.fromBytes(bytes: fileBytes, filename: file.name);
        final response = await storage.createFile(bucketId: bucketId, fileId: ID.unique(), file: inputFiles);
        print(response.$id);
        return response.$id;
      } else {
        print(('Something went wrong'));
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const CustomHeaderText(
                    text: 'Create Event',
                  ),
                  GestureDetector(
                    onTap: () => _openFilePicker(),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .3,
                      decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
                      child: _filePickerResult != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image(
                                image: FileImage(File(_filePickerResult!.files.first.path!)),
                                fit: BoxFit.fill,
                              ),
                            )
                          : const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                              )
                            ]),
                    ),
                  ),
                  CustomInputForm(
                    controller: _nameController,
                    icon: Icons.event_outlined,
                    label: "Event Name",
                    hint: "Add Event Name",
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Please provide name';
                      }
                    },
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
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Please provide description';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInputForm(
                    controller: _locationController,
                    icon: Icons.location_on_outlined,
                    label: "Location",
                    hint: "Enter Location of Event",
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Please provide location';
                      }
                    },
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
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Please provide Date and Time';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInputForm(
                    controller: _guestController,
                    icon: Icons.people_outlined,
                    label: "Guests",
                    hint: "Enter list of guests",
                    // validator: (p0) {
                    //   if (p0!.isEmpty) {
                    //     return 'Please provide guest name';
                    //   }
                    // },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInputForm(
                    controller: _sponsorsController,
                    icon: Icons.attach_money_outlined,
                    label: "Sponsors",
                    hint: "Enter Sponsors",
                    // validator: (p0) {
                    //   if (p0!.isEmpty) {
                    //     return 'Please provide sponsors';
                    //   }
                    // },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        "In Person Event",
                        style: TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        activeColor: Colors.teal,
                        focusColor: Colors.tealAccent,
                        value: _isInPersonEvent,
                        onChanged: (value) {
                          setState(
                            () {
                              _isInPersonEvent = value;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      final name = _nameController.text.trim();
                      final description = _descController.text.trim();
                      final location = _locationController.text.trim();
                      final dateTime = _dateTimeController.text.trim();
                      final guest = _guestController.text.trim();
                      final sponsors = _sponsorsController.text.trim();

                      _key.currentState!.save();
                      if (_filePickerResult == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Image must also be uploaded',
                            ),
                          ),
                        );
                      } else {
                        if (_key.currentState!.validate()) {
                          uploadEventImage().then(
                            (value) => createEvent(
                              name: name,
                              description: description,
                              image: value,
                              location: location,
                              datetime: dateTime,
                              createdBy: userId,
                              isInPerson: _isInPersonEvent,
                              guest: guest,
                              sponsors: sponsors,
                            ).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Event Created Successfully',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.black26,
                      ),
                      child: const Text(
                        "Create New Event",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
