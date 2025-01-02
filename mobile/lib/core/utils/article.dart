import 'package:app/features/mentee_dashboard/presentation/view/mentee_mentor_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArticleContainer extends StatelessWidget {
  String profile;
  String title;
  String mentor;
  String body;

  ArticleContainer(
      {super.key,
      required this.profile,
      required this.body,
      required this.title,
      required this.mentor,
      l});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(10),
      height: 280,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                //  Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => MenteeMentorProfileView(
                //             entity: men,
                //           )),
                // );
              },
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profile),
                      radius: 30,
                    ),
                  ),
                  Text(
                    mentor,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              body,
              overflow: TextOverflow
                  .ellipsis, // Display ellipsis (...) when text overflows
              maxLines: 3, // Limit the number of lines
            ),
            const Text(
              "Read More",
              style: TextStyle(
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            )
          ],
        ),
      ),
    );
  }
}
