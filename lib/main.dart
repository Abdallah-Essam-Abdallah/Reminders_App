import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reminders_app/core/theme/theme.dart';
import 'package:reminders_app/core/utils/appstrings.dart';
import 'package:reminders_app/features/localization/cubit/localization_cubit.dart';

import 'package:reminders_app/features/reminders/cubit/reminders_cubit.dart';
import 'package:reminders_app/features/reminders/model/reminder_model.dart';
import 'package:reminders_app/features/reminders/view/screens/splash_screen.dart';

import 'core/bloc_observer/bloc_observer.dart';
import 'core/notification_service.dart/notification_service.dart';
import 'features/localization/localozation_services/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ReminderModelAdapter());
  await Hive.openBox<ReminderModel>(AppStrings.hiveBoxName);
  await NotificationService().initNotifications();
  await NotificationService().requestPermission();
  Bloc.observer = MyBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemindersCubit(),
        ),
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }

              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
