import 'package:expense_tracker_app/auth/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/auth/auth_failure.dart';
import "package:flutter/foundation.dart";

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = _Unathenticated;
  const factory AuthState.failed({
    required AuthFailure failure,
  }) = _Failed;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({
    required User user,
  }) = _Authenticated;
}
