extension Initials on String {
  String getInitials() {
    if (!isNotEmpty) {
      return '';
    }
    return trim().split(' ').map((l) => l[0]).take(2).join();
  }

  List<String>? decompileNdi() {
    if (!contains('|')) {
      return null;
    }

    if (!('|'.allMatches(this).length > 3)) {
      return null;
    }

    return split('|');
  }

  String humanIt() {
    double n = double.parse(this);

    if (n < 1000) {
      return n.toStringAsFixed(2);
    }

    if (n < 10000) {
      final s = (n / 1000).toStringAsFixed(1);
      if (s[s.length - 1] == '0') {
        return '${s.substring(0, s.length - 2)}K';
      }
      return '${s}K';
    }

    if (n < 1000000) {
      return '${(n / 1000).toStringAsFixed(0)}M';
    }

    return '';
  }
}
