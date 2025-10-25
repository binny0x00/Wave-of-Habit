import 'package:flutter/material.dart';
import 'package:wave_of_habit/feature/home/home_page.dart';

class ScoreBanner extends StatelessWidget {
  const ScoreBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final todayModel = TodayModelProvider.of(context, aspect: 'message')!.todayModel;
    final message = todayModel.message;

    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
