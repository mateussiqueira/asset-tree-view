import 'dart:io';
import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';

void main() {
  final directory =
      Directory('/Users/mateussiqueira/projects/asset_tree_app/lib');
  sortAndCleanImportsInDirectory(directory);
}

void sortAndCleanImportsInDirectory(Directory directory) {
  final dartFiles = directory
      .listSync(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('.dart'))
      .cast<File>();

  final sortedFiles = <String>[];
  var totalImportsSorted = 0;

  for (final file in dartFiles) {
    final importsSorted = sortAndCleanImportsInFile(file);
    if (importsSorted > 0) {
      sortedFiles.add('${file.path} (Imports ordenados: $importsSorted)');
      totalImportsSorted += importsSorted;
    }
  }

  final greenPen = AnsiPen()..green();
  final bluePen = AnsiPen()..blue();
  final cyanPen = AnsiPen()..cyan();

  if (kDebugMode) {
    print(greenPen('Arquivos ordenados e limpos:'));
  }
  for (final file in sortedFiles) {
    if (kDebugMode) {
      print(cyanPen('---------------\n'));
    }
    if (kDebugMode) {
      print(bluePen(file));
    }
  }
  if (kDebugMode) {
    print(cyanPen('---------------\n'));
  }
  if (kDebugMode) {
    print(greenPen('Total de imports ordenados: $totalImportsSorted'));
  }
}

int sortAndCleanImportsInFile(File file) {
  final lines = file.readAsLinesSync();

  final imports = <String>[];
  final otherLines = <String>[];
  var inImportSection = false;

  for (final line in lines) {
    if (line.startsWith('import ')) {
      imports.add(line);
      inImportSection = true;
    } else {
      if (inImportSection && line.trim().isEmpty) {
        // Skip empty lines in the import section
        continue;
      }
      inImportSection = false;
      otherLines.add(line);
    }
  }

  imports.sort();

  final sortedLines = [...imports, '', ...otherLines];
  file.writeAsStringSync(sortedLines.join('\n'));

  return imports.length;
}
