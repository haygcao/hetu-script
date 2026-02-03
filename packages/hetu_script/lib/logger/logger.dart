import 'message_severity.dart';

abstract class HTLogger {
  const HTLogger();

  void log(String message, {MessageSeverity severity = MessageSeverity.none});

  void debug(String message) => log(message, severity: MessageSeverity.debug);

  void info(String message) => log(message, severity: MessageSeverity.info);

  void warning(String message) =>
      log(message, severity: MessageSeverity.warning);

  void error(String message) => log(message, severity: MessageSeverity.error);
}
