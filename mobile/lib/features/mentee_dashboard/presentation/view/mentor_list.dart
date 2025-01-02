import 'package:app/core/utils/mentor_card.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/core/utils/session_details.dart';
import 'package:app/features/mentee_dashboard/presentation/view/mentee_mentor_profile_view.dart';
import 'package:app/features/mentorSearch/presentation/viewmodel/mentor_search_view_model.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorList extends ConsumerStatefulWidget {
  const MentorList({Key? key}) : super(key: key);

  @override
  _MentorListState createState() => _MentorListState();
}

class _MentorListState extends ConsumerState<MentorList> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedSkill;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mentorSearchViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.message != "" && state.showMessage) {
        SnackBarManager.showSnackBar(
            isError: state.isError, message: state.message, context: context);
        ref.read(mentorSearchViewModelProvider.notifier).resetState();
      }
    });

    // Filter mentors based on the selected skill
    final filteredMentors =
        _selectedSkill == null || _selectedSkill == "All Skills"
            ? state.mentors
            : state.mentors
                .where((mentor) => mentor.skills.contains(_selectedSkill))
                .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Explore Mentors",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: RefreshIndicator(
              onRefresh: () async {
                ref.read(mentorSearchViewModelProvider.notifier).resetState();
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  DropdownButton<String>(
                    value: _selectedSkill ?? 'All Skills',
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSkill = newValue!;
                      });
                    },
                    items: ['All Skills']
                        .followedBy(
                            state.mentors.expand((mentor) => mentor.skills))
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
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
                                builder: (context) => MenteeMentorProfileView(
                                  entity: filteredMentors[index],
                                ),
                              ),
                            );
                          },
                          child: MentorCard(
                            name: filteredMentors[index].name,
                            experties: filteredMentors[index].skills ?? [],
                            image: filteredMentors[index].profileUrl,
                          ),
                        );
                      },
                      itemCount: filteredMentors.length,
                    ),
                  ),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
