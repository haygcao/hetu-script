import '../logger/message_severity.dart';
import '../lexicon/lexicon.dart';
import '../logger/logger.dart';
import '../logger/console_logger.dart';

class Console {
  HTLexicon lexicon;
  HTLogger logger;

  static const _defaultTimerId = 'default';
  final Map<String, Stopwatch> _stopwatches = {};

  Console({
    required this.lexicon,
    this.logger = const HTConsoleLogger(),
  });

  void log(dynamic messages,
      {MessageSeverity severity = MessageSeverity.none}) {
    if (messages is List) {
      messages = messages.map((e) => lexicon.stringify(e)).join(' ');
    } else {
      messages = lexicon.stringify(messages);
    }
    logger.log(messages, severity: severity);
  }

  void debug(dynamic messages) =>
      log(messages, severity: MessageSeverity.debug);

  void info(dynamic messages) => log(messages, severity: MessageSeverity.info);

  void warning(dynamic messages) =>
      log(messages, severity: MessageSeverity.warning);

  void error(dynamic messages) =>
      log(messages, severity: MessageSeverity.error);

  void time(String? id) {
    id ??= _defaultTimerId;
    if (_stopwatches.containsKey(id)) {
      warning('Timer \'$id\' already exists.');
    }

    _stopwatches[id] = Stopwatch()..start();
  }

  int? timeLog(String? id, {bool endTimer = false}) {
    id ??= _defaultTimerId;
    int? t;
    if (_stopwatches.containsKey(id)) {
      t = _stopwatches[id]!.elapsedMilliseconds;
      log('$id: $t ms');
      if (endTimer) {
        _stopwatches[id]!.stop();
        _stopwatches.remove(id);
      }
    } else {
      error('Timer \'$id\' does not exist.');
    }
    return t;
  }

  int? timeEnd(String? id) => timeLog(id, endTimer: true);
}
