class CommonFunctions {
  static List<String> splitStringByComma(String input) {
    if (input.isEmpty) {
      return [];
    }
    return input.split(',').map((item) => item.trim()).toList();
  }

  static String formatDateToYMD(String input) {
    if (input.isEmpty) return '';
    try {
      DateTime date = DateTime.parse(input);
      return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return input;
    }
  }

  static List<String> getYearListWithPursuing() {
    List<String> years = ['Pursuing'];
    int currentYear = DateTime.now().year;
    for (int year = 1980; year <= currentYear; year++) {
      years.add(year.toString());
    }
    return years;
  }

  String formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr).toLocal();
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final year = dateTime.year.toString();
      int hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final amPm = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12 == 0 ? 12 : hour % 12;
      final hourStr = hour.toString().padLeft(2, '0');
      return '$day-$month-$year $hourStr:$minute $amPm';
    } catch (e) {
      return dateTimeStr;
    }
  }
}
