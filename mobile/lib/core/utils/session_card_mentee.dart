import 'package:app/core/utils/flashing_text.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class SessionCardMentee extends StatelessWidget {
  String sessionName;
  String date;
  String time;
  String status;
  String selectedIndex;
  SessionCardMentee(
      {super.key,
      required this.status,
      required this.sessionName,
      required this.date,
      required this.time,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(
              10), // Optional: Add border radius for rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(
                  0.2), // Adjust the shadow color and opacity as needed
              spreadRadius: 0,
              blurRadius:
                  10, // Adjust the blur radius to control the amount of "elevation"
              offset: const Offset(0,
                  5), // Adjust the offset to control the position of the shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            status == "ongoing"
                ? const FlashingText(text: "ongoing")
                : status == "upcoming"
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(35, 15, 0, 2),
                        child: const Text(
                          "upcomming",
                          style: TextStyle(fontSize: 13, color: Colors.green),
                        ))
                    : status == "completed"
                        ? Container(
                            padding: const EdgeInsets.fromLTRB(35, 15, 0, 2),
                            child: const Text(
                              "completed",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ))
                        : Container(
                            padding: const EdgeInsets.fromLTRB(35, 15, 0, 2),
                            child: const Text(
                              "next",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.green),
                            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(sessionName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 15)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 12)),
                    Text(time,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 10))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
