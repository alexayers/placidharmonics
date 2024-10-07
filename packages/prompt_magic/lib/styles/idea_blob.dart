import 'package:teenytinytwodee/primitives/color.dart';
import 'package:teenytinytwodee/rendering/font.dart';
import 'package:teenytinytwodee/rendering/renderer.dart';

class IdeaBlob {
  IdeaBlob({
    required this.name,
    required this.color,
    required this.children,
    required this.radius,
    required this.x,
    required this.y,
  });

  final String name;
  Color color;
  double x;
  double y;
  final double radius;
  final List<IdeaBlob> children;

  void render() {
    Renderer().circle(x: x, y: y, radius: radius, color: color);
    Renderer().print(
      msg: name,
      x: x - (radius / 2),
      y: y,
      font: Font(
        family: 'arial',
        size: 8,
        color: Color(
          red: 255,
          green: 255,
          blue: 255,
        ),
      ),
    );

    for (final child in children) {
      child.render();
    }
  }
}
