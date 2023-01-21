import 'package:flutter/material.dart';
import 'package:sticker_view/widgets/drag_resize.dart';
import 'package:sticker_view/widgets/sticker.dart';

class StickerView extends StatefulWidget {
  const StickerView({
    Key? key,
    required this.stickers,
    this.width = double.infinity,
    this.height = double.infinity,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);
  final double height;
  final double width;
  final Color backgroundColor;
  final List<Sticker> stickers;

  @override
  State<StickerView> createState() => _StickerViewState();
}

class _StickerViewState extends State<StickerView> {
  UniqueKey? selectedSticker;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      child: widget.stickers.isEmpty
          ? null
          : LayoutBuilder(builder: (context, constraints) {
              return Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedSticker = null);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  for (Sticker sticker in widget.stickers)
                    DragResize(
                      hasFocus: selectedSticker == sticker.key,
                      constraints: constraints,
                      onTap: () =>
                          setState(() => selectedSticker = sticker.key),
                      onDelete: () =>
                          setState(() => widget.stickers.remove(sticker)),
                      onLayerUp: () {
                        int pos = widget.stickers.indexOf(sticker);
                        if (pos != widget.stickers.length - 1) {
                          widget.stickers.removeAt(pos);
                          widget.stickers.insert(pos + 1, sticker);
                          setState(() {});
                        }
                      },
                      onLayerDown: () {
                        int pos = widget.stickers.indexOf(sticker);
                        if (pos > 0) {
                          widget.stickers.removeAt(pos);
                          widget.stickers.insert(pos - 1, sticker);
                          setState(() {});
                        }
                      },
                      child: sticker,
                    )
                ],
              );
            }),
    );
  }
}
