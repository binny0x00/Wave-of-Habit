import 'package:flutter/material.dart';
import 'package:wave_of_habit/feature/home/home_controller.dart';
import 'package:wave_of_habit/feature/home/home_page.dart';

class TodayActionsInput extends StatefulWidget {
  const TodayActionsInput({super.key, required this.controller});

  final HomeController controller;

  @override
  State<TodayActionsInput> createState() => _TodayActionsInputState();
}

class _TodayActionsInputState extends State<TodayActionsInput> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: '예: 대중교통 이용',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    widget.controller.addExtraAct(_textController.text);
                    _textController.clear();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: extraActs.map(
              (act) => Chip(
                label: Text(act),
                onDeleted: () {
                  widget.controller.removeExtraAct(act);
                },
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}
