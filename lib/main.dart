import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomosprint/ui/core/app.dart';
import 'package:pomosprint/utils/logger/talker/talker_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

Future<void> main() async {
  final talker = TalkerFlutter.init();

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack, 'FlutterError');
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'PlatformDispatcher');
    return true;
  };
  ErrorWidget.builder = (details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };

  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  runApp(
    ProviderScope(
      overrides: [talkerProvider.overrideWithValue(talker)],
      observers: [TalkerRiverpodObserver(talker: talker)],
      child: const App(),
    ),
  );
}
