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
      return input; // return original if parsing fails
    }
  }
}
