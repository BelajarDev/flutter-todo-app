// todo_model.dart
class Todo {
  String title;
  bool isDone;
  DateTime? createdAt;
  DateTime? completedAt;

  Todo({
    required this.title,
    this.isDone = false,
    this.createdAt,
    this.completedAt,
  }) {
    createdAt ??= DateTime.now();
  }

  // Method untuk mengubah status todo
  void toggleDone() {
    isDone = !isDone;
    if (isDone) {
      completedAt = DateTime.now();
    } else {
      completedAt = null;
    }
  }

  // Method untuk format data (opsional, untuk penyimpanan)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'createdAt': createdAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  // Factory method untuk membuat Todo dari Map (opsional)
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      isDone: map['isDone'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'])
          : null,
    );
  }

  // Method untuk menyalin Todo dengan perubahan tertentu
  Todo copyWith({
    String? title,
    bool? isDone,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Todo(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
