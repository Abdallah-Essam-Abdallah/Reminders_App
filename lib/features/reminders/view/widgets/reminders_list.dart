import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reminders_app/core/utils/responsive.dart';
import 'package:reminders_app/features/localization/localozation_services/app_localization.dart';
import 'package:reminders_app/features/reminders/view/widgets/delete.button.dart';

import '../../../../core/utils/appstrings.dart';
import '../../model/reminder_model.dart';
import '../screens/add_reminder_screen.dart';

class RemindersList extends StatelessWidget {
  const RemindersList({super.key, required this.reminders});
  final List<ReminderModel> reminders;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getWidth(context) * .01),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.getWidth(context) * .05,
                          vertical: Responsive.getHeight(context) * .01,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    reminders[index].title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    maxLines: 1,
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: AutoSizeText(
                                    reminders[index].date,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Responsive.getHeight(context) * .01,
                            ),
                            AutoSizeText(
                              reminders[index].description,
                              maxLines: 4,
                            ),
                            SizedBox(
                              height: Responsive.getHeight(context) * .01,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddOrUpdateReminderScreen(
                                                      addOrUpdate:
                                                          AppStrings.edit,
                                                      reminderModel:
                                                          reminders[index],
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.edit),
                                          AutoSizeText(
                                              AppStrings.edit.tr(context)),
                                        ],
                                      )),
                                ),
                                const Spacer(),
                                DeleteButton(reminder: reminders[index])
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: Responsive.getHeight(context) * .01,
            );
          },
          itemCount: reminders.length),
    );
  }
}
