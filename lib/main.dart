// Flutter code sample for AnimatedContainer

// The following example (depicted above) transitions an AnimatedContainer
// between two states. It adjusts the [height], [width], [color], and
// [alignment] properties when tapped.

import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'constants.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
      theme: ThemeData(fontFamily: 'Mousememoirs'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    const testData = [
      {
        "date": "2017/02/03",
        "isAlarm": true,
        "weather": " Icons.access_alarm",
        "title": "123",
        "writeBy": "writeBy",
        "content": "content"
      },
      {
        "date": "2017/02/03",
        "isAlarm": true,
        "weather": " Icons.access_alarm",
        "title": "123",
        "writeBy": "writeBy",
        "content": "content"
      },
      {
        "date": "2017/02/03",
        "isAlarm": true,
        "weather": " Icons.access_alarm",
        "title": "123",
        "writeBy": "writeBy",
        "content": "content"
      },
      {
        "date": "2017/02/03",
        "isAlarm": true,
        "weather": " Icons.access_alarm",
        "title": "123",
        "writeBy": "writeBy",
        "content": "content"
      }
    ];

    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: testData.length,
          itemBuilder: (BuildContext context, int index) {
            return MemoWidget(
                date: "2017/02/03",
                isAlarm: true,
                weather: " Icons.access_alarm",
                title: "123",
                writeBy: "writeBy",
                content: "content");
          }),
    );
  }
}

class MemoWidget extends StatefulWidget {
  String date;
  bool isAlarm;
  String weather;
  String title;
  String writeBy;
  String content;

  MemoWidget(
      {Key key,
      this.date,
      this.isAlarm,
      this.weather,
      this.title,
      this.writeBy,
      this.content})
      : super(key: key);
  @override
  _MemoWidgetState createState() => _MemoWidgetState();
}

class _MemoWidgetState extends State<MemoWidget> {
  bool inside = false;
  Uint8List imageInMemory;

  GlobalKey _globalKey = new GlobalKey();
  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      inside = true;
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      String bs64 = base64Encode(pngBytes);
//      print(pngBytes);
//      print(bs64);
      Image.memory(base64Decode(bs64));
      print('png done');
      setState(() {
        imageInMemory = pngBytes;
        inside = false;
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: RepaintBoundary(
      key: _globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: sizeHeight / 3,
              width: sizeWidth,
              decoration: BoxDecoration(color: Colors.yellow),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.date, style: TextStyle(fontSize: 20)),
                        Icon(Icons.alarm),
                        Icon(Icons.wb_sunny)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 2,
                      height: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: Text(
                            widget.title,
                            style: TextStyle(fontSize: 20),
                          )),
                          SizedBox(height: 10),
                          Container(
                              child: Text(widget.content,
                                  style: TextStyle(fontSize: 30))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(widget.writeBy,
                                  style: TextStyle(fontSize: 40)),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              _capturePng();
                            },
                            child: Container(
                              child: Text("EXPORT"),
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
