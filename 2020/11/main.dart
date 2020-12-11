import '../../base/base.dart';

void main() {
  Solution().solve();
}

class Solution extends Advent {
  final empty = 'L'.codeUnitAt(0);
  final floor = '.'.codeUnitAt(0);
  final occ = '#'.codeUnitAt(0);
  final out = ' '.codeUnitAt(0);

  @override
  int part1(List<String> lines) {
    // print(lines);
    bool changed = true;
    while (changed) {
      changed = false;
      final next = List.filled(lines.length,
          String.fromCharCodes(List.filled(lines[0].length, floor)));
      for (int y = 0; y < lines.length; y++) {
        for (int x = 0; x < lines[0].length; x++) {
          final current = get(x, y, lines);
          final adjacents = getAdjacents(x, y, lines);
          if (current == empty) {
            if (adjacents == 0) {
              updateNext(next, x, y, occ);
              changed = true;
            } else {
              updateNext(next, x, y, empty);
            }
          }

          if (current == occ) {
            if (adjacents >= 4) {
              updateNext(next, x, y, empty);
              changed = true;
            } else {
              updateNext(next, x, y, occ);
            }
          }
        }
      }

      lines = next;
      // draw(lines);
    }

    int count = 0;
    for (int y = 0; y < lines.length; y++) {
      for (int x = 0; x < lines[0].length; x++) {
        if (get(x, y, lines) == occ) {
          count++;
        }
      }
    }

    return count;
  }

  void draw(List<String> lines) {
    for (int y = 0; y < lines.length; y++) {
      print(lines[y]);
    }
    print("");
    print("");
  }

  void updateNext(List<String> next, int x, int y, int code) {
    next[y] = next[y].replaceRange(x, x + 1, String.fromCharCode(code));
  }

  int get(int x, int y, List<String> lines) {
    if (x < 0 || x >= lines[0].length || y < 0 || y >= lines.length) {
      return out;
    }
    return lines[y].codeUnitAt(x);
  }

  int getAdjacents(int x, int y, List<String> lines) {
    int count = 0;

    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (!(i == 0 && j == 0) && get(x + i, y + j, lines) == occ) {
          count++;
        }
      }
    }

    // if (get(x + 1, y, lines) == occ){
    //   count++;
    // }
    //
    // if (get(x - 1, y, lines) == occ){
    //   count++;
    // }
    //
    // if (get(x, y + 1, lines) == occ){
    //   count++;
    // }
    //
    // if (get(x, y - 1, lines) == occ){
    //   count++;
    // }

    return count;
  }

  final directions = [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1],
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1],
  ];

  int seeOccupied(int x, int y, List<String> lines) {
    int count = 0;
    int rowlen = lines[0].length;
    int collen = lines.length;
    for (final dir in directions) {
      int xx = x + dir[0];
      int yy = y + dir[1];
      while(0 <= xx && xx < rowlen && 0 <= yy && yy < collen) {
        if (get(xx, yy, lines) == empty) {
          break;
        }
        if (get(xx, yy, lines) == occ) {
          count++;
          break;
        }
        xx += dir[0];
        yy += dir[1];
      }
    }
    return count;
  }

  @override
  int part2(List<String> lines) {
    bool changed = true;
    while (changed) {
      changed = false;
      final next = List.filled(lines.length,
          String.fromCharCodes(List.filled(lines[0].length, floor)));
      for (int y = 0; y < lines.length; y++) {
        for (int x = 0; x < lines[0].length; x++) {
          final current = get(x, y, lines);
          final seeOcc = seeOccupied(x, y, lines);
          if (current == empty) {
            if (seeOcc == 0) {
              updateNext(next, x, y, occ);
              changed = true;
            } else {
              updateNext(next, x, y, empty);
            }
          }

          if (current == occ) {
            if (seeOcc >= 5) {
              updateNext(next, x, y, empty);
              changed = true;
            } else {
              updateNext(next, x, y, occ);
            }
          }
        }
      }

      lines = next;
      draw(lines);
    }

    int count = 0;
    for (int y = 0; y < lines.length; y++) {
      for (int x = 0; x < lines[0].length; x++) {
        if (get(x, y, lines) == occ) {
          count++;
        }
      }
    }

    return count;
  }

  @override
  String get sample1 => '''L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL''';

  @override
  String get sample2 => sample1;
}
