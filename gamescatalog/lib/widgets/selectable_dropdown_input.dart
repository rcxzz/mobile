import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

class SelectableDropdownInput extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const SelectableDropdownInput({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: items.contains(value) ? value : null,
            validator: validator,
            dropdownColor: AppColors.cardSurface,
            style: const TextStyle(fontSize: 18, color: Colors.white),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.accentSecondary,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                fontSize: 16,
              ),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}