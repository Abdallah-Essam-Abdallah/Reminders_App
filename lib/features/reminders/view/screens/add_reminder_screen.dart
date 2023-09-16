import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/components/snack_bar.dart';
import 'package:reminders_app/core/components/text_form_field.dart';
import 'package:reminders_app/core/utils/appstrings.dart';
import 'package:reminders_app/core/utils/time_converter.dart';
import 'package:reminders_app/features/localization/localozation_services/app_localization.dart';

import 'package:reminders_app/features/reminders/model/reminder_model.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../core/notification_service.dart/notification_service.dart';
import '../../cubit/reminders_cubit.dart';

class AddOrUpdateReminderScreen extends StatefulWidget {
  const AddOrUpdateReminderScreen(
      {super.key, required this.addOrUpdate, this.reminderModel});
  final String addOrUpdate;
  final ReminderModel? reminderModel;
  @override
  State<AddOrUpdateReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddOrUpdateReminderScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RemindersCubit remindersCubit =
        BlocProvider.of<RemindersCubit>(context);
    return BlocProvider.value(
      value: BlocProvider.of<RemindersCubit>(context),
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(widget.addOrUpdate == AppStrings.edit
              ? AppStrings.updateReminder.tr(context)
              : AppStrings.addReminder.tr(context)),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
              child: Column(
                children: [
                  AppTextFormField(
                    hintText: AppStrings.title.tr(context),
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    validator: (title) {
                      if (title!.isEmpty) {
                        return AppStrings.validationMessage.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .02,
                  ),
                  AppTextFormField(
                    hintText: AppStrings.description.tr(context),
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    maxLines: 4,
                    validator: (description) {
                      if (description!.isEmpty) {
                        return AppStrings.validationMessage.tr(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .02,
                  ),
                  SizedBox(
                    width: Responsive.getWidth(context) * .40,
                    height: Responsive.getHeight(context) * .05,
                    child: ElevatedButton(
                        onPressed: () async {
                          remindersCubit.selectedTime = (await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())) ??
                              TimeOfDay.now();
                        },
                        child: AutoSizeText(
                          AppStrings.selectTime.tr(context),
                          maxLines: 1,
                        )),
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  SizedBox(
                    width: Responsive.getWidth(context) * .40,
                    height: Responsive.getHeight(context) * .05,
                    child: BlocConsumer<RemindersCubit, RemindersState>(
                      listener: (context, state) {
                        if (state is AddReminderLoadedState ||
                            state is UpdateReminderLoadedState) {
                          Navigator.of(context).pop();
                        } else if (state is AddOrUpdateReminderErrorState) {
                          showSnackBar(state.error, context);
                        }
                      },
                      builder: (context, state) {
                        if (state is AddReminderLoadingState ||
                            state is UpdateReminderLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (await AwesomeNotifications()
                                    .isNotificationAllowed()) {
                                  widget.addOrUpdate == AppStrings.edit
                                      ? {
                                          remindersCubit.updateReminder(
                                              reminderModel:
                                                  widget.reminderModel!,
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              date: TimeConverter.formatTime(
                                                  time: remindersCubit
                                                      .selectedTime)),
                                          NotificationService()
                                              .scheduleDailyNotification(
                                                  title: titleController.text,
                                                  body: descriptionController
                                                      .text,
                                                  time: remindersCubit
                                                      .selectedTime,
                                                  id: widget.reminderModel!.id)
                                        }
                                      : {
                                          remindersCubit.addReminder(
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              date: TimeConverter.formatTime(
                                                  time: remindersCubit
                                                      .selectedTime)),
                                          NotificationService()
                                              .scheduleDailyNotification(
                                                  title: titleController.text,
                                                  body: descriptionController
                                                      .text,
                                                  time: remindersCubit
                                                      .selectedTime,
                                                  id: titleController
                                                          .text.length +
                                                      descriptionController
                                                          .text.length +
                                                      remindersCubit
                                                          .selectedTime.hour +
                                                      remindersCubit
                                                          .selectedTime.minute)
                                        };
                                } else {
                                  await NotificationService()
                                      .requestPermission();
                                }
                              }
                            },
                            child: AutoSizeText(
                              widget.addOrUpdate == AppStrings.edit
                                  ? AppStrings.updateReminder.tr(context)
                                  : AppStrings.addReminder.tr(context),
                              maxLines: 1,
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
