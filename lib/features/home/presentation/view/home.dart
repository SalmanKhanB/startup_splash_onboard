import 'package:startup_repo/core/utils/app_padding.dart';
import 'package:startup_repo/core/utils/design_system.dart';
import 'package:startup_repo/features/theme/presentation/controller/theme_controller.dart';
import 'package:startup_repo/core/widgets/confirmation_dialog.dart';
import 'package:startup_repo/core/widgets/confirmation_sheet.dart';
import '../../../../imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'.tr)),
      body: ListView(
        padding: AppPadding.padding16,
        children: [
          Column(
            children: <Widget>[
              Text('w100'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w100)),
              Text('w200'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w200)),
              Text('w300'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w300)),
              Text('w400'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w400)),
              Text('w500'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w500)),
              Text('w600'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w600)),
              Text('w700'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w700)),
              Text('w800'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w800)),
              Text('w900'.tr, style: context.font18.copyWith(fontWeight: FontWeight.w900)),
            ],
          ),
          SizedBox(height: AppSize.s32),
          Row(
            children: [
              Expanded(
                child: PrimaryOutlineButton(
                  text: 'outline_button'.tr,
                  icon: Icon(Iconsax.video, size: 16.sp, color: primaryColor),
                  onPressed: () {
                    showConfirmationSheet(
                      title: 'are_you_sure'.tr,
                      subtitle: 'action_cannot_be_undone'.tr,
                      actionText: 'yes'.tr,
                      onAccept: pop,
                    );
                  },
                ),
              ),
              SizedBox(width: AppSize.s16),
              Expanded(
                child: PrimaryButton(
                  text: 'primary_button',
                  icon: Icon(Iconsax.video, size: 16.sp, color: whiteColor),
                  onPressed: () {
                    showConfirmationDialog(
                      title: 'are_you_sure'.tr,
                      subtitle: 'action_cannot_be_undone'.tr,
                      actionText: 'yes'.tr,
                      onAccept: pop,
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s32),
          GetBuilder<ThemeController>(builder: (con) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ThemeModeWidget(
                  text: 'system',
                  themeMode: ThemeMode.system,
                  selected: con.themeMode == ThemeMode.system,
                ),
                ThemeModeWidget(
                  text: 'light',
                  themeMode: ThemeMode.light,
                  selected: con.themeMode == ThemeMode.light,
                ),
                ThemeModeWidget(
                  text: 'dark',
                  themeMode: ThemeMode.dark,
                  selected: con.themeMode == ThemeMode.dark,
                ),
              ],
            );
          }),
          SizedBox(height: AppSize.s32),
          const CustomTextField(hintText: 'enter_text', prefixIcon: Iconsax.search_normal),
          SizedBox(height: AppSize.s16),
          CustomDropDown(
            hintText: 'dropdown'.tr,
            items: [
              DropdownMenuItem(
                value: 'item_1',
                child: Text('item_1'.tr),
              ),
              DropdownMenuItem(
                value: 'item_2',
                child: Text('item_2'.tr),
              ),
              DropdownMenuItem(
                value: 'item_3',
                child: Text('item_3'.tr),
              ),
            ],
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}

class ThemeModeWidget extends StatelessWidget {
  final String text;
  final ThemeMode themeMode;
  final bool selected;
  const ThemeModeWidget({required this.text, required this.themeMode, required this.selected, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ThemeController.find.setThemeMode(themeMode),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 60.sp,
            height: 60.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? primaryColor : Theme.of(context).hintColor,
                width: 1.5.sp,
              ),
            ),
            child: Icon(icon, size: 18.sp),
          ),
          SizedBox(height: AppSize.s8),
          Text(text.tr, style: context.font12),
        ],
      ),
    );
  }

  IconData get icon {
    switch (themeMode) {
      case ThemeMode.system:
        return Iconsax.monitor_mobbile;
      case ThemeMode.light:
        return Iconsax.sun_1;
      case ThemeMode.dark:
        return Iconsax.moon;
    }
  }
}
