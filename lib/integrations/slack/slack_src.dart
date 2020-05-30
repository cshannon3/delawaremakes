import 'dart:convert';

import 'package:universal_html/html.dart';

String url;
class Slack {
  String url;
  Slack(final this.url);

  /// Posts a Slack message to the properly authenticated Slack token.
  /// The messages will go to whatever channel the token was set up for.
  send(Message m) {
    String payload = m.toString();
    HttpRequest.postFormData(url, {'payload': payload});
  }
}
/// A message passed between your app and slack.
class Message {
  /// For a simple message, your JSON payload must contain a [text] property. This is the text that will be posted to the channel.
  String text;

  /// By default, the message will be posted by the username "testing-bot" but you can override the name by setting [username]
  String username;

  /// This is the channel the message will be sent to. By default the channel will be #general. Channel name must start with #.
  /// Ignored if this is an "Incoming Webhook"
  String channel = '#general';

  /// By default, the message will show an icon that looks like the webhook's icon. You can change this by setting [icon_url] or [icon_emoji]
  String icon_url;

  /// By default, the message will show an icon that looks like the webhook's icon. You can change this by setting [icon_url] or [icon_emoji]
  String icon_emoji;

  /// Any number of [Attachment]s can be added to the message
  List<Attachment> attachments;

  /// Creates a [Message] object which can be sent to a Slack channel
  Message(this.text, {this.username, this.channel, this.icon_emoji,
      this.icon_url, this.attachments});

  /// Prints out the [Map] that this object represents
  String toString() {
    Map message = new Map();

    if (text != null) message['text'] = text;

    if (username != null) message['username'] = username;

    if (channel != null) message['channel'] = channel;

    if (icon_url != null) message['icon_url'] = icon_url;

    if (icon_emoji != null) message['icon_emoji'] = icon_emoji;

    if (attachments != null) {
      List attached_maps = [];
      for (Attachment a in attachments) attached_maps.add(a._toMap());

      message['attachments'] = attached_maps;
    }

    return jsonEncode(message);
  }
}

class Attachment {
  /// Required text summary of the attachment that is shown by clients that understand attachments but choose not to show them.
  String fallback;

  /// Optional text that should appear above the formatted data
  String pretext;

  /// Optional text that should appear within the attachment
  String text;

  /// Optional title for the attachment
  String title;

  /// Optional link for the attachment's title
  String title_link;

  /// Optional image to display
  String image_url;

  /// Optional thumbnail to display
  String thumb_url;

  /// Can either be one of 'good', 'warning', 'danger', or any hex color code
  String color; // 'good', 'warning', 'danger' or hex.

  /// Fields are displayed in a table on the message
  List<Field> fields;

  /// Creates an [Attachment] object which can be added to a [Message] object
  Attachment(this.fallback, {this.pretext, this.text, this.title, this.title_link, this.image_url, this.thumb_url, this.color, this.fields});

  /// Prints out the [Map] that this object represents
  String toString() => jsonEncode(_toMap());

  Map _toMap() {
    Map attachment = new Map()..['fallback'] = fallback;

    if (pretext != null) attachment['pretext'] = pretext;
    if (title != null) attachment['title'] = title;
    if (title_link != null) attachment['title_link'] = title_link;
    if (text != null) attachment['text'] = text;
    if (color != null) attachment['color'] = color;
    if (image_url != null) attachment['image_url'] = image_url;
    if (thumb_url != null) attachment['thumb_url'] = thumb_url;

    if (fields != null) {
      List attach_fields = [];
      for (Field a in fields) attach_fields.add(a._toMap());

      attachment['fields'] = attach_fields;
    }

    return attachment;
  }
}

class Field {
  /// Required Field Title. The title may not contain markup and will be escaped for you
  String title;

  /// The text value of the field. May contain standard message markup and must be escaped as normal. May be multi-line.
  String value;

  /// Optional flag indicating whether the `value` is short enough to be displayed side-by-side with other values
  bool short = false;

  /// Creates a [Field] object which can be added to an [Attachment] object
  Field(this.title, this.value, {this.short});

  /// Prints out the [Map] that this object represents
  String toString() => jsonEncode(_toMap());

  Map _toMap() {
    Map field = new Map()
      ..['title'] = title
      ..['value'] = value
      ..['short'] = short;
    return field;
  }
}