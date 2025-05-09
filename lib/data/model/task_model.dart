class Task{
  int? id;
  String? title;
  String? description;
  String? color;
  String? startDate;
  String? startTime;
  int? status;
  String? priority;
  String? reminder;
  String? expectedTime;
  String? actualTime;
  String? createdAt;
  int? idGoals;
  // create a constructor with named parameters
  Task({
    this.id,
    this.title,
    this.description,
    this.color,
    this.startDate,
    this.startTime,
    this.status,
    this.priority,
    this.reminder,
    this.expectedTime,
    this.actualTime,
    this.createdAt,
    this.idGoals,
  });
  // create a method to convert the task model to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'start_date': startDate,
      'start_time': startTime,
      'status': status,
      'priority': priority,
      'reminder': reminder,
      'expected_time': expectedTime,
      'actual_time': actualTime,
      'created_at': createdAt,
      'IDGOALS': idGoals,
    };
  }
  // create a method to convert the map to a task model
  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    color = map['color'];
    startDate = map['start_date'];
    startTime = map['start_time'];
    status = map['status'];
    priority = map['priority'];
    reminder = map['reminder'];
    expectedTime = map['expected_time'];
    actualTime = map['actual_time'];
    createdAt = map['created_at'];
    idGoals = map['IDGOALS'];
  }
  // create a method to convert the task model to a string
  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, color: $color, startDate: $startDate, startTime: $startTime, status: $status, priority: $priority, reminder: $reminder, expectedTime: $expectedTime, actualTime: $actualTime, createdAt: $createdAt, idGoals: $idGoals}';
  }
}