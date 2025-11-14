import 'package:startup_repo/core/utils/app_size.dart';
import 'package:startup_repo/core/utils/design_system.dart';
import 'package:startup_repo/features/home/presentation/view/home.dart';
import 'package:startup_repo/features/onboarding/presentation/view/onboarding_screen.dart';
import 'package:startup_repo/features/splash/presentation/controller/splash_controller.dart';
import '../../../../imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeSplash();
  }

  void _initializeSplash() async {
    try {
      // Initialize shared data and fetch config
      SplashController.find.initSharedData();
      
      // Wait a bit for smooth user experience and allow config to load
      await Future.delayed(const Duration(seconds: 2));
      
      // Navigate based on first-time flag
      if (mounted) {
        final bool isFirst = SplashController.find.isFirstTime;
        if (isFirst) {
          Get.off(() => const OnboardingScreen());
        } else {
          Get.off(() => const HomeScreen());
        }
      }
    } catch (e) {
      // If initialization fails, still navigate to home after delay
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Get.off(() => const HomeScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GetBuilder<SplashController>(
        builder: (controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  Images.logo,
                  width: 120.sp,
                  height: 120.sp,
                ),
                SizedBox(height: AppSize.s32),
                // App name
                Text(
                  AppConstants.appName,
                  style: context.font24.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

