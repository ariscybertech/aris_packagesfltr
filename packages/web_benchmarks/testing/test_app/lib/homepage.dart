// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const ValueKey<String> textKey = ValueKey<String>('textKey');
const ValueKey<String> aboutPageKey = ValueKey<String>('aboutPageKey');

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            key: aboutPageKey,
            icon: const Icon(Icons.alternate_email),
            onPressed: () => Navigator.of(context).pushNamed('about'),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemExtent: 80,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                key: textKey,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('You have pushed the button this many times:'),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              );
            } else {
              return SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    elevation: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Line $index',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Expanded(child: Container()),
                        const Icon(Icons.camera),
                        const Icon(Icons.face),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
