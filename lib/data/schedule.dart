import '../models/habit.dart';

List<DailyRoutine> getDailySchedule() {
  String today = DateTime.now().toString().split(' ')[0];
  
  return [
    DailyRoutine(
      activity: 'Prayer',
      startTime: '04:00',
      endTime: '04:30',
      date: today,
      completed: false,
    ),
    DailyRoutine(
      activity: 'Exercise',
      startTime: '04:30',
      endTime: '05:30',
      date: today,
      completed: false,
    ),
    DailyRoutine(
      activity: 'Book Reading',
      startTime: '05:30',
      endTime: '06:00',
      date: today,
      completed: false,
    ),
    DailyRoutine(
      activity: 'Bath & Clothes',
      startTime: '06:00',
      endTime: '06:30',
      date: today,
      completed: false,
    ),
    DailyRoutine(
      activity: 'Breakfast',
      startTime: '06:30',
      endTime: '07:00',
      date: today,
      completed: false,
    ),
    DailyRoutine(
      activity: 'Classes',
      startTime: '07:00',
      endTime: '17:00',
      date: today,
      completed: false,
    ),
    DailyRoutine(
      activity: 'Trading Session 1',
      startTime: '17:00',
      endTime: '17:45',
      date: today,
      completed: false,
    ),
    DailyRoutine(
      activity: 'Trading Session 2',
      startTime: '17:45',
      endTime: '18:30',
      date: today,
      completed: false,
    ),
    DailyRoutine(
      activity: 'Trading Session 3',
      startTime: '18:30',
      endTime: '20:00',
      date: today,
      completed: false,
    ),
  ];
}
