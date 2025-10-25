import 'package:flutter/material.dart';
import 'package:wave_of_habit/feature/home/home_page.dart';

class WaterRoom extends StatelessWidget {
  const WaterRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final todayModel = TodayModelProvider.of(context, aspect: 'waterLevel')!.todayModel;
    final waterLevel = todayModel.waterLevel;

    return Stack(
      children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/room.png'), // Placeholder for room image
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Water Animation
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: MediaQuery.of(context).size.height * waterLevel,
            color: Colors.blue.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
