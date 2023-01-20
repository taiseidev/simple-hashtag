library simple_hashtag;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SimpleHashTag {
  SimpleHashTag({
    this.textColor = Colors.black38,
    this.hashTagColor = Colors.blue,
  });

  final Color? textColor;
  final Color? hashTagColor;

  /// Regular expressions for hashtags
  ///
  /// Regular expression corresponding to [#{Arbitrary string} ]
  /// A single-byte space must always be left after any string
  ///
  /// ```dart
  /// decToHex(16) == '10'
  /// ```
  final _tagRegExp = RegExp(r'#([^\s]+)\s');

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

  RichText add(String message, Function(String tag) onTapHashTag) {
    final contents = <TextSpan>[];
    final texts = RichText(text: TextSpan(children: contents));
    final messages = _splitHashTags(message);

    for (final list in messages) {
      if (_tagRegExp.hasMatch(list)) {
        contents.add(
          TextSpan(
            text: list,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTapHashTag(list);
              },
          ),
        );
      } else {
        contents.add(TextSpan(text: list, style: TextStyle(color: textColor)));
      }
    }
    return texts;
  }
}
