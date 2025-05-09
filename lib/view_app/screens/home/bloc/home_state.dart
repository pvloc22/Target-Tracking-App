import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/goal_model.dart';
import '../../../../data/model/task_model.dart';

@immutable
abstract class HomeState extends Equatable {}

class InitHomeScreen extends HomeState {

@override
List<Object?> get props => [];
}

class LoadingHomeScreen extends HomeState {
    
@override
List<Object?> get props => [];
}

class SuccessHomeScreen extends HomeState {
    final List<Task> taskToday;
    final List<Goal> goals;
    final List<Goal> goalsCompleted;
    final List<Task> goalsArchived;

  SuccessHomeScreen({required this.taskToday, required this.goals, required this.goalsCompleted, required this.goalsArchived});

@override
List<Object?> get props => [taskToday, goals, goalsCompleted, goalsArchived];
}

class ErrorHomeScreen extends HomeState {
    final String message;

  ErrorHomeScreen(this.message);
    @override
List<Object?> get props => [message];
}   