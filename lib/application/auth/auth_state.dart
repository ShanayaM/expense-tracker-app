import 'package:expense_tracker_app/application/auth/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = _Unathenticated;
  const factory AuthState.authenticated({
    required User user,
  }) = Authenticated;
  const factory AuthState.loading() = _Loading;
}
