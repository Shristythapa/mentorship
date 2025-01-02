import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/core/utils/flashing_text.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/presentation/viewmodel/mentor_session_view_model.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:app/features/video_call/presentation/view/video_conference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionDetails extends ConsumerStatefulWidget {
  final SessionEntity sessionEntity;
  final bool isMentor;
  const SessionDetails(
      {Key? key, required this.sessionEntity, required this.isMentor})
      : super(key: key);

  @override
  ConsumerState<SessionDetails> createState() => _SessionDetailsState();
}

class _SessionDetailsState extends ConsumerState<SessionDetails> {
  late dynamic user; // Declare a variable to store the user information

  @override
  void initState() {
    super.initState();
    _getUserDetails(); // Call the method to fetch user details
  }

  Future<void> _getUserDetails() async {
    var userResult = await ref.read(userSharedPrefsProvider).getUserDetails();
    userResult.fold(
      (failure) {
        SnackBarManager.showSnackBar(
          isError: true,
          message: "Token Invalid",
          context: context,
        );
      },
      (fetchedUser) {
        setState(() {
          user = fetchedUser; // Update the user variable with fetched user
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            widget.sessionEntity.title,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        widget.sessionEntity.isOngoing
                            ? const FlashingText(text: "Ongoing")
                            : widget.sessionEntity.date.isAfter(DateTime.now())
                                ? const Text(
                                    "upcomming",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.green),
                                  )
                                : widget.sessionEntity.date
                                        .isBefore(DateTime.now())
                                    ? const Text(
                                        "completed",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.red),
                                      )
                                    : const Text(
                                        "today",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.green),
                                      )
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontFamily: 'nunitoSans',
                            fontWeight: FontWeight.w900,
                            fontSize: 15),
                      ),
                      const Divider(),
                      Text(
                        widget.sessionEntity.description,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(
                            fontFamily: 'nunitoSans',
                            fontWeight: FontWeight.w900,
                            fontSize: 15),
                      ),
                      const Divider(),
                      Text(
                        widget.sessionEntity.date.toString(),
                      ),
                      Text(
                          "${widget.sessionEntity.startTime} - ${widget.sessionEntity.endTime}")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Session Details",
                        style: TextStyle(
                            fontFamily: 'nunitoSans',
                            fontWeight: FontWeight.w900,
                            fontSize: 15),
                      ),
                      const Divider(),
                      Text(
                          "No of attendendes signed : ${widget.sessionEntity.attendesSigned.length}"),
                      Text(
                          "Max attendendes taking : ${widget.sessionEntity.maxNumberOfAttendesTaking}"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                //if mentor show delete
                user != null &&
                        user['email'] == widget.sessionEntity.mentorEmail
                    ? Center(
                        child: SizedBox(
                          width: 280,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              ref
                                  .read(mentorSessionViewModelPrvoider.notifier)
                                  .deleteSession(widget.sessionEntity.id!);
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),

                //if not mentor and session is ongoing
                user != null &&
                        user['email'] != widget.sessionEntity.mentorEmail
                    ? Center(
                        child: SizedBox(
                          width: 280,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoCallPage(
                                    sessionEntity: widget.sessionEntity,
                                    isMentor: false,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Join Call",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      )
                    //if not mentor and session is upcomming
                    : user != null &&
                            user['email'] == widget.sessionEntity.mentorEmail &&
                            widget.sessionEntity.date.isAfter(DateTime.now())
                        ? Center(
                            child: SizedBox(
                              width: 280,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoCallPage(
                                        sessionEntity: widget.sessionEntity,
                                        isMentor: true,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Start",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                const SizedBox(
                  height: 20,
                ),
                //if session is not joined
                widget.sessionEntity.date.isAfter(DateTime.now())
                    ? widget.isMentor == false
                        ? widget.sessionEntity.attendesSigned.any((attendee) =>
                                attendee['email'] == user['email'])
                            ? Container()
                            : Center(
                                child: SizedBox(
                                  width: 280,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(sessionViewModelPrvoider
                                                .notifier)
                                            .joinSession(widget.sessionEntity);
                                      },
                                      child: const Text(
                                        "Apply",
                                        style: TextStyle(fontSize: 22),
                                      )),
                                ),
                              )
                        : Container()
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
