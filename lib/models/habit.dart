class DailyRoutine {
  int? id;
  String activity;
  String startTime;
  String endTime;
  bool completed;
  String date;
  
  DailyRoutine({
    this.id,
    required this.activity,
    required this.startTime,
    required this.endTime,
    this.completed = false,
    required this.date,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activity': activity,
      'start_time': startTime,
      'end_time': endTime,
      'completed': completed ? 1 : 0,
      'date': date,
    };
  }
  
  static DailyRoutine fromMap(Map<String, dynamic> map) {
    return DailyRoutine(
      id: map['id'],
      activity: map['activity'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      completed: map['completed'] == 1,
      date: map['date'],
    );
  }
}

class TradingSession {
  int? id;
  int sessionNumber;
  String startTime;
  String endTime;
  String pair;
  double lotSize;
  int pipsTarget;
  double profitLoss;
  String notes;
  String date;
  
  TradingSession({
    this.id,
    required this.sessionNumber,
    required this.startTime,
    required this.endTime,
    this.pair = 'XAUUSD',
    this.lotSize = 0.0,
    this.pipsTarget = 0,
    this.profitLoss = 0.0,
    this.notes = '',
    required this.date,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'session_number': sessionNumber,
      'start_time': startTime,
      'end_time': endTime,
      'pair': pair,
      'lot_size': lotSize,
      'pips_target': pipsTarget,
      'profit_loss': profitLoss,
      'notes': notes,
      'date': date,
    };
  }
  
  static TradingSession fromMap(Map<String, dynamic> map) {
    return TradingSession(
      id: map['id'],
      sessionNumber: map['session_number'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      pair: map['pair'],
      lotSize: map['lot_size'].toDouble(),
      pipsTarget: map['pips_target'],
      profitLoss: map['profit_loss'].toDouble(),
      notes: map['notes'],
      date: map['date'],
    );
  }
}
