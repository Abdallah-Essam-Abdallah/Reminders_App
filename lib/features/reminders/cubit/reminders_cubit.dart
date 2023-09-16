import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reminders_app/core/utils/appstrings.dart';
import 'package:reminders_app/features/reminders/model/reminder_model.dart';

part 'reminders_state.dart';

class RemindersCubit extends Cubit<RemindersState> {
  RemindersCubit() : super(RemindersInitial());

  final Box reminderBox = Hive.box<ReminderModel>(AppStrings.hiveBoxName);
  TimeOfDay selectedTime = TimeOfDay.now();

  Future addReminder({
    required String title,
    required String description,
    required String date,
  }) async {
    emit(AddReminderLoadingState());
    try {
      ReminderModel reminderModel = ReminderModel(
          title: title,
          description: description,
          date: date,
          id: title.length +
              description.length +
              selectedTime.hour +
              selectedTime.minute);
      await reminderBox.add(reminderModel);
      emit(AddReminderLoadedState());
    } catch (e) {
      emit(AddOrUpdateReminderErrorState(error: e.toString()));
    }
  }

  Future<void> updateReminder(
      {required ReminderModel reminderModel,
      required String title,
      required String description,
      required String date}) async {
    emit(UpdateReminderLoadingState());
    try {
      reminderModel.title = title;
      reminderModel.description = description;
      reminderModel.date = date;
      await reminderModel.save();
      emit(UpdateReminderLoadedState());
    } catch (e) {
      emit(AddOrUpdateReminderErrorState(error: e.toString()));
    }
  }

  Future<void> deleteReminder({required ReminderModel reminderModel}) async {
    emit(DeleteReminderLoadingState());
    try {
      await reminderModel.delete();
      emit(DeleteReminderLoadedState());
    } catch (e) {
      emit(DeleteReminderErrorState(error: e.toString()));
    }
  }
}
