import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final int minQuantity;
  final int maxQuantity;
  final ValueChanged<int> onChanged;

  const QuantitySelector({
    super.key,
    required this.quantity,
    this.minQuantity = 1,
    this.maxQuantity = 99,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canDecrease = quantity > minQuantity;
    final canIncrease = quantity < maxQuantity;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Button(
            icon: Icons.remove,
            onTap: canDecrease
                ? () => onChanged(quantity - 1)
                : null,
            theme: theme,
          ),
          Container(
            width: 44.w,
            height: 40.h,
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          _Button(
            icon: Icons.add,
            onTap: canIncrease
                ? () => onChanged(quantity + 1)
                : null,
            theme: theme,
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final ThemeData theme;

  const _Button({
    required this.icon,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: isDisabled
              ? theme.colorScheme.surface.withOpacity(0.5)
              : theme.colorScheme.primaryContainer.withOpacity(0.2),
          borderRadius: BorderRadius.horizontal(
            left: icon == Icons.remove ? Radius.circular(9.r) : Radius.zero,
            right: icon == Icons.add ? Radius.circular(9.r) : Radius.zero,
          ),
        ),
        child: Icon(
          icon,
          size: 18.w,
          color: isDisabled
              ? theme.colorScheme.onSurface.withOpacity(0.2)
              : theme.colorScheme.primary,
        ),
      ),
    );
  }
}
