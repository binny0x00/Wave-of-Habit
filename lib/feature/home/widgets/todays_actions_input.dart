import 'package:flutter/material.dart';
import 'package:wave_of_habit/feature/home/home_page.dart';

class TodayActionsInput extends StatelessWidget {
  const TodayActionsInput({super.key});

  @override
  Widget build(BuildContext context) {
    final todayModel = TodayModelProvider.of(context, aspect: 'extraActs')!.todayModel;
    final extraActs = todayModel.extraActs;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '추가 실천 항목',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '예: 대중교통 이용',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // Implement onPressed
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...extraActs.map(
            (act) => Chip(
              label: Text(act),
              onDeleted: () {
                // Implement onDeleted
              },
            ),
          ),
        ],
      ),
    );
  }
}
