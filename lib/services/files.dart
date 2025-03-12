import 'dart:io';
import 'package:flutter/foundation.dart';

Future<Directory> _createFolder(String folderName) async {
  final folder = Directory(folderName);

  if (!await folder.exists()) {
    await folder.create(recursive: true);
  }

  return folder;
}

Future<String?> crearEstrcutura(String base, List<String> dirs) async {
  for (final dir in dirs) {
    final path = '$base/$dir';
    try {
      await _createFolder(path);
    } catch (e) {
      return 'Error creating directory $path: $e';
    }
  }

  return null;
}

Future<String?> copyFile(
  String sourcePath,
  String newPath, {
  bool preserveOriginal = true,
}) async {
  try {
    final sourceFile = File(sourcePath);
    await sourceFile.copy(newPath);
  } catch (e) {
    return 'Error al copiar el archivo: $e';
  }

  if (!preserveOriginal) {
    try {
      await File(sourcePath).delete();
    } catch (e) {
      return 'Error al eliminar el archivo original: $e';
    }
  }

  return null;
}

Future<List<String>> filesByExt(String parentDir, List<String> exts) async {
  final dir = Directory(parentDir);
  List<String> fileList = [];
  // Pasar lista de extensiones a minúsculas
  exts = exts.map((ext) => ext.toLowerCase()).toList();

  try {
    final files = dir.listSync().whereType<File>().toList();

    final filteredFiles =
        files.where((file) {
          final extension = file.path.split('.').last.toLowerCase();
          return exts.contains('.$extension');
        }).toList();

    for (final file in filteredFiles) {
      fileList.add(file.path);
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error al leer archivos: $e');
    }
  }

  return fileList;
}

Future<bool> directoryExists(String path) async {
  final dir = Directory(path);
  return await dir.exists();
}

Future<void> deleteFile(String path) async {
  final file = File(path);
  try {
    await file.delete();
  } catch (e) {
    if (kDebugMode) {
      print('Error al eliminar el archivo: $e');
    }
  }
}
