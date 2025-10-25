import 'package:flutter/material.dart';
import 'package:wave_of_habit/feature/home/home_controller.dart';
import 'package:wave_of_habit/feature/home/home_page.dart';

class HabitTiles extends StatelessWidget {
  const HabitTiles({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final todayModel = TodayModelProvider.of(context, aspect: 'washed')!.todayModel;

    return Column(
      children: [
        CheckboxListTile(
          title: const Text('텀블러 씻기'),
          value: todayModel.washed,
          onChanged: (bool? value) {
            controller.toggleWashed(value ?? false);
          },
        ),
        CheckboxListTile(
          title: const Text('텀블러 챙기기'),
          value: todayModel.packed,
          onChanged: (bool? value) {
            controller.togglePacked(value ?? false);
          },
        ),
      ],
    );
  }
}
