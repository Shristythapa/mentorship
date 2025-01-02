import 'package:app/config/routes/app_routes.dart';
import 'package:app/core/utils/session_card.dart';
import 'package:app/core/utils/session_details.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/mentor_dashboard/presentation/viewmodel/session_view_model.dart';
import 'package:app/features/sessions/presentation/viewmodel/mentor_session_view_model.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorMySessions extends ConsumerStatefulWidget {
  const MentorMySessions({Key? key}) : super(key: key);

  @override
  ConsumerState<MentorMySessions> createState() => _MentorMySessionsState();
}

class _MentorMySessionsState extends ConsumerState<MentorMySessions> {
  final ScrollController _scrollController = ScrollController();

  String formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mentorMySessionsControllerProvider);

    final sessionState = ref.watch(mentorSessionViewModelPrvoider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (sessionState.message != "" && sessionState.showMessage) {
        SnackBarManager.showSnackBar(
            isError: sessionState.isError,
            message: sessionState.message!,
            context: context);
        ref.read(mentorSessionViewModelPrvoider.notifier).resetState();
      }
    });
    return Scaffold(
      appBar: AppBar(
        // Add the AppBar here
        title: const Text("My Sessions"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      ref
                          .read(mentorMySessionsControllerProvider.notifier)
                          .setSelectedIndex("all");
                    },
                    child: state.selectedIndex == "all"
                        ? Container(
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(244, 244, 244, 1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Text(
                              "All",
                              style: TextStyle(
                                color: Color(0XFFEEA025),
                              ),
                            ),
                          )
                        : const Text("All"),
                  ),
                  InkWell(
                    onTap: () {
                      ref
                          .read(mentorMySessionsControllerProvider.notifier)
                          .setSelectedIndex("upcoming");
                    },
                    child: state.selectedIndex == "upcoming"
                        ? Container(
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(244, 244, 244, 1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Text(
                              "Upcoming",
                              style: TextStyle(
                                color: Color(0XFFEEA025),
                              ),
                            ),
                          )
                        : const Text("Upcoming"),
                  ),
                  InkWell(
                    onTap: () {
                      ref
                          .read(mentorMySessionsControllerProvider.notifier)
                          .setSelectedIndex("completed");
                    },
                    child: state.selectedIndex == "completed"
                        ? Container(
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(244, 244, 244, 1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Text(
                              "Completed",
                              style: TextStyle(
                                color: Color(0XFFEEA025),
                              ),
                            ),
                          )
                        : const Text("Completed"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref
                      .read(mentorSessionViewModelPrvoider.notifier)
                      .resetState();
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 0,
                    );
                  },
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (state.selectedIndex == "upcoming" &&
                        sessionState.sessions[index].date
                            .isAfter(DateTime.now())) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SessionDetails(
                                      isMentor: true,
                                      sessionEntity:
                                          sessionState.sessions[index],
                                    )),
                          );
                        },
                        child: SessionCard(
                          status: "upcomming",
                          sessionName: sessionState.sessions[index].title,
                          date: formatDate(sessionState.sessions[index].date),
                          time: sessionState.sessions[index].startTime,
                          selectedIndex: state.selectedIndex.toString(),
                        ),
                      );
                    } else if (state.selectedIndex == "completed" &&
                        sessionState.sessions[index].date
                            .isBefore(DateTime.now())) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SessionDetails(
                                      isMentor: true,
                                      sessionEntity:
                                          sessionState.sessions[index],
                                    )),
                          );
                        },
                        child: SessionCard(
                          status: "completed",
                          sessionName: sessionState.sessions[index].title,
                          date: formatDate(sessionState.sessions[index].date),
                          time: sessionState.sessions[index].startTime,
                          selectedIndex: state.selectedIndex.toString(),
                        ),
                      );
                    }
                    if (state.selectedIndex == "all") {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SessionDetails(
                                      isMentor: true,
                                      sessionEntity:
                                          sessionState.sessions[index],
                                    )),
                          );
                        },
                        child: SessionCard(
                          status: sessionState.sessions[index].date
                                  .isAfter(DateTime.now())
                              ? "upcoming"
                              : "completed",
                          sessionName: sessionState.sessions[index].title,
                          date: formatDate(sessionState.sessions[index].date),
                          time: sessionState.sessions[index].startTime,
                          selectedIndex: state.selectedIndex.toString(),
                        ),
                      );
                    }
                    return null;
                  },
                  itemCount: sessionState.sessions.length,
                ),
              ),
            ),
            if (sessionState.isLoading)
              const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          foregroundColor: const Color(0xFFEEA025),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.createSession);
          },
          child: const Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}
