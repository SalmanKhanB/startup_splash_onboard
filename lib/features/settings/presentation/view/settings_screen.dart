import 'package:startup_repo/core/utils/app_padding.dart';
import 'package:startup_repo/core/utils/app_radius.dart';
import 'package:startup_repo/core/utils/app_size.dart';
import 'package:startup_repo/features/settings/presentation/controller/settings_controller.dart';
import 'package:startup_repo/features/settings/domain/binding/settings_binding.dart';
import '../../../../imports.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure binding is initialized
    if (!Get.isRegistered<SettingsController>()) {
      SettingsBinding().dependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) {
        final List<_SettingsOption> options = [
          _SettingsOption(icon: Iconsax.language_circle, title: 'language', onTap: controller.openLanguage),
          _SettingsOption(icon: Iconsax.sun_1, title: 'theme', onTap: controller.openThemeSelector),
          _SettingsOption(icon: Iconsax.shield_tick, title: 'privacy_policy', onTap: controller.openPrivacyPolicy),
          _SettingsOption(icon: Iconsax.document_text, title: 'terms_conditions', onTap: controller.openTerms),
          _SettingsOption(icon: Iconsax.share, title: 'share_app', onTap: controller.shareApp),
          _SettingsOption(icon: Iconsax.star, title: 'rate_app', onTap: controller.rateApp),
        ];

        return Scaffold(
          appBar: AppBar(title: Text('settings'.tr)),
          body: Padding(
            padding: AppPadding.padding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('settings'.tr, style: context.font20.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: AppSize.s12),
                Text(
                  'settings_description'.tr,
                  style: context.font14.copyWith(color: Theme.of(context).hintColor),
                ),
                SizedBox(height: AppSize.s24),
                Expanded(
                  child: ListView.separated(
                    itemCount: options.length,
                    separatorBuilder: (_, __) => Divider(height: AppSize.s16),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: AppRadius.circular12,
                          ),
                          child: Icon(option.icon, color: Theme.of(context).iconTheme.color, size: 20.sp),
                        ),
                        title: Text(option.title.tr, style: context.font16),
                        trailing: Icon(Iconsax.arrow_right_3, size: 16.sp, color: Theme.of(context).hintColor),
                        onTap: option.onTap,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SettingsOption {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  _SettingsOption({required this.icon, required this.title, required this.onTap});
}

