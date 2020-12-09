import 'dart:io';

abstract class Advent {
  List<String>? _lines;

  List<String> get lines {
    if (_lines == null) {
      final file = File('input');
      _lines = file.readAsLinesSync();
    }
    return _lines!;
  }

  String get sample1;

  String get sample2;

  int part1(List<String> lines);

  int part2(List<String> lines);

  void solve() {
    print(' ==== Sample 1 ==== ');
    try {
      print(part1(sample1.split('\n')));
    } catch (e) {
      print(e);
    }

    print(' ==== Part 1 ==== ');
    try {
      print(part1(lines));
    } catch (e) {
      print(e);
    }

    print(' ==== Sample 2 ==== ');
    try {
      print(part2(sample2.split('\n')));
    } catch (e) {
      print(e);
    }

    print(' ==== Part 2 ==== ');
    try {
      print(part2(lines));
    } catch (e) {
      print(e);
    }
  }
}
