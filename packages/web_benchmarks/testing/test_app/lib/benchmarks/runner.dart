// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_benchmarks/client.dart';

import '../aboutpage.dart' show backKey;
import '../homepage.dart' show textKey, aboutPageKey;
import '../main.dart';

/// A recorder that measures frame building durations.
abstract class AppRecorder extends WidgetRecorder {
  AppRecorder({@required this.benchmarkName}) : super(name: benchmarkName);

  final String benchmarkName;

  Future<void> automate();

  @override
  Widget createWidget() {
    Future<void>.delayed(const Duration(milliseconds: 400), automate);
    return const MyApp();
  }

  Future<void> animationStops() async {
    while (WidgetsBinding.instance.hasScheduledFrame) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
  }
}

class ScrollRecorder extends AppRecorder {
  ScrollRecorder() : super(benchmarkName: 'scroll');

  @override
  Future<void> automate() async {
    final ScrollableState scrollable =
        Scrollable.of(find.byKey(textKey).evaluate().single);
    await scrollable.position.animateTo(
      30000,
      curve: Curves.linear,
      duration: const Duration(seconds: 20),
    );
  }
}

class PageRecorder extends AppRecorder {
  PageRecorder() : super(benchmarkName: 'page');

  bool _completed = false;

  @override
  bool shouldContinue() => profile.shouldContinue() || !_completed;

  @override
  Future<void> automate() async {
    final LiveWidgetController controller =
        LiveWidgetController(WidgetsBinding.instance);
    for (int i = 0; i < 10; ++i) {
      print('Testing round $i...');
      await controller.tap(find.byKey(aboutPageKey));
      await animationStops();
      await controller.tap(find.byKey(backKey));
      await animationStops();
    }
    _completed = true;
  }
}

class TapRecorder extends AppRecorder {
  TapRecorder() : super(benchmarkName: 'tap');

  bool _completed = false;

  @override
  bool shouldContinue() => profile.shouldContinue() || !_completed;

  @override
  Future<void> automate() async {
    final LiveWidgetController controller =
        LiveWidgetController(WidgetsBinding.instance);
    for (int i = 0; i < 10; ++i) {
      print('Testing round $i...');
      await controller.tap(find.byIcon(Icons.add));
      await animationStops();
    }
    _completed = true;
  }
}

Future<void> main() async {
  await runBenchmarks(<String, RecorderFactory>{
    'scroll': () => ScrollRecorder(),
    'page': () => PageRecorder(),
    'tap': () => TapRecorder(),
  });
}
