import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  final BoxPainter _painter;

  CustomTabIndicator(
      {required Color color, required double radius, required double height})
      : _painter = _CirclePainter(color, radius, height);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;
  final double height;

  _CirclePainter(Color color, this.radius, this.height)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    var rect = (offset + Offset(cfg.size!.width * 0, cfg.size!.height - 5)) &
        Size(cfg.size!.width, height);
    var rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rrect, _paint);
  }
}
