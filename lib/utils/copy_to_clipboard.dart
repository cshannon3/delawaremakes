// copy_to_clipboard_web.dart
import 'package:universal_html/html.dart';

// https://github.com/flutter/flutter/issues/33470#issuecomment-537802636
bool copyToClipboard(String text) {
  final textarea = TextAreaElement();
  document.body.append(textarea);
  textarea.style.border = '0';
  textarea.style.margin = '0';
  textarea.style.padding = '0';
  textarea.style.opacity = '0';
  textarea.style.position = 'absolute';
  textarea.readOnly = true;
  textarea.value = text;
  textarea.select();
  final result = document.execCommand('copy');
  textarea.remove();
  return result;
}