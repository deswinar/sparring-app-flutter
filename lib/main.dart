import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_sparring/core/bloc/app_bloc_observer.dart';
import 'package:flutter_sparring/core/di/injection.dart';
import 'package:flutter_sparring/core/routing/app_router.dart';
import 'package:flutter_sparring/core/storage/objectbox/objectbox_store.dart';
import 'package:flutter_sparring/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:intl/date_symbol_data_local.dart';

late ObjectBoxStore objectbox;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDateFormatting('id_ID', null);
  await dotenv.load(fileName: ".env");
  await configureDependencies();

  objectbox = getIt<ObjectBoxStore>();
  
  if (kDebugMode) Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>()..checkAuthStatus(),
        ),
        // add more blocs here
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Sparring App',
        routerConfig: appRouter,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
      ),
    );
  }
}