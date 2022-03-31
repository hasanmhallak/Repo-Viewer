import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/presentation/app_widget.dart';

void main() {
  runApp(
    //   DevicePreview(
    //     enabled: !kReleaseMode,
    //     builder: (context) {
    //       return ProviderScope(
    //         child: AppWidget(),
    //       );
    //     },
    //   ),
    // );
    ProviderScope(
      child: AppWidget(),
    ),
  );
}
