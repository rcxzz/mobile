import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          image: DecorationImage(
            image: const AssetImage(AppAssets.background),
            fit: BoxFit.cover,
            onError: (_, _) {},
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}