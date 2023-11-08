import 'dart:io';
import 'package:intl/number_symbols.dart';
import 'package:path_provider/path_provider.dart';

// 文件管理工具类
class FileManager {
  // 获取应用程序的本地存储路径
  static Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  /// 获取pdf的Directory
  static Future<Directory> get pdfDirectory async {
    final path = await _localPath;
    Directory directory = Directory('$path/pdf');
    if (!directory.existsSync()) {
      directory.createSync();
    }
    return directory;
  }

  /// 获取Video的Directory
  static Future<Directory> get localVideoDirectory async {
    final path = await _localPath;
    return Directory('$path/video');
  }

  /// 获取music的Directory
  static Future<Directory> get localmusicDirectory async {
    final path = await _localPath;
    return Directory('$path/audio');
  }

  /// 获取Pic的Directory
  static Future<Directory> get localPicDirectory async {
    final path = await _localPath;
    return Directory('$path/photo');
  }

  // 创建自定义文件夹
  static Future<Directory> createDirectory(String directoryName) async {
    final path = await _localPath;
    final directory = Directory('$path/$directoryName');
    if (!directory.existsSync()) {
      return Directory('$path/$directoryName').create();
    }
    return directory;
  }

  // 创建自定义文件
  static Future<File> createFile(String fileName,
      {String parentFilePath = "video"}) async {
    final path = await _localPath;
    return File('$path/$parentFilePath/$fileName').create();
  }

  // 通过文件名获取文件
  static Future<File> getFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  // 获取文件夹所有的xx文件
  static Future<List<FileSystemEntity>> getDirectoryTypeFiles(
      String directoryName,
      {String fileType = ".mp4"}) async {
    final path = await _localPath;
    final directory = Directory('$path/$directoryName');
    if (!directory.existsSync()) {
      await createDirectory(directoryName);
    }
    List<FileSystemEntity> list =
        directory.listSync().whereType<File>().toList();
    List<FileSystemEntity> list1 = list.where((element) {
      if (element.path.contains(".$fileType")) {
        return true;
      } else {
        return false;
      }
    }).toList();
    return list1;
  }

  // 获取Documents文件夹所有的xx文件
  static Future<List> getDirectoryAllFiles() async {
    final path = await _localPath;
    final directory = Directory(path);

    List list = directory.listSync().whereType().toList();
    List list1 = list.where((element) {
      if (element.path.contains(".DS_") ||
          element.path.contains("GetS") ||
          element.path.contains("shareWeb")) {
        return false;
      } else {
        return true;
      }
    }).toList();
    return list1;
  }

  // 获取某个文件夹所有的xx文件
  static Future<List<FileSystemEntity>> getDirectoryFiles(String path) async {
    // final path = await _localPath;
    final directory = Directory(path);

    List<FileSystemEntity> list =
        directory.listSync().whereType<File>().toList();
    List<FileSystemEntity> list1 = list.where((element) {
      if (element.path.contains(".DS_") ||
          element.path.contains("GetS") ||
          element.path.contains("shareWeb")) {
        return false;
      } else {
        return true;
      }
    }).toList();
    return list1;
  }

  // 修改文件名
  static Future<File> renameFile(String fileName, String newFileName) async {
    final file = await getFile(fileName);
    final path = await _localPath;
    final newFile = File('$path/$newFileName');
    return file.rename(newFile.path);
  }

  // 通过文件名删除文件
  static void deleteFile(String fileName) async {
    File file = File(fileName);
    return file.deleteSync();
  }

  // 将一个文件夹下所有的文件copy到另一个文件夹下面
  static Future<void> copyAll(
      String sourceFolder, String destinationFolder) async {
    // 获取源文件夹的路径
    final Directory sourceDir = Directory(sourceFolder);
    if (!await sourceDir.exists()) {
      throw Exception('源文件夹不存在');
    }

    // 获取目标文件夹的路径
    final Directory destinationDir = Directory(destinationFolder);
    if (!await destinationDir.exists()) {
      // 如果目标文件夹不存在，就创建它
      await destinationDir.create();
    }

    // 获取源文件夹下的文件列表
    final List<FileSystemEntity> files = sourceDir.listSync();

    // 遍历文件列表，将每个文件复制到目标文件夹
    for (final FileSystemEntity file in files) {
      final String fileName = file.path.split(Platform.pathSeparator).last;
      final File destinationFile =
          File('$destinationFolder${Platform.pathSeparator}$fileName');
      File f = File(file.path);
      await f.copy(destinationFile.path);
    }
  }

  // 将一个文件夹下所有的文件copy到另一个文件夹下面
  static Future<void> copyOne(String filePath, String destinationFolder) async {
    // 获取源文件夹的路径
    final File sourceFile = File(filePath);
    if (!await sourceFile.exists()) {
      throw Exception('源文件不存在');
    }

    // 获取目标文件夹的路径
    final Directory destinationDir = Directory(destinationFolder);
    if (!await destinationDir.exists()) {
      // 如果目标文件夹不存在，就创建它
      await destinationDir.create();
    }
    File file = File(filePath);
    final String fileName = file.path.split(Platform.pathSeparator).last;
    final File destinationFile =
        File('$destinationFolder${Platform.pathSeparator}$fileName');

    await file.copy(destinationFile.path);
  }
}
