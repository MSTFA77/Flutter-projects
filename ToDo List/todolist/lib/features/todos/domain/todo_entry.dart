class TodoEntry {
  const TodoEntry({
    required this.label,
    this.isCompleted = false,
    required this.createdAt,
  });

  final String label;
  final bool isCompleted;
  final DateTime createdAt;

  TodoEntry copyWith({bool? isCompleted}) {
    return TodoEntry(
      label: label,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
    );
  }
}
