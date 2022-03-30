import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/sembast_database.dart';

final sembastProvider = Provider((ref) => SembastDatabase());

final dioForRepo = Provider((ref) => Dio());
