class CommonFunctions {
  static List<String> splitStringByComma(String input) {
    if (input.isEmpty) {
      return [];
    }
    return input.split(',').map((item) => item.trim()).toList();
  }
}
