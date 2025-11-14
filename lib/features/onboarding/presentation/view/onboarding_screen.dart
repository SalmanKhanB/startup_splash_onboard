import 'package:startup_repo/core/utils/app_padding.dart';
import 'package:startup_repo/core/utils/app_size.dart';
import 'package:startup_repo/core/utils/design_system.dart';
import '../controller/onboarding_controller.dart';
import '../../../../imports.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              // Swipable content (image, title, description)
              PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _OnboardingPage(
                    pageIndex: index,
                    controller: controller,
                  );
                },
              ),
              // Skip button (only on pages 0 and 1, not on last view)
              if (controller.currentPage < 2)
                Positioned(
                  top: MediaQuery.of(context).padding.top + AppSize.s16,
                  left: AppSize.s16,
                  child: GestureDetector(
                    onTap: controller.skipOnboarding,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                        color: transparent,
                        borderRadius: BorderRadius.circular(24.sp),
                        border: Border.all(
                          color: whiteColor.withOpacity(0.2),
                          width: 0.5.sp,
                        ),
                        boxShadow: [
                          // Subtle shadow outside the border - cast downwards and to the right
                          BoxShadow(
                            color: blackColor.withOpacity(0.2),
                            blurRadius: 8.sp,
                            spreadRadius: 0,
                            offset: Offset(2.sp, 2.sp),
                          ),
                          // Very subtle perimeter shadow
                          BoxShadow(
                            color: blackColor.withOpacity(0.15),
                            blurRadius: 12.sp,
                            spreadRadius: 0,
                            offset: Offset(0, 1.sp),
                          ),
                        ],
                      ),
                      child: Text(
                        'skip'.tr,
                        style: context.font14.copyWith(
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              // Fixed bottom section (dots and button)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Pagination dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => _PaginationDot(
                            isActive: index == controller.currentPage,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s32),
                      // Action button
                      Padding(
                        padding: AppPadding.padding16,
                        child: SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: controller.currentPage == 2 ? 'continue'.tr : 'next'.tr,
                            onPressed: controller.nextPage,
                            icon: controller.currentPage == 2
                                ? null
                                : Icon(
                                    Iconsax.arrow_right_3,
                                    size: 16.sp,
                                    color: whiteColor,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final int pageIndex;
  final OnboardingController controller;

  const _OnboardingPage({
    required this.pageIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final onboardingData = _getOnboardingData(pageIndex);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(onboardingData['image'] as String),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              transparent,
              transparent,
              blackColor.withOpacity(0.7),
              blackColor.withOpacity(0.9),
            ],
            stops: const [0.0, 0.4, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              // Title
              Padding(
                padding: AppPadding.horizontal(32),
                child: Text(
                  onboardingData['title'] as String,
                  style: context.font24.copyWith(
                    fontWeight: FontWeight.w700,
                    color: whiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSize.s16),
              // Description
              Padding(
                padding: AppPadding.horizontal(32),
                child: Text(
                  onboardingData['description'] as String,
                  style: context.font16.copyWith(
                    color: whiteColor.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Fixed spacing to position above dots (dots are at bottom)
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getOnboardingData(int index) {
    switch (index) {
      case 0:
        return {
          'image': 'assets/images/s1.png',
          'title': 'onboarding_title_1'.tr,
          'description': 'onboarding_description_1'.tr,
        };
      case 1:
        return {
          'image': 'assets/images/s2.png',
          'title': 'onboarding_title_2'.tr,
          'description': 'onboarding_description_2'.tr,
        };
      case 2:
        return {
          'image': 'assets/images/s3.png',
          'title': 'onboarding_title_3'.tr,
          'description': 'onboarding_description_3'.tr,
        };
      default:
        return {
          'image': 'assets/images/s1.png',
          'title': '',
          'description': '',
        };
    }
  }
}

class _PaginationDot extends StatelessWidget {
  final bool isActive;

  const _PaginationDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.sp),
      width: isActive ? 24.sp : 8.sp,
      height: 8.sp,
      decoration: BoxDecoration(
        color: isActive ? whiteColor : whiteColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4.sp),
      ),
    );
  }
}

