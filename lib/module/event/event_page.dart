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
  final TextEditingController _sponsersController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const CustomHeaderText(
                  text: 'Create Event',
                ),
                GestureDetector(
                  // onTap: () => _openFilePicker(),
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
                CustomInputForm(controller: _nameController, icon: Icons.event_outlined, label: "Event Name", hint: "Add Event Name"),
                const SizedBox(
                  height: 8,
                ),
                CustomInputForm(
                    maxLines: 4, controller: _descController, icon: Icons.description_outlined, label: "Description", hint: "Add Description"),
                const SizedBox(
                  height: 8,
                ),
                CustomInputForm(
                    controller: _locationController, icon: Icons.location_on_outlined, label: "Location", hint: "Enter Location of Event"),
                const SizedBox(
                  height: 8,
                ),
                CustomInputForm(
                  controller: _dateTimeController,
                  icon: Icons.date_range_outlined,
                  label: "Date & Time",
                  hint: "Pickup Date Time",
                  readOnly: true,
                  // onTap: () => _selectDateTime(context),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomInputForm(controller: _guestController, icon: Icons.people_outlined, label: "Guests", hint: "Enter list of guests"),
                const SizedBox(
                  height: 8,
                ),
                CustomInputForm(controller: _sponsersController, icon: Icons.attach_money_outlined, label: "Sponsers", hint: "Enter Sponsers"),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
