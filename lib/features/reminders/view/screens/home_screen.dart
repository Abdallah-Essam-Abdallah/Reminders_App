import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reminders_app/core/utils/appstrings.dart';
import 'package:reminders_app/features/localization/localozation_services/app_localization.dart';
import 'package:reminders_app/features/localization/view/setting_screen.dart';
import 'package:reminders_app/features/reminders/view/screens/add_reminder_screen.dart';
import 'package:reminders_app/features/reminders/view/widgets/noreminders_widget.dart';
import 'package:reminders_app/features/reminders/view/widgets/reminders_list.dart';
import '../../model/reminder_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(AppStrings.home.tr(context)),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Image.asset(
              AppStrings.appIcon,
              width: double.infinity,
            )),
            ListTile(
              leading: const Icon(Icons.settings),
              title: AutoSizeText(AppStrings.settings.tr(context)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddOrUpdateReminderScreen(
                    addOrUpdate: AppStrings.addReminder,
                  )));
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder<Box<ReminderModel>>(
          valueListenable:
              Hive.box<ReminderModel>(AppStrings.hiveBoxName).listenable(),
          builder: (context, value, child) {
            final reminders = value.values.toList().cast<ReminderModel>();
            if (reminders.isEmpty) {
              return const EmptyRemindersWidget();
            } else {
              return RemindersList(
                reminders: reminders,
              );
            }
          }),
    );
  }
}
