import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

/// Global logger instance with recommended settings
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // number of method calls to show
    errorMethodCount: 8, // number of method calls if stacktrace is provided
    lineLength: 120, // width of the output
    colors: true, // color the log
    printEmojis: true, // include emojis
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // include timestamp
  ),
);

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.i('🟢 Bloc Created → ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d('📩 Event → ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.i('🔄 Change → ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d(
      '➡️ Transition → ${bloc.runtimeType}\n'
      'Current: ${transition.currentState}\n'
      'Event: ${transition.event}\n'
      'Next: ${transition.nextState}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('❌ Error → ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    logger.w('🔻 Bloc Closed → ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
