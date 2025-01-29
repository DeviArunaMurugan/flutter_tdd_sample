class StringCalculator {
  static int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    // Default delimiters
    List<String> delimiters = [',', '\n'];
    String numString = numbers;

    // Check for custom delimiter
    if (numbers.startsWith('//')) {
      int delimiterEndIndex = numbers.indexOf('\n');
      String delimiterPart = numbers.substring(2, delimiterEndIndex);
      numString = numbers.substring(delimiterEndIndex + 1);

      // Handle multiple delimiters
      final delimiterPattern = RegExp(r'\[(.*?)\]');
      final matches = delimiterPattern.allMatches(delimiterPart);

      if (matches.isNotEmpty) {
        delimiters = matches.map((m) => m.group(1)!).toList();
      } else {
        delimiters = [delimiterPart];
      }
    }

    // Create a regex pattern to split by multiple delimiters
    String delimiterRegex = delimiters.map(RegExp.escape).join('|');
    List<String> numList = numString.split(RegExp(delimiterRegex));

    int sum = 0;
    List<int> negatives = [];

    for (var num in numList) {
      if (num.isEmpty) continue;
      int number = int.parse(num);
      if (number < 0) {
        negatives.add(number);
      } else if (number <= 1000) {
        sum += number;
      }
    }

    if (negatives.isNotEmpty) {
      throw Exception('Negatives not allowed: ${negatives.join(', ')}');
    }

    return sum;
  }
}
