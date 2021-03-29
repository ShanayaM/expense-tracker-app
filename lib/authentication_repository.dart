// import 'dart:async';
// import 'package:dartz/dartz.dart';
// import 'package:expense_tracker_app/application/auth/user.dart';
// import 'package:expense_tracker_app/domain/auth/auth_failure.dart';
// import 'package:expense_tracker_app/infrastructure/auth/mock_auth_service.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class AuthRepository {
//   final MockAuthService authService;
//   AuthRepository(this.authService);

//   Future<Either<AuthFailure, User>> login() async {
//     try {
//       final result = await authService.login();
//       return right(User(id: result['userid'], userName: result['username']));
//     } catch (_) {
//       print('An error occurred');
//       return left(GeneralAuthFailure());
//     }
//   }

//   Future<Either<AuthFailure, Unit>> logout() async {
//     try {
//       final result = await authService.logout();
//       if (result) {
//         return right(unit);
//       } else {
//         return left(GeneralAuthFailure());
//       }
//     } catch (_) {
//       return left(GeneralAuthFailure());
//     }
//   }
// }

// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   final mockAuthService = ref.watch(mockAuthServiceProvider);
//   return AuthRepository(mockAuthService);
// });
