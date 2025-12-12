import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sko_flutter/auth/data/repositoryies/user_repository.dart';
import 'package:equatable/equatable.dart';

//
// ---------- EVENTS ----------
//

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {
  final String userId;

  LoadUser(this.userId);

  @override
  List<Object?> get props => [userId];
}

//
// ---------- STATES ----------
//

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Map<String, dynamic> data;

  UserLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

//
// ---------- BLOC ----------
//

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      try {
        final data = await repository.getUser(event.userId);
        emit(UserLoaded(data));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}