import 'package:app/core/utils/session_card_mentee.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/core/utils/session_details.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenteeSessionList extends ConsumerStatefulWidget {
  const MenteeSessionList({super.key});

  @override
  ConsumerState<MenteeSessionList> createState() => _MenteeSessionListState();
}

class _MenteeSessionListState extends ConsumerState<MenteeSessionList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sessionViewModelPrvoider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.message != "" && state.showMessage) {
        SnackBarManager.showSnackBar(
            isError: state.isError, message: state.message, context: context);
        ref.read(sessionViewModelPrvoider.notifier).resetState();
      }
    });
    TextEditingController searchController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xFFFDFBFF),
        appBar: AppBar(
          // backgroundColor: Colors.white,
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
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 0,
                          );
                        },
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SessionDetails(
                                          isMentor: false,
                                          sessionEntity: state.sessions[index],
                                        )),
                              );
                            },
                            child: SessionCardMentee(
                              status: state.sessions[index].date
                                      .isAfter(DateTime.now())
                                  ? "upcomming"
                                  : "completed",
                              sessionName: state.sessions[index].title,
                              date: state.sessions[index].date.toString(),
                              time: state.sessions[index].startTime,
                              selectedIndex: index.toString(),
                            ),
                          );
                        },
                        itemCount: state.sessions.length,
                      ),
                    ),
                    if (state.isLoading)
                      const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 10),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, SessionEntity sessionEntity,
    SessionViewModel sessionState) {
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
        onPressed: () async {
          sessionState.joinSession(sessionEntity);
        },
        child: const Text('Join'),
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
