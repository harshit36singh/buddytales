import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/enums.dart';
import '../../viewmodels/story_viewmodel.dart';

/// Renders the correct UI for every [AudioPlaybackState]:
/// idle -> CTA, loading -> spinner, playing -> stop control,
/// error -> friendly message + retry.
class ReadStoryButton extends StatelessWidget {
  const ReadStoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final storyViewModel = context.watch<StoryViewModel>();

    switch (storyViewModel.audioState) {
      case AudioPlaybackState.idle:
        return _ActionButton(
          icon: Icons.volume_up_rounded,
          label: AppStrings.readStoryLabel,
          color: AppColors.accentRed,
          onTap: storyViewModel.readStory,
        );

      case AudioPlaybackState.loading:
        return const _StatusRow(
          label: AppStrings.preparingLabel,
          showSpinner: true,
        );

      case AudioPlaybackState.playing:
        return _ActionButton(
          icon: Icons.stop_rounded,
          label: AppStrings.stopLabel,
          color: AppColors.accentBlue,
          onTap: storyViewModel.stop,
        );

      case AudioPlaybackState.error:
        return Column(
          children: [
            _StatusRow(
              label: storyViewModel.errorMessage ?? AppStrings.errorLabel,
              showSpinner: false,
              isError: true,
            ),
            const SizedBox(height: 12),
            _ActionButton(
              icon: Icons.refresh_rounded,
              label: AppStrings.retryLabel,
              color: AppColors.accentRed,
              onTap: storyViewModel.retry,
            ),
          ],
        );
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: AppColors.onAccent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.onAccent),
            const SizedBox(width: 10),
            Text(label, style: AppTextStyles.buttonLabel),
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.label,
    required this.showSpinner,
    this.isError = false,
  });

  final String label;
  final bool showSpinner;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final color = isError ? AppColors.accentRed : AppColors.textSecondary;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showSpinner) ...[
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: AppColors.accentRed,
              ),
            ),
            const SizedBox(width: 10),
          ] else if (isError) ...[
            Icon(Icons.error_outline_rounded, size: 18, color: color),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.statusText.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
