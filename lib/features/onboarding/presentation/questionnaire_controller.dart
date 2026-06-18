import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Хранит ответы пользователя по ходу AI-скана.
class QuestionnaireState {
  final String name;
  final Map<int, Set<int>> answers; // индекс вопроса -> выбранные варианты

  const QuestionnaireState({this.name = '', this.answers = const {}});

  QuestionnaireState copyWith({String? name, Map<int, Set<int>>? answers}) =>
      QuestionnaireState(
        name: name ?? this.name,
        answers: answers ?? this.answers,
      );
}

class QuestionnaireController extends StateNotifier<QuestionnaireState> {
  QuestionnaireController() : super(const QuestionnaireState());

  void setName(String name) => state = state.copyWith(name: name);

  void toggle(int question, int option, {required bool multi, required int max}) {
    final next = {
      for (final e in state.answers.entries) e.key: {...e.value}
    };
    final set = next.putIfAbsent(question, () => <int>{});
    if (multi) {
      if (set.contains(option)) {
        set.remove(option);
      } else if (set.length < max) {
        set.add(option);
      }
    } else {
      set
        ..clear()
        ..add(option);
    }
    state = state.copyWith(answers: next);
  }

  Set<int> selected(int question) => state.answers[question] ?? <int>{};
}

final questionnaireProvider =
    StateNotifierProvider<QuestionnaireController, QuestionnaireState>(
        (ref) => QuestionnaireController());
