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

Future<List<String>> filesByExt(String parentDir, String ext) async {
  final dir = Directory(parentDir);
  List<String> fileList = [];

  try {
    final entidades = dir.list();
    await for (FileSystemEntity entidad in entidades) {
      if (entidad is File && entidad.path.endsWith(ext)) {
        fileList.add(entidad.path);
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error al listar archivos: $e');
    }
  }

  return fileList;
}
