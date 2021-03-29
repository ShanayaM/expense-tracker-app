import 'package:expense_tracker_app/application/auth/user.dart';
import 'package:expense_tracker_app/domain/auth/auth_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_state.dart';

class AuthBloc extends StateNotifier<AuthState> {
  final AuthState authState;

  AuthBloc({
    required this.authState,
  }) : super(authState);
}

final authChangesProvider = StreamProvider<User?>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return authRepo.authStateChanges();
});

final authBlocProvider = StateNotifierProvider<AuthBloc>((ref) {
  final user = ref.watch(authChangesProvider);
  return user.when(
    data: (data) => AuthBloc(
        authState: data == null
            ? AuthState.unauthenticated()
            : AuthState.authenticated(user: data)),
    loading: () => AuthBloc(authState: AuthState.loading()),
    error: (_, __) => AuthBloc(authState: AuthState.unauthenticated()),
  );
});
