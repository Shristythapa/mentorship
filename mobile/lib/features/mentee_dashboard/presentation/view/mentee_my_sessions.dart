import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/core/utils/session_card_mentee.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/core/utils/session_details.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MenteeMySessions extends ConsumerStatefulWidget {
  const MenteeMySessions({super.key});

  @override
  ConsumerState<MenteeMySessions> createState() => _MenteeMySessionsState();
}

class _MenteeMySessionsState extends ConsumerState<MenteeMySessions> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = true; // Add loading state variable

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadEmail(); // Load email on initialization
    super.initState();
  }

  String? email;

  Future<void> _loadEmail() async {
    // Simulate loading for demonstration purpose
    await Future.delayed(const Duration(seconds: 2));
    _isLoading = true;

    // Retrieve email from SharedPreferences
    final eitherToken = await ref.read(userSharedPrefsProvider).getUserToken();
    eitherToken.fold(
      (failure) {
        // Handle failure
        setState(() {
          _isLoading = false;
        });
        SnackBarManager.showSnackBar(
            isError: true, message: "Token Invalid", context: context);
      },
      (token) {
        // Handle success
        print("Token: $token");

        // Parse the token if it exists
        final Map<String, dynamic>? decodedToken =
            token != null ? JwtDecoder.decode(token) : null;

        // Ensure a minimum duration by waiting for both the splash screen duration and token retrieval process
        if (decodedToken != null) {
          email = decodedToken['email'];
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          SnackBarManager.showSnackBar(
              isError: true, message: "Token Invalid", context: context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sessionViewModelPrvoider);
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              shadowColor: Colors.white,
              title: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Explore Sessions",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),

            // backgroundColor: Colors.white,
            body: Container(
              margin: const EdgeInsets.all(20),
              child: SizedBox(
                height: double.infinity,
                // width: MediaQuery.of(context).size.width * 0.9,
                width: double.infinity,
                child: RefreshIndicator(
                    onRefresh: () async {
                      ref.read(sessionViewModelPrvoider.notifier).resetState();
                    },
                    child: Column(
                      children: [
                        // CustomSearchBar(controller: searchController),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: ListView.separated(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 0,
                              );
                            },
                            itemBuilder: (context, index) {
                              // Use `any` to check if any of the attendees signed match the condition
                              if (state.sessions[index].attendesSigned.any(
                                  (attendee) => attendee['email'] == email)) {
                                // If the condition is met, return the SessionCardMentee widget
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SessionDetails(
                                                sessionEntity:
                                                    state.sessions[index],
                                                isMentor: false,
                                              )),
                                    );
                                  },
                                  child: SessionCardMentee(
                                    status: state.sessions[index].isOngoing
                                        ? "ongoing"
                                        : state.sessions[index].date
                                                .isAfter(DateTime.now())
                                            ? "upcomming"
                                            : "completed",
                                    sessionName: state.sessions[index].title,
                                    date: state.sessions[index].date.toString(),
                                    time: state.sessions[index].startTime,
                                    selectedIndex: index.toString(),
                                  ),
                                );
                              } else {
                                // If the condition is not met, return null or an empty container
                                return Container(); // or null
                              }
                            },
                            itemCount: state.sessions.length,
                          ),
                        ),
                        if (state.isLoading)
                          const CircularProgressIndicator(color: Colors.yellow),
                        const SizedBox(height: 10),
                      ],
                    )),
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, SessionEntity sessionEntity) {
  return AlertDialog(
    title: Text(sessionEntity.title),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildRichText(
            "Description:", sessionEntity.description, 18, Colors.purple),
        _buildRichText("Date:", "${sessionEntity.date}", 18, Colors.purple),
        _buildRichText(
            "Time:",
            "${sessionEntity.startTime} to ${sessionEntity.endTime}",
            18,
            Colors.purple),
        _buildRichText("Mentor:", sessionEntity.mentorName, 18, Colors.purple),
        _buildRichText("Max no of Attendes taking:",
            "${sessionEntity.maxNumberOfAttendesTaking}", 18, Colors.purple),
        _buildRichText("No of Attendes Signed:",
            "${sessionEntity.noOfAttendesSigned}", 18, Colors.purple),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Start'),
      ),
    ],
  );
}

Widget _buildRichText(
    String label, String value, double fontSize, Color color) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: "$label ",
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
        ),
      ],
    ),
  );
}
