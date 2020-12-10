import '../../base/base.dart';

void main() {
  Solution().solve();
}

class Solution extends Advent {

  List<int> parse(List<String> lines) {
    return lines.map((e) => int.parse(e)).toList();
  }

  @override
  int part1(List<String> lines) {
    final adapters = parse(lines);
    adapters.sort((a, b) => a - b);

    print(adapters);

    int prev = 0;
    int total1 = 0;
    int total3 = 1;
    for(final adapter in adapters) {
      var diff = adapter - prev;
      if (diff == 1) {
        total1++;
      } else if (diff <= 3) {
        total3++;
      }
      prev = adapter;
    }

    print(total1);
    print(total3);

    return total1 * total3;
  }

  @override
  int part2(List<String> lines) {
    final adapters = parse(lines);
    adapters.sort((a, b) => a - b);
    // adapters.insert(0, 0);
    // adapters.add(adapters.last + 3);

    Map<int, int> mem = {};
    return recursive(adapters, 0, mem);
  }

  int recursive(List<int> adapters, int current, Map<int, int> mem) {
    if (mem.containsKey(current)) {
      return mem[current]!;
    }
    if (adapters.isEmpty) {
      return 1;
    }
    final next1 = adapters.indexOf(current + 1);
    final next2 = adapters.indexOf(current + 2);
    final next3 = adapters.indexOf(current + 3);
    int count = 0;
    if (next1 >= 0) {
      count += recursive(adapters.sublist(next1 + 1), adapters[next1], mem);
    }
    if (next2 >= 0) {
      count += recursive(adapters.sublist(next2 + 1), adapters[next2], mem);
    }
    if (next3 >= 0) {
      count += recursive(adapters.sublist(next3 + 1), adapters[next3], mem);
    }
    mem[current] = count;
    return count;
  }

  @override
  String get sample1 => '''28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3''';

  @override
  String get sample2 => sample1;

}
