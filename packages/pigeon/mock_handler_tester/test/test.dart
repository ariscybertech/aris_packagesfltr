// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Autogenerated from Pigeon (v0.3.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;
import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'message.dart';

class _TestHostApiCodec extends StandardMessageCodec {
  const _TestHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is SearchReply) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is SearchRequest) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return SearchReply.decode(readValue(buffer)!);

      case 129:
        return SearchRequest.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestHostApi {
  static const MessageCodec<Object?> codec = _TestHostApiCodec();

  void initialize();
  SearchReply search(SearchRequest request);
  static void setup(TestHostApi? api) {
    {
      const BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.Api.initialize', codec);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          // ignore message
          api.initialize();
          return <Object?, Object?>{};
        });
      }
    }
    {
      const BasicMessageChannel<Object?> channel =
          BasicMessageChannel<Object?>('dev.flutter.pigeon.Api.search', codec);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.Api.search was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final SearchRequest? arg_request = args[0] as SearchRequest?;
          assert(arg_request != null,
              'Argument for dev.flutter.pigeon.Api.search was null, expected non-null SearchRequest.');
          final SearchReply output = api.search(arg_request!);
          return <Object?, Object?>{'result': output};
        });
      }
    }
  }
}

class _TestNestedApiCodec extends StandardMessageCodec {
  const _TestNestedApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Nested) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is SearchReply) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return Nested.decode(readValue(buffer)!);

      case 129:
        return SearchReply.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestNestedApi {
  static const MessageCodec<Object?> codec = _TestNestedApiCodec();

  SearchReply search(Nested nested);
  static void setup(TestNestedApi? api) {
    {
      const BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.NestedApi.search', codec);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.NestedApi.search was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final Nested? arg_nested = args[0] as Nested?;
          assert(arg_nested != null,
              'Argument for dev.flutter.pigeon.NestedApi.search was null, expected non-null Nested.');
          final SearchReply output = api.search(arg_nested!);
          return <Object?, Object?>{'result': output};
        });
      }
    }
  }
}
