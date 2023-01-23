## Features

SimpleHashTag is a package that generates hashtags from strings.<br>
By passing a string, a string starting with the specified trigger is hashtagged and returned as RichText.

## Usage

You can use SimpleHashTag class to config text:

```dart
// Configure settings here
final _hashTag = SimpleHashTag();
```

For example.
```dart
// Configure settings here
final _hashTag = SimpleHashTag(textColor: Colors.red, hashTagColor: Colors.yellow);
```

The color of strings set as hashtags by the above settings will be yellow, and other strings will be red.
Currently available properties are as follows

|  name  |  description  |
| ---- | ---- |
|  startTrigger  |    Specify the string that starts the tag. By default, [#] is set.  |s
|  endTrigger  |    Specify the string that ends the tag. By default, [ ](half-width space) is set.  |
|  textColor  |   Normal text color  |
|  hashTagColor  |  Color of text to be hashtagged  |
|  textFontSize  |  Normal text size  |
|  hashTagFontSize  |  Text size to be hashtagged  |

<br>

Set the text to be hashtagged as the first argument of the generateHashTag method and the callback when the hashtag is tapped as the second argument. RichText is returned as the return value, so it can be used as a widget as it is.

<br>

```dart
text = _hashTag.generateHashTag(
    controller.text,
        (hashTag) {
        // move to Specific tag page
         Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(tag: hashTag),
            ),
        );
    },
);
```
