import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/pink_tag.dart';
import '../../../widgets/screen_header.dart';
import '../data/questionnaire_data.dart';
import '../domain/scan_question.dart';
import 'questionnaire_controller.dart';

class ScanQuestionScreen extends ConsumerWidget {
  final int step;
  const ScanQuestionScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final q = scanQuestions[step];
    final selected = ref.watch(questionnaireProvider).answers[step] ?? <int>{};
    final canContinue = selected.isNotEmpty;

    void next() {
      if (step + 1 < scanQuestions.length) {
        context.push(AppRoutes.scanStep(step + 1));
      } else {
        context.push(AppRoutes.scanComplete);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ScreenHeader(),
                ),
                const SizedBox(height: 20),
                PinkTag(q.tag).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(q.title,
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.headlineMedium)
                          .animate()
                          .fadeIn(delay: 80.ms)
                          .slideY(begin: 0.12, end: 0),
                      const SizedBox(height: 12),
                      Text(q.subtitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium)
                          .animate()
                          .fadeIn(delay: 160.ms),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: q.grid
                        ? _grid(ref, q, selected)
                        : _list(ref, q, selected),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: GradientButton(
                    label: 'Продолжить',
                    onPressed: canContinue ? next : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(WidgetRef ref, ScanQuestion q, Set<int> selected) {
    return Column(
      children: [
        for (int i = 0; i < q.options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _OptionCard(
              option: q.options[i],
              selected: selected.contains(i),
              onTap: () => ref.read(questionnaireProvider.notifier).toggle(
                  step, i,
                  multi: q.multi, max: q.maxSelect),
            )
                .animate()
                .fadeIn(delay: (200 + i * 60).ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
          ),
      ],
    );
  }

  Widget _grid(WidgetRef ref, ScanQuestion q, Set<int> selected) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < q.options.length; i++)
          _ChipOption(
            label: q.options[i].title,
            selected: selected.contains(i),
            onTap: () => ref.read(questionnaireProvider.notifier).toggle(step, i,
                multi: q.multi, max: q.maxSelect),
          ).animate().fadeIn(delay: (180 + i * 40).ms).scale(
              begin: const Offset(0.92, 0.92), curve: Curves.easeOut),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final ScanOption option;
  final bool selected;
  final VoidCallback onTap;
  const _OptionCard(
      {required this.option, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.pink : Colors.transparent,
            width: 1.8,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.pink
                  .withValues(alpha: selected ? 0.22 : 0.08),
              blurRadius: selected ? 22 : 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(option.title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
            if (option.subtitle != null) ...[
              const SizedBox(height: 4),
              Text(option.subtitle!,
                  style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.textSecondary,
                      height: 1.3)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChipOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ChipOption(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.pinkLight.withValues(alpha: 0.85)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? AppColors.pink : Colors.transparent,
            width: 1.6,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.pink.withValues(alpha: selected ? 0.20 : 0.07),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.pinkDark : AppColors.textPrimary)),
      ),
    );
  }
}
