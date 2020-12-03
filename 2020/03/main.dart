import 'dart:io';

void main() {
  final ex1 = '''..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#'''
      .split('\n');

  print(part1(ex1));
  print(part2(ex1));
  final file = File('input');
  final lines = file.readAsLinesSync();
  print(part1(lines));
  print(part2(lines));
}

int part1(List<String> input) {
  int count = 0;
  int row = 0;
  int column = 0;
  int width = input[0].length;
  while (row < input.length) {
    if (input[row][column] == '#') {
      count++;
    }
    row++;
    column = (column + 3) % width;
  }
  return count;
}

int part2(List<String> input) {
  final count = List.filled(5, 0);
  int row = 0;
  int column0 = 0;
  int column1 = 0;
  int column2 = 0;
  int column3 = 0;
  int column4 = 0;
  int width = input[0].length;
  while (row < input.length) {
    if (input[row][column0] == '#') {
      count[0]++;
    }
    if (input[row][column1] == '#') {
      count[1]++;
    }
    if (input[row][column2] == '#') {
      count[2]++;
    }
    if (input[row][column3] == '#') {
      count[3]++;
    }
    if (row %2  == 0) {
      if (input[row][column4] == '#') {
        count[4]++;
      }
      column4 = (column4 + 1) % width;
    }
    row++;
    column0 = (column0 + 1) % width;
    column1 = (column1 + 3) % width;
    column2 = (column2 + 5) % width;
    column3 = (column3 + 7) % width;
  }
  print(count);
  return count.reduce((value, element) => value * element);
}
