import 'package:startup_repo/core/utils/app_padding.dart';
import 'package:startup_repo/core/utils/app_radius.dart';
import 'package:startup_repo/core/utils/app_size.dart';
import 'package:startup_repo/imports.dart';

class SettingsThemeSheet extends StatelessWidget {
  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onSelect;

  const SettingsThemeSheet({
    super.key,
    required this.currentTheme,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.padding16,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: AppRadius.top(AppRadius.radius24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.sp,
            height: 4.sp,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: AppRadius.circular4,
            ),
          ),
          SizedBox(height: AppSize.s16),
          Text('select_theme'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: AppSize.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ThemeChoice(
                label: 'system',
                icon: Iconsax.monitor_mobbile,
                selected: currentTheme == ThemeMode.system,
                onTap: () => onSelect(ThemeMode.system),
              ),
              _ThemeChoice(
                label: 'light',
                icon: Iconsax.sun_1,
                selected: currentTheme == ThemeMode.light,
                onTap: () => onSelect(ThemeMode.light),
              ),
              _ThemeChoice(
                label: 'dark',
                icon: Iconsax.moon,
                selected: currentTheme == ThemeMode.dark,
                onTap: () => onSelect(ThemeMode.dark),
              ),
            ],
          ),
          SizedBox(height: AppSize.s16),
        ],
      ),
    );
  }
}

class _ThemeChoice extends StatelessWidget {
  final String label;
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  const _ThemeChoice({
    required this.label,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: selected ? primaryColor : Theme.of(context).hintColor),
            ),
            child: Icon(
              icon,
              color: selected ? primaryColor : Theme.of(context).iconTheme.color,
              size: 20.sp,
            ),
          ),
          SizedBox(height: AppSize.s8),
          Text(label.tr, style: context.font12),
        ],
      ),
    );
  }
}


