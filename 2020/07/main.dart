import 'dart:io';

void main() {
  final ex1 = '''light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.'''
      .split('\n');
  final file = File('input');
  final lines = file.readAsLinesSync();

  print(' ==== Part 1 ==== ');

  print(part1(ex1));
  print(part1(lines));

  print(' ==== Part 2 ==== ');

  final ex2 = '''shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.'''
      .split('\n');

  print(part2(ex2));
  print(part2(lines));
}

int part1(List<String> input) {
  int count = 0;
  Map<String, String> map = {};
  for (final line in input) {
    final split = line.split(' bags contain ');
    map[split[0]] = split[1];
  }

  // print(map);

  for (final pair in map.entries) {
    if (_bagCanCarry(pair.value, map)) {
      count++;
    }
  }

  return count;
}

bool _bagCanCarry(
  String bags,
  Map<String, String> map,
) {
  if (bags.contains('shiny gold')) {
    // print('$bags -> found $bagColor');
    return true;
  } else if (bags == 'no other bags.') {
    // print('$bags -> no bags');
    return false;
  } else {
    List<String> parsedBags = [];
    if (bags.contains(',')) {
      parsedBags = bags.split(',');
    } else {
      parsedBags.add(bags);
    }
    for (String bag in parsedBags) {
      bag = bag
          .replaceAll('bags', '')
          .replaceAll('bag', '')
          .replaceAll('.', '')
          .substring(2)
          .trim();
      // print(bag);
      if (_bagCanCarry(map[bag]!, map)) {
        return true;
      }
    }
  }

  // print('$bags -> nothing found');
  return false;
}

int part2(List<String> input) {
  Map<String, String> map = {};
  for (final line in input) {
    final split = line.split(' bags contain ');
    map[split[0]] = split[1];
  }
  int count = _countBags(map['shiny gold']!, map) - 1;
  return count;
}

int _countBags(
    String bags,
    Map<String, String> map,
    ) {
 if (bags == 'no other bags.') {
    return 1;
  } else {
    List<String> parsedBags = [];
    if (bags.contains(',')) {
      parsedBags = bags.split(',');
    } else {
      parsedBags.add(bags);
    }
    int total = 1;
    for (String bag in parsedBags) {
      bag = bag
          .replaceAll('bags', '')
          .replaceAll('bag', '')
          .replaceAll('.', '')
          .trim();
      int count = int.parse(bag.split(' ')[0]);
      bag = bag.substring(2);
      // print('$count x $bag');
      total += count * _countBags(map[bag]!, map);
    }
    // print('$bags -> $total');
    return total;
  }
}
