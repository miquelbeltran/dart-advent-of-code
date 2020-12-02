import 'dart:io';

void main() {
  final ex1 = '''1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc'''
      .split('\n');

  print(part1(ex1));
  print(part2(ex1));
  final file = File('input');
  final lines = file.readAsLinesSync();
  print(part1(lines));
  print(part2(lines));
}

int part1(List<String> input) {
  int valid = 0;
  for (final line in input) {
    final parts = line.split(' ');
    final min = int.parse(parts[0].split('-')[0]);
    final max = int.parse(parts[0].split('-')[1]);
    final letter = parts[1].codeUnits[0];
    // print(letter);
    final password = parts[2];
    // print(password.codeUnits);
    var where = password.codeUnits.where((element) => element == letter);
    // print(where);
    final count = where.length;
    // print(count);
    if (count >= min && count <= max) {
      valid++;
    }
  }

  return valid;
}

int part2(List<String> input) {
  int valid = 0;
  for (final line in input) {
    final parts = line.split(' ');
    final min = int.parse(parts[0].split('-')[0]);
    final max = int.parse(parts[0].split('-')[1]);
    final letter = parts[1].codeUnits[0];
    // print(letter);
    final password = parts[2];
    // print(password.codeUnits);
    var codeUnits = password.codeUnits;
    if ((codeUnits[min - 1] == letter) ^ (codeUnits[max - 1] == letter)) {
      valid++;
    }
  }
  return valid;
}
