import 'dart:html';

bool copyToClipboard(String text) {
  final textarea = TextAreaElement();
  document.body!.append(textarea);
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
