import 'dart:io';

import 'dart:math';

void main() {
  final file = File('input');
  final lines = file.readAsLinesSync();

  print(' ==== Part 1 ==== ');

  print(id('BFFFBBFRRR'));
  print(id('FFFBBBFRRR'));
  print(id('BBFFBBFRLL'));
  print(part1(lines));

  print(' ==== Part 2 ==== ');

  // print(part2(exValid));
  print(part2(lines));
}

int id(String pass) {
  int row = 0;
  int column = 0;
  for(var i = 0; i < pass.length; i++) {
    final char = pass[i];
    if (char == 'B') {
      row = row << 1;
      row++;
    }
    if (char == 'F') {
      row = row << 1;
    }
    if (char == 'R') {
      column = column << 1;
      column++;
    }
    if (char == 'L') {
      column = column << 1;
    }
  }

  // print('Row: $row + Column: $column');

  return row * 8 + column;
}

int part1(List<String> input) {
  int top = 0;
  for (final line in input) {
    top = max(top, id(line));
  }
  return top;
}


int part2(List<String> input) {
  final ids = input.map((e) => id(e)).toList();
  ids.sort((a, b) => a - b);
  int min = ids.first;
  int max = ids.last;
  int prev = min - 1;
  for (int id in ids) {
    if (id != prev + 1) {
      return prev + 1;
    }
    prev = id;
  }
  print('min: $min, max: $max');
  return 0;
}
