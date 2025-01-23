import 'package:logger/logger.dart';
import 'package:pet_adoption_assignment/core/logger/log_filter.dart';

class AppLog {
  static final logger = Logger(
    filter: CustomLogFilter(),
    printer: PrettyPrinter(
      lineLength: 100,
      errorMethodCount: 5,
      methodCount: 0,
      printEmojis: false,
    ),
  );

  static void error(Object? message, {StackTrace? stackTrace}) {
    logger.e('❗ $message');
  }

  static void warning(Object? message, {StackTrace? stackTrace}) {
    logger.w('⚠️ $message');
  }

  static void usecase(Object? message) {
    logger.d('🙌 $message');
  }

  static void storage(Object? message) {
    logger.d('💾 $message');
  }

  static void apiCall(Object? message) {
    logger.i('🌐 $message');
  }

  static void info(Object? message, {StackTrace? stackTrace}) {
    logger.i('📢 $message');
  }

  static void debug(Object? message, {StackTrace? stackTrace}) {
    logger.d('🟠 $message');
  }
}
