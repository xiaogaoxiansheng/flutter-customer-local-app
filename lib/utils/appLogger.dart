import 'package:logger/logger.dart';

class AppLogger {
  // 【AI修改】统一日志实例，支持全局调用
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTime,
    ),
  );

  const AppLogger._();

  // 【AI修改】初始化入口（扩展点：远程上报等）
  static void init() => _logger.i('Logger initialized');

  // 【AI修改】便捷方法
  static void d(Object message, [Object? error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  static void i(Object message, [Object? error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  static void w(Object message, [Object? error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  static void e(Object message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  static void t(Object message, [Object? error, StackTrace? stackTrace]) =>
      _logger.t(message, error: error, stackTrace: stackTrace);
}

