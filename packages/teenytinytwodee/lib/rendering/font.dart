import 'package:teenytinytwodee/primitives/color.dart';

enum FontFamily { arial }

enum FontStyle { bold, italic, normal }

class Font {
  Font({
    required this.family,
    required this.size,
    required this.color,
  });
  final String family;
  final int size;
  final FontStyle style = FontStyle.normal;
  final Color color;
}
