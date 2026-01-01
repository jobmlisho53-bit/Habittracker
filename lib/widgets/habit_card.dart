import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatelessWidget {
  final DailyRoutine habit;
  final Function(DailyRoutine) onToggle;
  
  const HabitCard({
    Key? key,
    required this.habit,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color cardColor = habit.completed ? Colors.green[50]! : Colors.red[50]!;
    Color textColor = habit.completed ? Colors.green[800]! : Colors.red[800]!;
    
    return Card(
      color: cardColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          habit.completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: textColor,
        ),
        title: Text(
          habit.activity,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: Text(
          '${habit.startTime} - ${habit.endTime}',
          style: TextStyle(color: textColor),
        ),
        trailing: Checkbox(
          value: habit.completed,
          onChanged: (value) {
            onToggle(habit.copyWith(completed: value!));
          },
        ),
      ),
    );
  }
}

extension DailyRoutineExtension on DailyRoutine {
  DailyRoutine copyWith({
    int? id,
    String? activity,
    String? startTime,
    String? endTime,
    bool? completed,
    String? date,
  }) {
    return DailyRoutine(
      id: id ?? this.id,
      activity: activity ?? this.activity,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      completed: completed ?? this.completed,
      date: date ?? this.date,
    );
  }
}
