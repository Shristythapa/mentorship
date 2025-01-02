import 'package:app/core/utils/session_card_mentee.dart';
import 'package:app/core/utils/session_details.dart';
import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class MenteeMentorProfileView extends ConsumerStatefulWidget {
  MentorSearchEntity entity;
  MenteeMentorProfileView({Key? key, required this.entity}) : super(key: key);

  @override
  ConsumerState<MenteeMentorProfileView> createState() =>
      _MenteeMentorProfileViewState();
}

class _MenteeMentorProfileViewState
    extends ConsumerState<MenteeMentorProfileView> {
  @override
  void initState() {
    ref.read(sessionViewModelPrvoider.notifier).getAllSessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sessionViewModelPrvoider);

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
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF6D3F83),
                          radius: 70,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.entity.profileUrl),
                            radius: 70,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.entity.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      const Divider(),
                      const Text(
                        "Experties",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Wrap(
                        spacing: 8,
                        children: widget.entity.skills
                            .map(
                              (item) => Chip(
                                // Display the tag text inside a chip
                                backgroundColor: const Color(0xFFDECBF6),
                                label: Text(
                                  item,
                                  style: const TextStyle(
                                      color: Color(
                                        0xFF444444,
                                      ),
                                      fontSize: 15),
                                ),
                                // Icon button to remove the tag when pressed
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.isLoading)
                ...{}
              else if (state.isError) ...{
                Text(state.message)
              } else if (state.sessions.isNotEmpty) ...{
                Expanded(
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 0,
                      );
                    },
                    itemBuilder: (context, index) {
                      final filteredSessions = state.sessions
                          .where((session) =>
                              session.mentorEmail == widget.entity.email)
                          .toList();
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SessionDetails(
                                      sessionEntity: filteredSessions[index],
                                      isMentor: false,
                                    )),
                          );
                        },
                        child: SessionCardMentee(
                          status: filteredSessions[index].isOngoing
                              ? "ongoing"
                              : filteredSessions[index]
                                      .date
                                      .isAfter(DateTime.now())
                                  ? "upcoming"
                                  : "completed",
                          sessionName: filteredSessions[index].title,
                          date: filteredSessions[index].date.toString(),
                          time: filteredSessions[index].startTime,
                          selectedIndex: index.toString(),
                        ),
                      );
                    },
                    itemCount: state.sessions
                        .where((session) =>
                            session.mentorEmail == widget.entity.email)
                        .length,
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
