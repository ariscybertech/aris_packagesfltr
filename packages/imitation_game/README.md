# Imitation Game

## Description

`imitation_game` is a platform for performing automated tests to compare the
performance of different UI frameworks.  For example, how much memory does the
same app written in Flutter and UIKit take?

## Running all the tests

You need a mobile device plugged into your computer and setup for development.
The mobile device and the computer need to be on the same network, one that
allows communication between computers since that's how the mobile phone will
report its results to the computer.

```sh
dart imitation_game.dart
```

## Dependencies

In order to run the tests you will need the union of all the platforms being
tested.  As new tests are added please add to this list:

### iOS

- Flutter
- Xcode
- [ios_deploy](https://github.com/ios-control/ios-deploy) - used to launch apps
  on the attached iOS device.

## Example File Layout

```text
./
├─ imitation_game.dart
└─ imitation_tests/
   ├─ smiley/
   │  ├─ README.md
   │  ├─ flutter/
   │  │  ├─ run_ios.sh
   │  │  └─ <flutter project files>
   │  └─ uikit/
   │     ├─ run_ios.sh
   │     └─ <uikit project files>
   └─ memory/
      ├─ README.md
      ├─ flutter/
      │  ├─ run_ios.sh
      │  └─ <flutter project files>
      └─ uikit/
         ├─ run_ios.sh
         └─ <uikit project files>
```

Here there are 2 different tests with 2 different platform implementations.  The
tests are named `smiley` and `memory`, they are both implemented on the
platforms `flutter` and `uikit`.

### Adding a test

Tests should comprise of implementations on one or more platform.  The directory
for the test should be added to `./tests`.  Inside that directory there should
be a directory of implementations and a `README.md` file that explains the test.

### Adding an implementation to a test

An implementation has to follow these rules:

- It needs to perform the same operations as the other implementations and
  follow the description in the test's `README.md`.
- It needs to contain a `run_ios.sh` script that will build and launch the test
  on the connected device.
- It should contain a file named `ip.txt` which will be overwritten by
  `imitation_game.dart` with the ip address and port that should be used to
  report results to.
- It needs to report its results to the ip and port in the `ip.txt` via an HTTP
  POST of JSON data.

## Data format for results

```json
{
  "test": "name_of_test",
  "platform": "name_of_platform",
  "results": {
    "some_result_name": 1.23,
    "some_result_name2": 4.56,
  }
}
```

A single test run can report multiple numbers.

## Results
Date created: 2020-09-09 17:18:15.594586Z
Flutter 1.22.0-10.0.pre.95 • channel master • https:&#x2F;&#x2F;github.com&#x2F;flutter&#x2F;flutter.git
Framework • revision d2fa384c31 (21 hours ago) • 2020-09-08 13:15:06 -0700
Engine • revision d1d848e842
Tools • Dart 2.10.0 (build 2.10.0-98.0.dev)

- smiley
    - flutter
      - ios_startup_time: 0.691717
      - adb_memory_total: 43179.0
    - uikit
      - ios_startup_time: 0.2632870674133301
    - android
      - adb_memory_total: 97941.0

