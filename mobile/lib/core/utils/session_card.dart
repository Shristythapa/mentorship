import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SessionCard extends StatelessWidget {
  String sessionName;
  String date;
  String time;
  String status;
  String selectedIndex;
  SessionCard(
      {super.key,
      required this.status,
      required this.sessionName,
      required this.date,
      required this.time,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 12)),
              Text(time,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 9))
            ],
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(sessionName,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 15)),
                ),
                selectedIndex == "all"
                    ? status == "ongoing"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pause_circle_outline,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "ongoing",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 10),
                              )
                            ],
                          )
                        : status == "upcoming"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_circle_outline,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "upcoming",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 10),
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outlined,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "completed",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 10),
                                  )
                                ],
                              )
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
