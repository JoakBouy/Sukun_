import 'dart:math';
import 'package:english_words/english_words.dart';

List<String> generateAlphabeticalWords({int wordsPerLetter = 5}) {
  final random = Random();
  final wordList = all.toList(); // From english_words package
  List<String> result = [];

  for (var letter in 'abcdefghijklmnopqrstuvwxyz'.split('')) {
    // Filter words starting with current letter
    var filtered =
        wordList.where((word) => word.isNotEmpty && word[0] == letter).toList();

    // Shuffle and pick desired count
    filtered.shuffle(random);
    result += filtered.take(wordsPerLetter).toList();
  }

  return result;
}
