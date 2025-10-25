
import 'package:flutter/material.dart';
import 'package:wave_of_habit/feature/home/home_controller.dart';
import 'package:wave_of_habit/feature/home/home_state.dart';
import 'package:wave_of_habit/feature/home/widgets/habit_tile.dart';
import 'package:wave_of_habit/feature/home/widgets/score_banner.dart';
import 'package:wave_of_habit/feature/home/widgets/todays_actions_input.dart';
import 'package:wave_of_habit/feature/home/widgets/water_room.dart';

class TodayModelProvider extends InheritedModel<String> {
  final TodayModel todayModel;

  const TodayModelProvider({
    super.key,
    required this.todayModel,
    required super.child,
  });

  static TodayModelProvider? of(BuildContext context, {String? aspect}) {
    return InheritedModel.inheritFrom<TodayModelProvider>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(TodayModelProvider oldWidget) {
    return todayModel != oldWidget.todayModel;
  }

  @override
  bool updateShouldNotifyDependent(
      TodayModelProvider oldWidget, Set<String> dependencies) {
    if (dependencies.contains('score') && todayModel.score != oldWidget.todayModel.score) {
      return true;
    }
    if (dependencies.contains('waterLevel') && todayModel.waterLevel != oldWidget.todayModel.waterLevel) {
      return true;
    }
    if (dependencies.contains('message') && todayModel.message != oldWidget.todayModel.message) {
      return true;
    }
    if (dependencies.contains('washed') && todayModel.washed != oldWidget.todayModel.washed) {
      return true;
    }
    if (dependencies.contains('packed') && todayModel.packed != oldWidget.todayModel.packed) {
      return true;
    }
    if (dependencies.contains('extraActs') && todayModel.extraActs != oldWidget.todayModel.extraActs) {
      return true;
    }
    return false;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(
      onStateChanged: () {
        setState(() {});
      },
    );
    _controller.loadTodayData();
  }

  @override
  Widget build(BuildContext context) {
    return TodayModelProvider(
      todayModel: _controller.todayModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('오늘은 텀블러 씻었나요?'),
        ),
        body: const Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  WaterRoom(),
                  ScoreBanner(),
                ],
              ),
            ),
            HabitTiles(),
            TodayActionsInput(),
            SizedBox(height: 32),
            Text('내일도 뽀송하게 ☀️'),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
