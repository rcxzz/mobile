import 'dart:typed_data';
import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

class GameCoverBanner extends StatelessWidget {
  final String label;
  final Uint8List? imageBytes;
  final double height;

  const GameCoverBanner({
    super.key,
    required this.label,
    this.imageBytes,
    this.height = 170,
  });

  @override
  Widget build(BuildContext context) {
    if (imageBytes != null) {
      return Image.memory(
        imageBytes!,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentPrimary.withValues(alpha: 0.28),
            AppColors.inputFill,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sports_esports_rounded,
            size: 52,
            color: AppColors.accentSecondary,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}