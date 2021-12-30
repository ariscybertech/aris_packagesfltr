// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

class Response {
  int? result;
}

@HostApi()
abstract class BridgeApi1 {
  @async
  Response call();
}

@HostApi()
abstract class BridgeApi2 {
  @async
  Response call();
}
