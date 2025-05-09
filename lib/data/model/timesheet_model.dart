class TimeSheet{

  final int id;
  final int idTask;
  final int idGoal;
  final String startTime;
  final String endTime;
  final String duration;
  final String date;
  final String createdAt;
  final String? updatedAt;


  TimeSheet({
    required this.id,
    required this.idTask,
    required this.idGoal,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.date,
    required this.createdAt,
    this.updatedAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_task': idTask,
      'id_goal': idGoal,
      'start_time': startTime,
      'end_time': endTime,
      'duration': duration,
      'date': date,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
  factory TimeSheet.fromMap(Map<String, dynamic> map) {
    return TimeSheet(
      id: map['id'],
      idTask: map['id_task'],
      idGoal: map['id_goal'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      duration: map['duration'],
      date: map['date'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
  @override
  String toString() {
    return 'TimeSheet(id: $id, idTask: $idTask, idGoal: $idGoal, startTime: $startTime, endTime: $endTime, duration: $duration, date: $date, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

}