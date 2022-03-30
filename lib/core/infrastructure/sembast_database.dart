import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastDatabase {
  late Database _instance;
  Database get instance => _instance;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    if (_hasBeenInitialized) return;
    if (kIsWeb) {
      final factory = databaseFactoryWeb;
      _instance = await factory.openDatabase('test');
      _hasBeenInitialized = true;
      return;
    }
    final dbDirectory = await getApplicationDocumentsDirectory();
    // final dbDirectory = Directory('downloads');
    dbDirectory.create(recursive: true);
    final dbPath = join(dbDirectory.path, 'db.sembast');
    _instance = await databaseFactoryIo.openDatabase(dbPath);
    _hasBeenInitialized = true;
  }
}
