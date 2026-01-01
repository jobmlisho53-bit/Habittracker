import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/database_service.dart';
import '../data/schedule.dart';
import '../widgets/habit_card.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<DailyRoutine> todayHabits = [];
  final DatabaseService _dbService = DatabaseService();
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _loadTodayHabits();
    _updateTime();
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now().toString().substring(11, 16);
    });
  }

  Future<void> _loadTodayHabits() async {
    String today = DateTime.now().toString().split(' ')[0];
    
    // Insert today's schedule if not exists
    List<DailyRoutine> schedule = getDailySchedule();
    await _dbService.insertTodaysSchedule(schedule);
    
    List<DailyRoutine> habits = await _dbService.getTodaysHabits(today);
    setState(() {
      todayHabits = habits;
    });
  }

  Future<void> _toggleHabit(DailyRoutine habit) async {
    await _dbService.updateHabit(habit);
    _loadTodayHabits(); // Refresh the list
  }

  int getCompletedCount() {
    return todayHabits.where((habit) => habit.completed).length;
  }

  @override
  Widget build(BuildContext context) {
    double progress = todayHabits.isEmpty ? 0 : getCompletedCount() / todayHabits.length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Disciplined Trader'),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadTodayHabits,
          ),
        ],
      ),
      body: Column(
        children: [
          // Current time and progress
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              children: [
                Text(
                  'Today: ${DateTime.now().toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Current Time: $_currentTime EAT',
                  style: TextStyle(fontSize: 14, color: Colors.blue[800]),
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                Text(
                  '${getCompletedCount()} / ${todayHabits.length} completed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          
          // Habit list
          Expanded(
            child: todayHabits.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: todayHabits.length,
                    itemBuilder: (context, index) {
                      return HabitCard(
                        habit: todayHabits[index],
                        onToggle: _toggleHabit,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
