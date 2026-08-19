extension DateExtensions on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year(s) ago';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month(s) ago';
    }
    if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} week(s) ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    }
    return 'Just now';
  }

  String formatDate({String pattern = 'MMM dd, yyyy'}) {
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    switch (pattern) {
      case 'MMM dd, yyyy':
        return '$monthAbbrev ${day.toString().padLeft(2, '0')}, $year';
      case 'dd/MM/yyyy':
        return '${day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}/$year';
      case 'yyyy-MM-dd':
        return '$year-${this.month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
      default:
        return '${months[this.month]} ${day.toString().padLeft(2, '0')}, $year';
    }
  }

  String get monthAbbrev {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month];
  }

  String formatTime({bool use24Hour = false}) {
    if (use24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    final h = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = hour >= 12 ? 'PM' : 'AM';
    return '$h:${minute.toString().padLeft(2, '0')} $period';
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
}
