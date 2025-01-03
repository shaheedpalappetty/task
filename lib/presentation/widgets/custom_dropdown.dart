import 'package:task_assignment/core/utils/imports.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final String labelText;
  final List<T> items;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final double? borderRadius;
  final Color? dropdownColor;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.labelText,
    required this.items,
    required this.getLabel,
    required this.onChanged,
    this.validator,
    this.textStyle,
    this.labelStyle,
    this.fillColor,
    this.borderRadius,
    this.dropdownColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
      ),
      dropdownColor: dropdownColor,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            getLabel(item),
            style: textStyle ?? const TextStyle(color: AppColors.white),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
