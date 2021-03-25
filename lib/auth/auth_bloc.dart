import 'package:expense_tracker_app/authentication_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_state.dart';

class AuthBloc extends StateNotifier<AuthState> {
  final AuthRepository authRepo;

  AuthBloc(this.authRepo) : super(AuthState.unauthenticated());

  Future<void> loginBtnPressed() async {
    state = AuthState.loading();
    final failureOrUser = await authRepo.login();
    failureOrUser.fold(
      (failure) => state = AuthState.failed(failure: failure),
      (user) => state = AuthState.authenticated(user: user),
    );
  }
}

final authBlocProvider = StateNotifierProvider<AuthBloc>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthBloc(authRepo);
});
