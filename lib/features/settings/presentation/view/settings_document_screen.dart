import 'package:startup_repo/core/utils/app_padding.dart';
import '../../../../imports.dart';

class SettingsDocumentScreen extends StatelessWidget {
  final String titleKey;
  final String content;

  const SettingsDocumentScreen({super.key, required this.titleKey, required this.content});

  @override
  Widget build(BuildContext context) {
    final text = content.isNotEmpty ? content : 'document_empty'.tr;
    return Scaffold(
      appBar: AppBar(title: Text(titleKey.tr)),
      body: SingleChildScrollView(
        padding: AppPadding.padding16,
        child: Text(
          text,
          style: context.font14,
        ),
      ),
    );
  }
}


