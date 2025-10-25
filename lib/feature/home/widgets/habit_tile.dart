import 'package:flutter/material.dart';
import 'package:wave_of_habit/feature/home/home_page.dart';

class HabitTiles extends StatelessWidget {
  const HabitTiles({super.key});

  @override
  Widget build(BuildContext context) {
    final todayModel = TodayModelProvider.of(context, aspect: 'washed')!.todayModel;

    return Column(
      children: [
        CheckboxListTile(
          title: const Text('텀블러 씻기'),
          value: todayModel.washed,
          onChanged: (bool? value) {
            // Implement onChanged
          },
        ),
        CheckboxListTile(
          title: const Text('텀블러 챙기기'),
          value: todayModel.packed,
          onChanged: (bool? value) {
            // Implement onChanged
          },
        ),
      ],
    );
  }
}
