import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/auth_repository.dart';

/// true, если Supabase успешно инициализирован (есть реальные ключи).
final supabaseReadyProvider = StateProvider<bool>((_) => false);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(Supabase.instance.client);
});

/// Состояние операций авторизации.
class AuthState {
  final bool loading;
  final String? error;
  const AuthState({this.loading = false, this.error});

  AuthState copyWith({bool? loading, String? error}) =>
      AuthState(loading: loading ?? this.loading, error: error);
}

class AuthController extends StateNotifier<AuthState> {
  final Ref _ref;
  AuthController(this._ref) : super(const AuthState());

  bool get _ready => _ref.read(supabaseReadyProvider);

  Future<bool> register(String email, String password) async {
    return _run(() => _ref
        .read(authRepositoryProvider)
        .signUpWithEmail(email: email, password: password));
  }

  Future<bool> login(String email, String password) async {
    return _run(() => _ref
        .read(authRepositoryProvider)
        .signInWithEmail(email: email, password: password));
  }

  Future<bool> google() =>
      _run(() => _ref.read(authRepositoryProvider).signInWithGoogle());

  Future<bool> apple() =>
      _run(() => _ref.read(authRepositoryProvider).signInWithApple());

  Future<bool> _run(Future<void> Function() action) async {
    // Демо-режим: пока ключи Supabase не добавлены, пропускаем пользователя
    // дальше без реальной авторизации, чтобы можно было кликать весь флоу.
    if (!_ready) {
      state = const AuthState();
      return true;
    }
    state = const AuthState(loading: true);
    try {
      await action();
      state = const AuthState();
      return true;
    } on AuthException catch (e) {
      state = AuthState(error: e.message);
      return false;
    } catch (e) {
      state = AuthState(error: 'Что-то пошло не так. Попробуй ещё раз.');
      return false;
    }
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});
