import 'package:flutter/material.dart';
import 'package:sticker_view/widgets/position.dart';
import 'dart:math' as math;

import 'package:sticker_view/widgets/sticker.dart';

class DragResize extends StatefulWidget {
  const DragResize({
    Key? key,
    required this.child,
    required this.hasFocus,
    required this.constraints,
    required this.onTap,
    required this.onDelete,
    required this.onLayerUp,
    required this.onLayerDown,
  }) : super(key: key);
  final Sticker child;
  final bool hasFocus;
  final BoxConstraints constraints;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onLayerUp;
  final VoidCallback onLayerDown;

  @override
  State<DragResize> createState() => _DragResizeState();
}

class _DragResizeState extends State<DragResize> {
  late Position position;
  bool isTextfield = false;

  @override
  void initState() {
    double leftRight = (widget.constraints.maxWidth - widget.child.width) / 2;
    double topBottom = (widget.constraints.maxHeight - widget.child.height) / 2;
    position = Position(
      left: leftRight,
      right: leftRight,
      top: topBottom,
      bottom: topBottom,
      centerHorizontal: 0,
      centerVertical: 0,
    );
    if (widget.child.child is TextField) {
      isTextfield = true;
      TextField textField = widget.child.child as TextField;
      textField.controller!.addListener(() {
        if (textField.focusNode!.hasFocus && !widget.hasFocus) {
          widget.onTap.call();
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.top,
      bottom: position.bottom,
      left: position.left,
      right: position.right,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(position.rotate),
        child: Container(
          alignment: Alignment.center,
          transform: Matrix4.translationValues(
            position.centerHorizontal,
            position.centerVertical,
            0,
          ),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () => widget.onTap.call(),
                onPanUpdate: (details) {
                  position.centerHorizontal += details.delta.dx;
                  position.centerVertical += details.delta.dy;
                  setState(() {});
                },
                child: CustomPaint(
                  painter: widget.hasFocus
                      ? DashRectPainter(
                          color: Colors.green,
                          gap: 5,
                          strokeWidth: 1,
                        )
                      : null,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: widget.child,
                  ),
                ),
              ),
              if (widget.hasFocus) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        position.left = details.localPosition.dx;
                        setState(() {});
                      },
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: Icon(
                          Icons.switch_left_outlined,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        position.right = -details.localPosition.dx;
                        setState(() {});
                      },
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: Icon(
                          Icons.switch_right_outlined,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        position.top = details.localPosition.dy;
                        setState(() {});
                      },
                      child: Transform.rotate(
                        angle: -1.57,
                        child: const SizedBox(
                          width: 18,
                          height: 18,
                          child: Icon(
                            Icons.switch_right_outlined,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        position.bottom = -details.localPosition.dy;
                        setState(() {});
                      },
                      child: Transform.rotate(
                        angle: 1.57,
                        child: const SizedBox(
                          width: 18,
                          height: 18,
                          child: Icon(
                            Icons.switch_right_outlined,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        position.rotate = details.delta.direction;
                        setState(() {});
                      },
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: Icon(
                          Icons.rotate_right_outlined,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onTap: () => widget.onDelete.call(),
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: Icon(
                          Icons.delete_forever_rounded,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onTap: () => widget.onLayerUp.call(),
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: Icon(
                          Icons.layers_sharp,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Material(
                    color: Colors.white,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(),
                    child: GestureDetector(
                      onTap: () => widget.onLayerDown.call(),
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: Icon(
                          Icons.layers_outlined,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;
    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(double.parse(currentPoint.x.toString()),
              double.parse(currentPoint.y.toString()))
          : path.moveTo(double.parse(currentPoint.x.toString()),
              double.parse(currentPoint.y.toString()));
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
