import 'package:all_sensors2/all_sensors2.dart';
import 'package:app/features/mentor_dashboard/presentation/viewmodel/mentor_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorDashboard extends ConsumerStatefulWidget {
  const MentorDashboard({super.key});

  @override
  ConsumerState<MentorDashboard> createState() => _MentorDashboardState();
}

class _MentorDashboardState extends ConsumerState<MentorDashboard> {
  @override
  void initState() {
    // accelerometerEvents!.listen((AccelerometerEvent event) {
    //   // Check if the x-axis value is negative (device tilted to the left)
    //   if (event.y < 2.0) {
    //     // Navigate to the desired screen
    //     if (ref.read(mentorDashboardViewModelProvider).index > 0) {
    //       ref.read(mentorDashboardViewModelProvider.notifier).changeIndex(
    //           ref.read(mentorDashboardViewModelProvider).index - 1);
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mentorDashboarState = ref.watch(mentorDashboardViewModelProvider);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: Center(
          child: mentorDashboarState.listWidget[mentorDashboarState.index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.class_outlined, size: 24),
              label: 'My Sessions',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.description,
                size: 25,
              ),
              label: 'Article',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: mentorDashboarState.index,
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          onTap: (index) {
            ref
                .read(mentorDashboardViewModelProvider.notifier)
                .changeIndex(index);
          },
        ),
      ),
    );
  }
}
