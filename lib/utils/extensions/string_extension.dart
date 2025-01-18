extension StringX on String? {
  /// Converts any [String] to TitleCase
  ///
  /// ```dart
  /// "amit kumar".titleCase  // returns "Amit Kumar"
  /// ```
  String get titleCase {
    return _capitalize(this) ?? '';
  }

  /// Capitalize each word inside string
  /// Example: your name => Your Name
  String? _capitalize(String? value) {
    if (isNull(value)) return null;
    if (_isBlank(value)) return value;
    return value!.split(' ').map(capitalizeFirst).join(' ');
  }

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  String? capitalizeFirst(String? s) {
    if (isNull(s)) return null;
    if (_isBlank(s)) return s;
    return s![0].toUpperCase() + s.substring(1).toLowerCase();
  }

  /// Checks if data is null.
  bool isNull(dynamic value) {
    if (value == null) {
      return true;
    } else if (value is String && value == 'null') {
      return true;
    }
    return false;
  }

  /// Checks if data is null or blank (empty or only contains whitespace).
  bool _isBlank(dynamic value) {
    return _isEmpty(value);
  }

  /// Returns whether a dynamic value PROBABLY
  /// has the isEmpty getter/method by checking
  /// standard dart types that contains it.
  ///
  /// This is here to for the 'DRY'
  bool _isEmpty(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty as bool;
    }
    return false;
  }
}
