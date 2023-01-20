library simple_hashtag;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// SimpleHashTag is a package that generates hashtags from strings.
/// By passing a string, a string starting with the specified trigger is hashtagged and returned as RichText.

class SimpleHashTag {
  SimpleHashTag({
    this.startTrigger = '#',
    this.endTrigger = ' ',
    this.textColor = Colors.black38,
    this.hashTagColor = Colors.blue,
    this.textFontSize = 14,
    this.hashTagFontSize = 14,
  });

  /// Specify the string that starts the tag
  /// By default, [#] is set.
  final String? startTrigger;

  /// Specify the string that ends the tag
  /// By default, [ ](half-width space) is set.
  final String? endTrigger;

  /// Normal string color
  final Color? textColor;

  /// Color of string to be hashtagged
  final Color? hashTagColor;

  /// Normal string text size
  final double? textFontSize;

  /// Text size of string to be hashtagged
  final double? hashTagFontSize;

  late final _pattern = "$startTrigger([^\\s]+)$endTrigger";
  late final _tagRegExp = RegExp(_pattern);

  /// Methods that return a list ([string]) with tags separated from the rest of the string
  List<String> _splitHashTags({required String message}) {
    final tagMatches = _tagRegExp.allMatches(message);

    final messages = <String>[];

    var textEnd = '';
    var count = 0;

    for (final tagMatch in tagMatches) {
      final tag = message.substring(tagMatch.start, tagMatch.end);

      var text = [];

      if (count == 0) {
        text = message.split(tag);
      } else {
        text = textEnd.split(tag);
      }

      count++;

      if (text[0] != tag) {
        messages.add(text[0]);
      }

      messages.add(tag);
      textEnd = text.last;
    }

    if (textEnd != '') {
      messages.add(textEnd);
    }

    return messages;
  }

  RichText generateHashTag(String text, Function(String hashTag)? onTap) {
    final textSpans = <TextSpan>[];
    final contents = RichText(text: TextSpan(children: textSpans));

    final list = _splitHashTags(message: text);

    if (list.isEmpty) {
      textSpans.add(
        TextSpan(
          text: text,
          style: TextStyle(
            color: textColor,
            fontSize: textFontSize,
          ),
        ),
      );
      return contents;
    }

    for (final tag in list) {
      if (_tagRegExp.hasMatch(tag)) {
        textSpans.add(
          TextSpan(
            text: tag,
            style: TextStyle(
              color: hashTagColor,
              fontSize: hashTagFontSize,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) {
                  onTap(tag.trim());
                }
              },
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: tag,
            style: TextStyle(
              color: textColor,
              fontSize: textFontSize,
            ),
          ),
        );
      }
    }
    return contents;
  }
}
