import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/notification_service.dart/notification_service.dart';
import 'package:reminders_app/features/localization/localozation_services/app_localization.dart';
import 'package:reminders_app/features/reminders/model/reminder_model.dart';

import '../../../../core/utils/appstrings.dart';
import '../../cubit/reminders_cubit.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.reminder});
  final ReminderModel reminder;
  @override
  Widget build(BuildContext context) {
    final RemindersCubit remindersCubit =
        BlocProvider.of<RemindersCubit>(context);
    return Expanded(
      child: TextButton(
          onPressed: () {
            showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      AppStrings.delete.tr(context),
                      maxLines: 1,
                    ),
                    content: Text(
                      AppStrings.deleteDialogContent.tr(context),
                      maxLines: 2,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            remindersCubit.deleteReminder(
                                reminderModel: reminder);
                            NotificationService()
                                .cancelNotification(reminder.id);
                            Navigator.pop(context);
                          },
                          child: Text(AppStrings.delete.tr(context))),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppStrings.close.tr(context)))
                    ],
                  );
                });
          },
          child: Row(
            children: [
              const Icon(Icons.delete),
              AutoSizeText(AppStrings.delete.tr(context)),
            ],
          )),
    );
  }
}
