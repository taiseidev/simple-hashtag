library simple_hashtag;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SimpleHashTag {
  SimpleHashTag({
    /// Default HashTag [#]
    this.startTrigger = '#',
    this.endTrigger = ' ',
    this.textColor = Colors.black38,
    this.hashTagColor = Colors.blue,
    this.textFontSize = 14,
    this.hashTagFontSize = 14,
  });

  final String? startTrigger;
  final String? endTrigger;

  final Color? textColor;
  final Color? hashTagColor;

  final double? textFontSize;
  final double? hashTagFontSize;

  /// Regular expressions for hashtags
  ///
  /// Regular expression corresponding to [#{Arbitrary string} ]
  /// A single-byte space must always be left after any string
  ///
  /// ```dart
  /// decToHex(16) == '10'
  /// ```
  /// startTriggerとendTriggerを作成する

  late final _pattern = "$startTrigger([^\\s]+)\\s";
  late final _tagRegExp = RegExp(_pattern);

  List<String> _splitHashTags(String message) {
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

  RichText createContents(String message, Function(String tag)? onTapHashTag) {
    final contents = <TextSpan>[];
    final texts = RichText(text: TextSpan(children: contents));
    final messages = _splitHashTags(message);

    for (final list in messages) {
      if (_tagRegExp.hasMatch(list)) {
        contents.add(
          TextSpan(
            text: list,
            style: TextStyle(
              color: hashTagColor,
              fontSize: hashTagFontSize,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (onTapHashTag != null) {
                  onTapHashTag(list);
                }
              },
          ),
        );
      } else {
        contents.add(
          TextSpan(
            text: list,
            style: TextStyle(
              color: textColor,
              fontSize: textFontSize,
            ),
          ),
        );
      }
    }
    return texts;
  }
}
