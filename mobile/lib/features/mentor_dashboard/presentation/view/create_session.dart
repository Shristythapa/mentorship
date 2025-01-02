import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/mentorSearch/domain/usecases/get_mentor_by_id_usecase.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/presentation/viewmodel/mentor_session_view_model.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class CreateSession extends ConsumerStatefulWidget {
  const CreateSession({Key? key}) : super(key: key);

  @override
  _CreateSessionState createState() => _CreateSessionState();
}

class _CreateSessionState extends ConsumerState<CreateSession> {
  TextEditingController sessionTitleController = TextEditingController();
  TextEditingController sessionDescriptionController = TextEditingController();
  TextEditingController sessionDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController noOfAttendesController = TextEditingController();

  DateTime _parseTimeOfDay(String timeString) {
    // Get the current date
    DateTime now = DateTime.now();

    // Parse the time string
    TimeOfDay timeOfDay =
        TimeOfDay.fromDateTime(DateFormat.jm().parse(timeString.trim()));
    print("time of the dat $timeOfDay");

    // Combine the time with today's date
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(mentorSessionViewModelPrvoider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (sessionState.showMessage) {
        SnackBarManager.showSnackBar(
            message: sessionState.message!,
            context: context,
            isError: sessionState.isError);
        ref.read(sessionViewModelPrvoider.notifier).resetState();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Session'),
      ),
      body: Stack(
        children: [
          Form(
            key: form,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(
                  height: 30,
                ),
                // session title //
                TextFormField(
                  style: const TextStyle(fontSize: 20),
                  controller: sessionTitleController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Session Title is invalid";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red[900]),
                    prefixIcon:
                        const Icon(Icons.mail, color: Color(0xFF6D3F83)),
                    labelText: "Title",
                    labelStyle: const TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  keyboardType: TextInputType.text,
                  // onChanged: (value) => setState(() {
                  //   sessionTitle = value;
                  // }),
                ),
                const SizedBox(
                  height: 30,
                ),
                // description///
                TextFormField(
                  style: const TextStyle(fontSize: 20),
                  controller: sessionDescriptionController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Session Description is invalid";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red[900]),
                    prefixIcon:
                        const Icon(Icons.mail, color: Color(0xFF6D3F83)),
                    labelText: "Description",
                    labelStyle: const TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  keyboardType: TextInputType.text,
                  // onChanged: (value) => setState(() {
                  //   sessionDescription = value;
                  // }),
                ),
                const SizedBox(
                  height: 30,
                ),

                TextFormField(
                  controller: sessionDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    labelStyle: const TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    prefixIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today,
                          color: Color(0xFF6D3F83)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),

                TextFormField(
                  controller: startTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Start Time',
                    labelStyle: const TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () =>
                          _selectStartTime(context, startTimeController),
                      icon: const Icon(
                        Icons.access_time,
                        color: Color(0xFF6D3F83),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a start time';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 30,
                ),
                // end time ///
                TextFormField(
                  controller: endTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'End Time',
                    labelStyle: const TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () =>
                          _selectStartTime(context, endTimeController),
                      icon: const Icon(
                        Icons.access_time,
                        color: Color(0xFF6D3F83),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an end time';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 30,
                ),
                //no of attendes
                TextFormField(
                  style: const TextStyle(fontSize: 20),
                  controller: noOfAttendesController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "No oF Attendes is invalid";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red[900]),
                    prefixIcon:
                        const Icon(Icons.mail, color: Color(0xFF6D3F83)),
                    labelText: "No of Attendies",
                    labelStyle: const TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  keyboardType: TextInputType.number,
                  // onChanged: (value) => setState(() {
                  //   noOfAttendes = int.parse(value);
                  // }),
                ),
                const SizedBox(
                  height: 30,
                ),
                //button
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (() async {
                      if (form.currentState!.validate()) {
                        // DateTime startTime =
                        //     _parseTimeOfDay(startTimeController.text);
                        // DateTime endTime =
                        //     _parseTimeOfDay(endTimeController.text);

                        // if (startTime.isAfter(endTime)) {
                        //   return SnackBarManager.showSnackBar(
                        //       isError: true,
                        //       message: "Invalid time",
                        //       context: context);
                        // }
                        String mentorId;

                        final eitherToken = await ref
                            .read(userSharedPrefsProvider)
                            .getUserToken();
                        eitherToken.fold(
                          (failure) {
                            // Handle failure
                            return SnackBarManager.showSnackBar(
                                isError: true,
                                message: "Token Invalid",
                                context: context);
                          },
                          (token) async {
                            // Handle success
                            print("Token: $token");

                            // Parse the token if it exists
                            final Map<String, dynamic>? decodedToken =
                                token != null ? JwtDecoder.decode(token) : null;

                            // Ensure a minimum duration by waiting for both the splash screen duration and token retrieval process
                            await Future.wait([
                              Future.delayed(const Duration(
                                  seconds:
                                      5)), // Adjust as needed, this can be your splash screen duration
                              Future.microtask(() =>
                                  decodedToken), // Fetch the token concurrently
                            ]);

                            if (decodedToken != null) {
                              mentorId = decodedToken['id'];

                              // Call the GetMentorByIdUsecase to get the mentor
                              final mentorEither = await ref
                                  .read(getMentorByIdUseCaseProvider)
                                  .getMentorById(mentorId);

                              mentorEither.fold(
                                (failure) {
                                  // Handle failure
                                  SnackBarManager.showSnackBar(
                                      isError: true,
                                      message:
                                          "Failed to get mentor: ${failure.error}",
                                      context: context);
                                },
                                (mentor) {
                                  //create session entity
                                  SessionEntity sessionEntity = SessionEntity(
                                      mentorId: mentorId,
                                      mentorName: mentor.name,
                                      mentorEmail: mentor.email,
                                      title: sessionTitleController.text,
                                      description:
                                          sessionDescriptionController.text,
                                      date: DateTime.parse(
                                          sessionDateController.text),
                                      startTime: startTimeController.text,
                                      endTime: endTimeController.text,
                                      isOngoing: false,
                                      attendesSigned: [],
                                      noOfAttendesSigned: 0,
                                      maxNumberOfAttendesTaking: int.parse(
                                          noOfAttendesController.text));

                                  //create session call

                                  ref
                                      .read(mentorSessionViewModelPrvoider
                                          .notifier)
                                      .addSession(sessionEntity, context);
                                },
                              );
                            } else {
                              return SnackBarManager.showSnackBar(
                                  isError: true,
                                  message: "Token Invalid",
                                  context: context);
                            }
                          },
                        );

                        // SessionEntity session = SessionEntity(mentorId: , mentorName: mentorName, mentorEmail: mentorEmail, title: sessionTitleController.text, description: sessionDescriptionController.text, date: sessionDateController.text, startTime: ses, endTime: endTime, attendesSigned: attendesSigned, noOfAttendesSigned: noOfAttendesSigned, maxNumberOfAttendesTaking: maxNumberOfAttendesTaking)
                        // ref.read(sessionViewModelPrvoider.notifier).addSession(
                        //     SessionEntity(mentorId: mentorId, mentorName: mentorName, mentorEmail: mentorEmail, title: title, description: description, date: date, startTime: startTime, endTime: endTime, attendesSigned: attendesSigned, noOfAttendesSigned: noOfAttendesSigned, maxNumberOfAttendesTaking: maxNumberOfAttendesTaking)
                        //     );
                      }
                    }),
                    child: const Text(
                      "Create Session ",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (sessionState.isLoading)
            Positioned.fill(
              child: Container(
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        sessionDateController.text = picked.toString(); // Format this as needed
      });
    }
  }

  Future<void> _selectStartTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context); // Format this as needed
      });
    }
  }

  Future<void> _selectEndTime(
      BuildContext context, TextEditingController controller) async {
    // Check if start time is already selected
    if (startTimeController.text.isEmpty) {
      // If start time is not selected, show a message to prompt the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select start time first.'),
        ),
      );
      return; // Exit function early
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        // if (DateTime(endTimeController.text)
        //     .isBefore(DateTime(startTimeController.text))) {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('Date Invalid.'),
        //   ));
        // }
        controller.text = picked.format(context); // Format this as needed
      });
    }
  }
}
