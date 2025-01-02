import 'package:flutter/material.dart';

class MentorCard extends StatefulWidget {
  String name;
  List<String> experties;
  String image;
  MentorCard(
      {super.key,
      required this.name,
      required this.experties,
      required this.image});

  @override
  State<MentorCard> createState() => _MentorCardState();
}

class _MentorCardState extends State<MentorCard> {
  @override
  void initState() {
    print(widget.experties);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(
                      width: 200,
                      child: Wrap(
                        spacing: 15,
                        children: widget.experties
                            .map((e) => Chip(
                                  label: Text(
                                    e,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Add a radius of 10.0
                                    side: const BorderSide(
                                      color: Colors
                                          .transparent, // Change the border color to black
                                      width: 1.0, // Set the border width to 1.0
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF6D3F83),
                    radius: 30,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.image),
                      radius: 80,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
