import 'package:flutter/material.dart';
import 'package:sticker_view/widgets/position.dart';

class Sticker extends StatefulWidget {
  const Sticker({
    required this.key,
    required this.child,
    required this.initialPosition,
    this.width = 100,
    this.height = 100,
  }) : super(key: key);
  final UniqueKey key;
  final Widget child;
  final double width;
  final double height;
  final Position initialPosition;

  @override
  State<Sticker> createState() => _StickerState();
}

class _StickerState extends State<Sticker> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
