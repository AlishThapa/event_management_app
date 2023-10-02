import 'package:appwrite/models.dart';
import 'package:event_management_app/module/database/database.dart';
import 'package:event_management_app/module/widgets/date_time.dart';
import 'package:flutter/material.dart';

import '../widgets/date_time_location.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key, required this.document});

  final Document document;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool isRSVPedEvent = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  image: NetworkImage(
                    'https://cloud.appwrite.io/v1/storage/buckets/6517a3530e7703544b64/files/${widget.document.data["image"]}/view?project=6514426ecc07f38d46b7&mode=admin',
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, left: 10),
                    child: DateTimeLocationInfo(
                      date: '${formatDate(widget.document.data["dateTime"])}',
                      time: '${formatTime(widget.document.data["dateTime"])}',
                      location: '${widget.document.data["location"]}',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 7),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DETAILS',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Name: ${widget.document.data["name"]}',
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Icon(Icons.share)
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                  ),

                  ///DESCRIPTION
                  Text(
                    widget.document.data["description"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),

                  ///PARTICIPANTS
                  Text(
                    "${widget.document.data["participants"].length} people are attending.",
                    style: const TextStyle(
                      color: Colors.tealAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),

                  ///SPEICAL GUEST
                  const Text(
                    "Special Guests ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),

                  ///GUEST
                  Text(
                    "${widget.document.data["guest"] == "" ? "None" : widget.document.data["guest"]}",
                    style: const TextStyle(
                      color: Colors.tealAccent,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),

                  ///SPONSORS
                  const Text(
                    "Sponsors ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.document.data["sponsors"] == "" ? "None" : widget.document.data["sponsors"]}",
                    style: const TextStyle(
                      color: Colors.tealAccent,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),

                  ///MORE INFO
                  const Text(
                    "More Info ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),

                  ///EVENT TYPE
                  Text(
                    "Event Type : ${widget.document.data["isInPerson"] == true ? "In Person" : "Virtual"}",
                    style: const TextStyle(
                      color: Colors.tealAccent,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    rsvpEvent(documentId: widget.document.$id, participants: widget.document.data["participants"]).then(
                      (value) {
                        if (value) {
                          setState(
                            () {
                              isRSVPedEvent = true;
                            },
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('RSVP Successful'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Something went wrong'),
                            ),
                          );
                        }
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    child: const Text(
                      "RSVP Event",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
