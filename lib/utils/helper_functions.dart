import 'package:flutter/cupertino.dart';

/// Format apps stats for base page grid
List<Map<String, dynamic>> formatStatInfo(List input) {
  var gramsPosted = input[0]['grams_posted'] as int;
  var booksSeeded = input[0]['books_seeded'] as int;
  var yourGrams = input[0]['your_grams'] as int;
  var wishlist = input[0]['wishlist'] as int;
  var booksCompleted = input[0]['books_completed'] as int;
  return [
    {
      "data": formatNumber(gramsPosted),
      "label": 'grams posted globally',
      "dataType": "text",
    },
    {
      "data": formatNumber(booksSeeded),
      "label": 'books seeded',
      "dataType": "text"
    },
    {
      "label": 'explore top books',
      "dataType": "icon",
      "icon": CupertinoIcons.book_fill,
    },
    {
      "data": formatNumber(yourGrams),
      "label": 'grams posted by you',
      "dataType": "text"
    },
    {
      "data":
          '${formatNumber(wishlist, fractionDigit: 0)}/${formatNumber(booksCompleted, fractionDigit: 0)}',
      "label": 'books in wishlist',
      "dataType": "text"
    },
    {
      "label": 'gram',
      "dataType": "icon",
      "icon": CupertinoIcons.pencil_circle_fill
    },
  ];
}

/// Helper function to format numbers
String formatNumber(int number, {fractionDigit = 1}) {
  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(fractionDigit)}M';
  }
  if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(fractionDigit)}K';
  }
  return number.toString();
}
