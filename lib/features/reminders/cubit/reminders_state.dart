part of 'reminders_cubit.dart';

abstract class RemindersState extends Equatable {
  const RemindersState();
  @override
  List<Object> get props => [];
}

final class RemindersInitial extends RemindersState {}

final class AddReminderLoadingState extends RemindersState {}

final class AddReminderLoadedState extends RemindersState {}

final class UpdateReminderLoadingState extends RemindersState {}

final class UpdateReminderLoadedState extends RemindersState {}

final class AddOrUpdateReminderErrorState extends RemindersState {
  final String error;

  const AddOrUpdateReminderErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class DeleteReminderLoadingState extends RemindersState {}

final class DeleteReminderLoadedState extends RemindersState {}

final class DeleteReminderErrorState extends RemindersState {
  final String error;

  const DeleteReminderErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
