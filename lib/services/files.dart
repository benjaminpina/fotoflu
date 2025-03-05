import 'dart:io';

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
