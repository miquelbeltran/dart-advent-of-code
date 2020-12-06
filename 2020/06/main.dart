import 'dart:io';

void main() {
  final ex1 = '''abc

a
b
c

ab
ac

a
a
a
a

b'''
      .split('\n');
  final file = File('input');
  final lines = file.readAsLinesSync();

  print(' ==== Part 1 ==== ');

  print(part1(ex1));
  print(part1(lines));

  print(' ==== Part 2 ==== ');

  print(part2(ex1));
  print(part2(lines));
}

int part1(List<String> input) {
  int count = 0;
  var groups = <List<String>>[];
  var group = <String>[];
  for (final line in input) {
    if (line.isEmpty) {
      groups.add(group);
      group = <String>[];
    } else {
      group.add(line);
    }
  }
  groups.add(group);

  // print(groups);

  for (group in groups) {
    final allAnswers = group.reduce((value, element) => value + element);
    count += allAnswers.codeUnits.toSet().length;
  }

  return count;
}

int part2(List<String> input) {
  int count = 0;

  var groups = <List<String>>[];
  var group = <String>[];
  for (final line in input) {
    if (line.isEmpty) {
      groups.add(group);
      group = <String>[];
    } else {
      group.add(line);
    }
  }
  groups.add(group);

  final z = "z".codeUnitAt(0);

  for (group in groups) {
    int c = "a".codeUnitAt(0);
    while (c <= z) {
      if (group.every((element) => element.codeUnits.contains(c))) {
        count++;
      }
      c++;
    }
  }


  return count;
}
