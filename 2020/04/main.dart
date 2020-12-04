import 'dart:io';

void main() {
  final ex1 = '''ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in'''
      .split('\n');
  final file = File('input');
  final lines = file.readAsLinesSync();

  print(' ==== Part 1 ==== ');

  print(part1(ex1));
  print(part1(lines));

  print(' ==== Part 2 ==== ');

  final exInvalid = '''eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007'''
      .split('\n');

  print(part2(exInvalid));

  final exValid = '''pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719'''
      .split('\n');

  print(part2(exValid));
  print(part2(lines));
}

int part1(List<String> input) {
  int count = 0;
  List<List<Field>> batches = parseBatches(input);

  for (final batch in batches) {
    final hasKey = List.filled(mandatoryKeys.length, false);

    for (final field in batch) {
      // print(field.key);
      final index = mandatoryKeys.indexOf(field.key);
      if (index >= 0) {
        hasKey[index] = true;
      } else {
        if (!optionalKeys.contains(field.key)) {
          throw 'Unknown key in field: $field';
        }
      }
    }

    // print(hasKey);

    if (hasKey.every((element) => element)) {
      count++;
    }
  }

  return count;
}

List<List<Field>> parseBatches(List<String> input) {
  final batches = <List<Field>>[];
  var batch = <Field>[];
  for (final line in input) {
    if (line.isEmpty) {
      // print(batch);
      batches.add(batch);
      batch = [];
      continue;
    }
    batch.addAll(
        line.split(' ').map((e) => Field(e.split(':')[0], e.split(':')[1])));
  }
  batches.add(batch);
  // print(batches);
  return batches;
}

const mandatoryKeys = [
  'byr',
  'iyr',
  'eyr',
  'hgt',
  'hcl',
  'ecl',
  'pid',
];

const optionalKeys = [
  'cid',
];

class Field {
  String key;
  String value;

  Field(this.key, this.value);

  @override
  String toString() {
    return '$key:$value';
  }
}

int part2(List<String> input) {
  int count = 0;
  List<List<Field>> batches = parseBatches(input);

  for (final batch in batches) {
    final isValid = List.filled(mandatoryKeys.length, false);

    for (final field in batch) {
      var valid = false;
      final index = mandatoryKeys.indexOf(field.key);
      if (index < 0) {
        if (!optionalKeys.contains(field.key)) {
          throw 'Unknown key in field: $field';
        } else {
          continue;
        }
      }
      try {
        switch (field.key) {
          case 'byr':
            final year = int.parse(field.value);
            valid = year >= 1920 && year <= 2002;
            break;
          case 'iyr':
            final year = int.parse(field.value);
            valid = year >= 2010 && year <= 2020;
            break;
          case 'eyr':
            final year = int.parse(field.value);
            valid = year >= 2020 && year <= 2030;
            break;
          case 'hgt':
            if (field.value.endsWith('cm')) {
              final height = int.parse(field.value.substring(0, 3));
              valid = height >= 150 && height <= 193;
            }
            if (field.value.endsWith('in')) {
              final height = int.parse(field.value.substring(0, 2));
              valid = height >= 59 && height <= 76;
            }
            break;
          case 'hcl':
            valid = RegExp(r'^#[a-f0-9]{6}$').hasMatch(field.value);
            break;
          case 'ecl':
            valid = ['amb', 'blu', 'brn', 'gry','grn','hzl','oth'].contains(field.value);
            break;
          case 'pid':
            valid = RegExp(r'^[0-9]{9}$').hasMatch(field.value);
            break;
        }
      } catch (e) {
        // print(field);
        // print(e);
      }
      isValid[index] = valid;
    }

    // print(isValid);

    if (isValid.every((element) => element)) {
      count++;
    }
  }

  return count;
}
