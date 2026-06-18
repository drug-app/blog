/// Вариант ответа в опроснике AI-скана.
class ScanOption {
  final String title;
  final String? subtitle;
  const ScanOption(this.title, [this.subtitle]);
}

/// Один вопрос AI-скана.
class ScanQuestion {
  final String tag; // "AI-скан 1 из 5"
  final String title;
  final String subtitle;
  final List<ScanOption> options;
  final bool multi; // множественный выбор
  final int maxSelect; // максимум выборов при multi
  final bool grid; // плиточная сетка (как «О чём ваш блог?»)

  const ScanQuestion({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.options,
    this.multi = false,
    this.maxSelect = 1,
    this.grid = false,
  });
}
