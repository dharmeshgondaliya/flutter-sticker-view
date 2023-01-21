import 'package:flutter/material.dart';
import 'package:sticker_view/widgets/position.dart';
import 'package:sticker_view/widgets/sticker.dart';
import 'package:sticker_view/widgets/sticker_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticker View',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sticker View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller1 =
      TextEditingController(text: "text 1");
  final TextEditingController controller2 =
      TextEditingController(text: "text 2");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StickerView(
          width: 300,
          height: 300,
          backgroundColor: Colors.black12,
          stickers: [
            Sticker(
              key: UniqueKey(),
              initialPosition: Position(),
              child: Container(
                width: 75,
                height: 75,
                color: Colors.green,
                child: const FlutterLogo(),
              ),
            ),
            Sticker(
              key: UniqueKey(),
              width: 200,
              height: 100,
              initialPosition: Position(),
              child: TextField(
                controller: controller1,
                maxLines: null,
                focusNode: FocusNode(),
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: "Text Here",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            Sticker(
              key: UniqueKey(),
              initialPosition: Position(),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
                child: const FlutterLogo(),
              ),
            ),
            Sticker(
              key: UniqueKey(),
              width: 200,
              height: 100,
              initialPosition: Position(),
              child: TextField(
                controller: controller2,
                maxLines: null,
                focusNode: FocusNode(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: "Text Here",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
