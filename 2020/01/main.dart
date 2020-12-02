import 'dart:io';

void main() {
  final ex1 = '''1721
979
366
299
675
1456'''
      .split('\n');

  print(part1(ex1));
  print(part2(ex1));
  final file = File('input1');
  final lines = file.readAsLinesSync();
  print(part1(lines));
  print(part2(lines));
}

int part1(List<String> input) {
  final data = input.map((e) => int.parse(e)).toList();
  data.sort((a, b) => a - b);
  // print(data);
  int start = 0;
  int end = data.length - 1;

  while (true) {
    var data2 = data[start];
    var data3 = data[end];
    var total = data2 + data3;
    if (total == 2020) {
      return data2 * data3;
    }
    if (total > 2020) {
      end--;
    }
    if (total < 2020) {
      start++;
    }
  }
}

int part2(List<String> input) {
  final data = input.map((e) => int.parse(e)).toList();
  data.sort((a, b) => a - b);
  // print(data);
  int start = 0;
  int mid = 1;
  int end = data.length - 1;

  while (true) {
    var data2 = data[start];
    var data3 = data[end];
    var data4 = data[mid];
    var total = data2 + data3 + data4;
    if (total == 2020) {
      return data2 * data3 * data4;
    }
    if (total > 2020) {
      end--;
    }
    if (total < 2020) {
      mid++;
      if (mid >= end) {
        start++;
        mid = start + 1;
      }
    }
  }
}
