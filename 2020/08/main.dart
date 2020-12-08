import 'dart:io';

void main() {
  final ex1 = '''nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6'''
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
  int index = 0;
  int acc = 0;
  List<int> visited = [];

  while(true) {
    if (visited.contains(index)) {
      break;
    } else {
      visited.add(index);
    }
    // print('$index - $acc');
    final inst = input[index].split(' ');
    switch (inst[0]) {
      case 'nop':
        index++;
        break;
      case 'acc':
        acc += int.parse(inst[1]);
        index++;
        break;
      case 'jmp':
        index += int.parse(inst[1]);
        break;
    }
  }

  return acc;
}

int part2(List<String> input) {
  List<int> jumps = [];

  for(int i = 0; i < input.length; i++) {
    final inst = input[i].split(' ');
    if (inst[0] == 'jmp') {
      jumps.add(i);
    }
  }

  print(jumps);

  for(final jumpIndex in jumps) {
    bool loop = false;
    int index = 0;
    int acc = 0;
    List<int> visited = [];
    while(index < input.length) {
      if (visited.contains(index)) {
        loop = true;
        break;
      } else {
        visited.add(index);
      }
      // print('$index - $acc');
      final inst = input[index].split(' ');
      final value = int.parse(inst[1]);
      switch (inst[0]) {
        case 'nop':
          index++;
          break;
        case 'acc':
          acc += value;
          index++;
          break;
        case 'jmp':
          if (index != jumpIndex) {
            index += value;
          } else {
            // print('jump index $jumpIndex');
            index++;
          }
          break;
      }
    }

    if (!loop) {
      return acc;
    }
  }

  return 0;
}

