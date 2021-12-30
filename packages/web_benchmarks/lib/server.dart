// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io' as io;

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'src/benchmark_result.dart';
import 'src/runner.dart';

export 'src/benchmark_result.dart';

/// The default port number used by the local benchmark server.
const int defaultBenchmarkServerPort = 9999;

/// The default port number used for Chrome DevTool Protocol.
const int defaultChromeDebugPort = 10000;

/// Builds and serves a Flutter Web app, collects raw benchmark data and
/// summarizes the result as a [BenchmarkResult].
///
/// [benchmarkAppDirectory] is the directory containing the app that's being
/// benchmarked. The app is expected to use `package:web_benchmarks/client.dart`
/// and call the `runBenchmarks` function to run the benchmarks.
///
/// [entryPoint] is the path to the main app file that runs the benchmark. It
/// can be different (and typically is) from the production entry point of the
/// app.
///
/// If [useCanvasKit] is true, builds the app in CanvasKit mode.
///
/// [benchmarkServerPort] is the port this benchmark server serves the app on.
/// By default uses [defaultBenchmarkServerPort].
///
/// [chromeDebugPort] is the port Chrome uses for DevTool Protocol used to
/// extract tracing data. By default uses [defaultChromeDebugPort].
///
/// If [headless] is true, runs Chrome without UI. In particular, this is
/// useful in environments (e.g. CI) that doesn't have a display.
Future<BenchmarkResults> serveWebBenchmark({
  @required io.Directory benchmarkAppDirectory,
  @required String entryPoint,
  @required bool useCanvasKit,
  int benchmarkServerPort = defaultBenchmarkServerPort,
  int chromeDebugPort = defaultChromeDebugPort,
  bool headless = true,
}) async {
  // Reduce logging level. Otherwise, package:webkit_inspection_protocol is way too spammy.
  Logger.root.level = Level.INFO;

  return BenchmarkServer(
    benchmarkAppDirectory: benchmarkAppDirectory,
    entryPoint: entryPoint,
    useCanvasKit: useCanvasKit,
    benchmarkServerPort: benchmarkServerPort,
    chromeDebugPort: chromeDebugPort,
    headless: headless,
  ).run();
}
