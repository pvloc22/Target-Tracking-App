class Goal{

  int? id;
  String? title;
  String? description;
  String? icon;
  String? color;
  String? status;
  String? reminder;
  String? expectedDate;
  String? expectedTime;
  String? actualTime;
  String? createdAt;

  Goal({
    this.id,
    this.title,
    this.description,
    this.icon,
    this.color,
    this.status,
    this.reminder,
    this.expectedDate,
    this.expectedTime,
    this.actualTime,
    this.createdAt,
  });
// FromMap a json object to a goal model
  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      icon: map['icon'],
      color: map['color'],
      status: map['status'],
      reminder: map['reminder'],
      expectedDate: map['expected_date'],
      expectedTime: map['expected_time'],
      actualTime: map['actual_time'],
      createdAt: map['created_at'],
    );
  }
// ToMap a goal model to a json object  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'color': color,
      'status': status,
      'reminder': reminder,
      'expected_date': expectedDate,
      'expected_time': expectedTime,
      'actual_time': actualTime,
      'created_at': createdAt,
    };
  }
  @override
  String toString() {
    return 'Goal{id: $id, title: $title, description: $description, icon: $icon, color: $color, status: $status, reminder: $reminder, expectedDate: $expectedDate, expectedTime: $expectedTime, actualTime: $actualTime, createdAt: $createdAt}';
  }
}