extension StringExtensions on String {
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  String get capitalizeFirst {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  double? toDoubleOrNull() {
    return double.tryParse(this);
  }

  int? toIntOrNull() {
    return int.tryParse(this);
  }

  String maskEmail() {
    if (!contains('@')) return this;
    final parts = split('@');
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) return '$name***@$domain';
    return '${name[0]}${'*' * (name.length - 2)}${name[name.length - 1]}@$domain';
  }

  String maskPhone() {
    if (length < 4) return this;
    return '${'*' * (length - 4)}${substring(length - 4)}';
  }
}
