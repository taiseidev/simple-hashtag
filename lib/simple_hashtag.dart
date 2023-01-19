library simple_hashtag;

import 'package:flutter/material.dart';

class SimpleHashTag {
  SimpleHashTag();

  /// Regular expressions for hashtags
  ///
  /// Regular expression corresponding to [#{Arbitrary string}　]
  /// A single-byte space must always be left after any string
  ///
  /// ```dart
  /// decToHex(16) == '10'
  /// ```
  final _tagRegExp = RegExp(r'#([^\s]+)\s');

  List<Widget> add(String message) {
    final tagMatches = _tagRegExp.allMatches(message);

    final messages = <String>[];
    final contents = <Widget>[];
    var textEnd = '';
    var count = 0;

    for (final tagMatch in tagMatches) {
      final tag = message.substring(tagMatch.start, tagMatch.end);

      List<String> text;

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

    // messagesにハッシュタグで分割した文字列が配列で格納されている
    // ハッシュタグをタップした時のcallbackを設定する

    for (final list in messages) {
      if (_tagRegExp.hasMatch(list)) {
        contents.add(
          InkWell(
            onTap: () async {
              // await Navigator.push<void>(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return TagPage(tag: list);
              //     },
              //   ),
              // );
            },
            child: Text(
              list,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        );
      } else {
        contents.add(
          Flexible(
            child: Text(
              list,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      }
    }

    return contents;
  }
}


/// 作るメソッド一覧
/// タグのみを抽出してくれる
/// Wrapで包んで返却
/// Wrapを包まないでTextとRichTextのリストで返却してくれる
