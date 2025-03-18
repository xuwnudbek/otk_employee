extension NumExtension on num {
  String get toCurrency {
    // 1000.0 -> 1,000.0
    if (toString().contains(".")) {
      final split = toStringAsFixed(2).split(".");
      final first = split[0];
      return first.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},',
      );
    }

    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    );
  }
}
