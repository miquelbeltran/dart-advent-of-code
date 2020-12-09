import '../../base/base.dart';

void main() {
  Solution().solve();
}

class Solution extends Advent {
  @override
  int part1(List<String> lines) {
    final preable = 25;
    final numbers = lines.map((e) => int.parse(e)).toList();

    int index = 0;
    while (true) {
      final previous = numbers.getRange(index, index + preable).toList();
      previous.sort((a, b) => a - b);
      final validate = numbers[index + preable];
      // print('$previous - $validate');

      int sumA = 0;
      int sumB = 1;
      while (true) {
        final sum = previous[sumA] + previous[sumB];
        // print('sum: $sum');
        if (sum == validate) {
          // print('found $sumA & $sumB');
          break;
        }
        if (sum > validate) {
          // print('too big: $sumA & $sumB');
          sumA++;
          sumB = sumA + 1;
        }
        if (sum < validate) {
          if (sumB < previous.length - 1) {
            sumB++;
          } else {
            sumA++;
            sumB = sumA + 1;
          }
        }
        if (sumA == previous.length - 1) {
          return validate;
        }
      }

      index++;
    }

    return 0;
  }

  @override
  int part2(List<String> lines) {
    final target = 22406676;
    // final target = 127;
    final numbers = lines.map((e) => int.parse(e)).toList();

    int start = 0;
    int end = 1;
    while (true) {
      var range = numbers.getRange(start, end + 1).toList();
      final sum = range.reduce((value, element) => value + element);
      if (sum == target) {
        range.sort((a, b) => a - b);
        return range.first + range.last;
      }
      if (sum > target) {
        start++;
        end = start + 1;
      }
      if (sum < target) {
        end++;
      }
    }

    return 0;
  }

  @override
  String get sample1 => '''35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576''';

  @override
  String get sample2 => sample1;
}
