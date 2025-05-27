// ignore_for_file: constant_identifier_names
enum PriorityCategory {
  URGENT('Urgent'),
  NORMAL('Normal'),
  LOW('Low');

  const PriorityCategory(this.value);
  final String value;
}

