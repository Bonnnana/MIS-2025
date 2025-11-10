String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year;
  return '$day.$month.$year';
}

String formatTime(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

String formatRemaining(DateTime examDate) {
  final now = DateTime.now();
  final diff = examDate.difference(now);

  if (diff.isNegative) {
    return 'Испитот е поминат';
  }

  final days = diff.inDays;
  final hours = diff.inHours.remainder(24);

  return '$days дена, $hours часа';
}

