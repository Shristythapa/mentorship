
import 'package:app/features/mentee_dashboard/presentation/viewmodel/mentee_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenteeDashboard extends ConsumerStatefulWidget {
  const MenteeDashboard({super.key});

  @override
  ConsumerState<MenteeDashboard> createState() => _MenteeDashboardState();
}

class _MenteeDashboardState extends ConsumerState<MenteeDashboard> {
  @override
  void initState() {
    // accelerometerEvents!.listen((AccelerometerEvent event) {
    //   // Check if the x-axis value is negative (device tilted to the left)
    //   bool canChangeIndex = true;

    //   if (event.y < 5.0 && canChangeIndex) {
    //     // Navigate to the desired screen
    //     if (ref.read(menteeDashboardViewModelProvider).index > 0) {
    //       // Prevent further changes until the timeout is over
    //       canChangeIndex = false;
    //       ref.read(menteeDashboardViewModelProvider.notifier).changeIndex(
    //           ref.read(menteeDashboardViewModelProvider).index - 1);

    //       // Wait for 5 seconds before allowing another change
    //       Future.delayed(const Duration(seconds: 5), () {
    //         // Re-enable index change after 5 seconds
    //         canChangeIndex = true;
    //       });
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menteeDashboardState = ref.watch(menteeDashboardViewModelProvider);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: menteeDashboardState.listWidgets[menteeDashboardState.index],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.video_camera_front,
                  size: 25,
                ),
                label: 'My Sessions',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.video_call_rounded,
                  size: 25,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                  size: 25,
                ),
                label: 'Mentors',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.article,
                  size: 25,
                ),
                label: 'Article',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 25,
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: menteeDashboardState.index,
            iconSize: 28,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            onTap: (index) {
              ref
                  .read(menteeDashboardViewModelProvider.notifier)
                  .changeIndex(index);
            }),
      ),
    );
  }
}
