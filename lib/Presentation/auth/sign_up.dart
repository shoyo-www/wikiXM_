import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/fontsize.dart';
import 'package:wikixm/constants/images.dart';
import '../../data/datasource/remote/models/response/search_town_response.dart';
import '../../constants/appcolor.dart';
import '../widgets/otp_field.dart';
import '../widgets/registration_widget.dart';
import '../widgets/social_button.dart';
import 'auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    return AppScaffold(
      body: Obx(
        () => Column(
          children: [
            if (controller.currentStep.value == 1)
              Center(
                child: Image.asset(Images.appLogoGif, height: Dimensions.h_50),
              ),
            SizedBox(height: Dimensions.h_20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20),
              child: RegistrationStepIndicator(
                currentStep: controller.currentStep.value,
              ),
            ),
            SizedBox(height: Dimensions.h_15),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                child: buildStepContent(controller),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepContent(AuthController controller) {
    switch (controller.currentStep.value) {
      case 1:
        return buildFirstStep(controller);

      case 2:
        return buildVerificationStep(controller);

      case 3:
        return buildCommunityStep(controller);

      case 4:
        return buildPersonalizeStep(controller);

      default:
        return const SizedBox();
    }
  }

  Widget buildVerificationStep(AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Verify Your Email',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryNavyNew,
              fontSize: FontSize.sp_18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_4),
        Center(
          child: Text(
            "We've sent a 6-digit verification code to",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_2),
        Center(
          child: Text(
            controller.registerData?.identifier ?? '',
            style: TextStyle(
              color: AppColor.textPrimary,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        SizedBox(height: Dimensions.h_18),
        Text(
          'Verification Code',
          style: TextStyle(
            color: AppColor.primaryNavyNew,
            fontSize: FontSize.sp_12,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: Dimensions.h_6),
        OtpInputField(
          onChanged: (value) {
            controller.otp.value = value;
          },
        ),
        SizedBox(height: Dimensions.h_7),
        Obx(
          () => Row(
            children: [
              Text(
                controller.canResend.value
                    ? 'Request a new code to continue.'
                    : 'Code expires in ',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: FontSize.sp_10,
                  fontWeight: controller.canResend.value
                      ? FontWeight.w400
                      : FontWeight.w500,
                ),
              ),
              if (!controller.canResend.value)
                Text(
                  controller.formattedTime,
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const Spacer(),
              GestureDetector(
                onTap: controller.canResend.value ? controller.resendOtp : null,
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                    color: controller.canResend.value
                        ? AppColor.darkBlue
                        : Colors.grey,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: controller.previousStep,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.h_6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                      border: Border.all(
                        color: AppColor.borderDivider,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '<- Back',
                        style: TextStyle(
                          color: AppColor.primaryNavyNew,
                          fontSize: FontSize.sp_13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_30),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: controller.isLoading.value
                      ? null
                      : controller.verifyOtp,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.h_6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryNavyNew,
                      borderRadius: BorderRadius.circular(
                        Dimensions.h_8,
                      ),
                    ),
                    child: Obx(
                          () => controller.isLoading.value
                          ? CupertinoActivityIndicator(
                        color: Colors.white,
                        radius: Dimensions.h_8,
                      )
                          : Center(
                        child: Text(
                          'Verify & Continue ->',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_30),
      ],
    );
  }

  Widget buildFirstStep(AuthController controller) {
    return Column(
      children: [
        Image.asset(Images.communityImage, scale: 8),
        SizedBox(height: Dimensions.h_10),
        Text(
          "Create Your Account",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.primaryNavyNew,
            fontSize: FontSize.sp_20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          "Takes about 30 seconds.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.primaryNavyNew,
            fontSize: FontSize.sp_11,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Dimensions.h_25),
        Obx(
          () => buildAuthField(
            icon: Images.person,
            title: 'Full Name',
            textController: controller.fullName,
            errorText: controller.fullNameError.value,
          ),
        ),
        SizedBox(height: Dimensions.h_8),
        Obx(
          () => buildAuthField(
            icon: Images.email,
            title: 'Email Address',
            textController: controller.email,
            isIcon: true,
            errorText: controller.emailError.value,
          ),
        ),
        SizedBox(height: Dimensions.h_8),
        Obx(
          () => buildAuthField(
            icon: Images.lock,
            isPassword: true,
            title: 'Password',
            onChanged: (e) {
              controller.passwordValue.value = e;
            },
            textController: controller.password,
            obscureText: controller.isVisible.value,
            errorText: controller.passwordError.value,
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: Dimensions.w_8),
              child: GestureDetector(
                onTap: () => controller.isVisible.toggle(),
                child: controller.isVisible.value
                    ? Icon(
                        CupertinoIcons.eye_slash,
                        size: Dimensions.h_15,
                        color: AppColor.primaryNavyNew,
                      )
                    : AppCacheImage(
                        isShadow: false,
                        imageUrl: Images.eye,
                        fit: BoxFit.contain,
                        size: Dimensions.h_10,
                        widthSize: Dimensions.h_15,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        Obx(() {
          final password = controller.passwordValue.value;
          final hasLength = password.length >= 8;
          final hasNumber = RegExp(r'[0-9]').hasMatch(password);
          final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
          return Column(
            children: [
              _passwordRule(text: "At least 8 characters", isValid: hasLength),
              _passwordRule(text: "Include a number", isValid: hasNumber),
              _passwordRule(
                text: "Include an uppercase letter",
                isValid: hasUpper,
              ),
            ],
          );
        }),
        SizedBox(height: Dimensions.h_15),
        GestureDetector(
          onTap: () {
            if (!controller.validateCreateAccount()) return;
            controller.register();
          },
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_1,
              vertical: Dimensions.h_8,
            ),
            decoration: BoxDecoration(
              color: AppColor.primaryNavyNew,
              borderRadius: BorderRadius.circular(Dimensions.h_10),
            ),
            child: Obx(
              () => controller.isLoading.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_3),
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                        radius: Dimensions.h_7,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: Dimensions.w_50),
                        Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSize.sp_14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.w_20),
                          child: Icon(
                            Icons.arrow_forward,
                            size: Dimensions.h_15,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_15),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: Dimensions.w_5),
                height: 0.5,
                color: Colors.grey,
              ),
            ),
            Text(
              "or continue with",
              style: TextStyle(
                color: AppColor.primaryNavyNew,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.w_5),
                height: 0.5,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_15),
        SocialLoginButtons(isCreateAccount: true),
        SizedBox(height: Dimensions.h_30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: TextStyle(
                color: AppColor.primaryNavyNew,
                fontSize: FontSize.sp_12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: Dimensions.w_4),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.back(),
              child: Text(
                'Sign in',
                style: TextStyle(
                  color: AppColor.accentBlue,
                  fontSize: FontSize.sp_12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _passwordRule({required String text, required bool isValid}) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.w_30),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check : Icons.close,
            color: isValid ? AppColor.primaryGreen : Colors.red,
            size: Dimensions.h_15,
          ),
          SizedBox(width: Dimensions.w_5),
          Text(
            text,
            style: TextStyle(
              color: AppColor.primaryNavyNew,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommunityStep(AuthController controller) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(Images.secondStep, scale: 8)),
              Center(
                child: Text(
                  "Choose Your Communities",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primaryNavyNew,
                    fontSize: FontSize.sp_20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_4),
              Center(
                child: Text(
                  "Choose your home community and",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primaryNavyNew,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "follow up to 4 more communities.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primaryNavyNew,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_25),
              Obx(() {
                final hasPrimary = controller.selectedPrimaryTown.value != null;
                if (hasPrimary && controller.secondaryTowns.length >= 4) {
                  return SizedBox.shrink();
                }
                return Padding(
                  padding:  EdgeInsets.only(bottom: Dimensions.h_20),
                  child: _buildTownSearch(
                    controller: hasPrimary
                        ? controller.secondarySearchTown
                        : controller.searchTown,
                    focusNode: hasPrimary
                        ? controller.secondarySearchFocus
                        : controller.searchFocus,
                    enabled: !hasPrimary || controller.secondaryTowns.length < 4,
                    hintText: hasPrimary
                        ? 'Search for more communities...'
                        : 'Search for your primary community',
                    isLoading:
                        controller.isSearching.value &&
                        (hasPrimary
                            ? controller.showSecondarySearch.value
                            : controller.showPrimarySearch.value),
                    showResults:
                        (hasPrimary
                            ? controller.showSecondarySearch.value
                            : controller.showPrimarySearch.value) &&
                        controller.searchTownsList.isNotEmpty,
                    towns: controller.searchTownsList,
                    onChanged: (value) =>
                        controller.onSearchChanged(value, isPrimary: !hasPrimary),
                    onSelected: hasPrimary
                        ? controller.selectSecondaryTown
                        : controller.selectTown,
                  ),
                );
              }),
              _buildSectionTitle('Primary Community (Required)'),
              SizedBox(height: Dimensions.h_1),
              Obx(() {
                final town = controller.selectedPrimaryTown.value;
                if (town == null) {
                  return _buildHelperText(
                    'Search above to select your primary community.',
                  );
                }
                return Padding(
                  padding:  EdgeInsets.only(top: Dimensions.h_6),
                  child: _buildTownCard(
                    town,
                    trailing: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_6,
                            vertical: Dimensions.h_3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Home',
                            style: TextStyle(
                              color: AppColor.primaryGreen,
                              fontSize: FontSize.sp_11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.w_10),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => controller.clearPrimaryTown(),
                          child: Text('Change', style: TextStyle(
                              color: AppColor.darkBlue,
                              fontWeight: FontWeight.w900,
                              fontSize: FontSize.sp_11
                          ),),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: Dimensions.h_20),
              Obx(
                () => _buildSectionTitle(
                  'Communities You Follow (${controller.secondaryTowns.length}/4)',
                ),
              ),
              SizedBox(height: Dimensions.h_3),
              GetBuilder(
                init: controller,
                  builder: (c){
                if (controller.secondaryTowns.isEmpty) {
                  return _buildHelperText(
                    'Add more communities after selecting a primary community.',
                  );
                }
                return Padding(
                  padding:  EdgeInsets.only(top: Dimensions.h_6),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = (constraints.maxWidth - Dimensions.w_8) / 2;
                      final towns = controller.secondaryTowns.toList();
                      return Wrap(
                        spacing: Dimensions.w_8,
                        runSpacing: Dimensions.h_8,
                        children: towns
                            .map(
                              (town) => SizedBox(
                            width: itemWidth,
                            child: _buildTownCard(
                                town,
                                fontSize: FontSize.sp_11,
                                trailing: GestureDetector(
                                    onTap: ()=> controller.removeSecondaryTown(town),
                                    child: Icon(Icons.close,size: Dimensions.h_15,color: AppColor.primaryNavyNew))
                            ),
                          ),
                        ).toList(),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: Dimensions.h_8),
              Obx(() {
                final town = controller.selectedPrimaryTown.value;
          
                if (town == null) {
                  return const SizedBox.shrink();
                }
          
                return Container(
                  margin: EdgeInsets.only(top: Dimensions.h_10),
                  padding: EdgeInsets.all(Dimensions.h_6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      AppCacheImage(
                        imageUrl: town.cityImage ?? '',
                        size: Dimensions.h_60,
                        widthSize: Dimensions.h_100,
                        fit: BoxFit.cover,
                        radius: 8,
                        isShadow: false,
                        errorImage: town.cityFallbackImage ?? '',
                      ),
                      SizedBox(width: Dimensions.w_12),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${town.cityName ?? ''},${town.stateAbbreviation}",
                                  style: TextStyle(
                                    color: AppColor.primaryNavyNew,
                                    fontSize: FontSize.sp_14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStat('200', 'Stories'),
                                _buildStat('20', 'Events'),
                                _buildStat('15', 'Businesses'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: Dimensions.h_30),
            ],
          ),
        ),
        Positioned(
          bottom: Dimensions.h_30,
            left: 0,
            right: 0,
            child:    IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    controller.currentStep.value =1;
                  },
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_6),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                      border: Border.all(
                        color: AppColor.borderDivider,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '<-  Back',
                        style: TextStyle(
                          color: AppColor.primaryNavyNew,
                          fontSize: FontSize.sp_13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_30),
              Expanded(
                flex: 4,
                child: Obx(() {
                  final canContinue = controller.selectedPrimaryTown.value != null;
                  return GestureDetector(
                    onTap: canContinue ? controller.saveCities : null,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_6),
                      decoration: BoxDecoration(
                        color: canContinue
                            ? AppColor.primaryNavyNew
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(Dimensions.h_8),
                      ),
                      child: Center(
                        child: controller.isLoading.value ? CupertinoActivityIndicator(
                          radius: Dimensions.h_8,
                          color: Colors.white,
                        ):Text(
                          'Continue ->',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: FontSize.sp_14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.primaryGreen,
            fontSize: FontSize.sp_12,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.primaryNavyNew,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColor.primaryNavyNew,
        fontSize: FontSize.sp_13_5,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildHelperText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColor.primaryNavyNew.withValues(alpha: .65),
        fontSize: FontSize.sp_11,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTownSearch({
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool enabled,
    required bool isLoading,
    required bool showResults,
    required String hintText,
    required List<SearchTowns> towns,
    required ValueChanged<String> onChanged,
    required ValueChanged<SearchTowns> onSelected,
  }) {
    return Column(
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          style: TextStyle(
            color: AppColor.primaryNavyNew,
            fontSize: FontSize.sp_12,
            fontWeight: FontWeight.w500,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColor.primaryNavyNew,
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppColor.primaryNavyNew,
              size: Dimensions.h_15,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: Dimensions.w_30,
              minHeight: Dimensions.h_30,
            ),
            suffixIcon: isLoading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.w_2,
              vertical: Dimensions.h_10,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
        ),
        if (showResults)
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 220),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: towns.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  final town = towns[index];
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelected(town),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_10,
                        vertical: Dimensions.h_8,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColor.primaryNavyNew,
                            size: Dimensions.h_16,
                          ),
                          SizedBox(width: Dimensions.w_8),
                          Expanded(
                            child: Text(
                              [town.cityName, town.stateAbbreviation]
                                  .where((part) => (part ?? '').isNotEmpty)
                                  .join(', '),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: FontSize.sp_12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTownCard(SearchTowns town, {required Widget trailing,double? fontSize}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_8
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade500, width: 0.4),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: AppColor.primaryGreen,
            size: Dimensions.h_18,
          ),
          SizedBox(width: Dimensions.w_6),
          Expanded(
            child: Text(
              [
                town.cityName,
                town.stateAbbreviation,
              ].where((part) => (part ?? '').isNotEmpty).join(', '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.primaryNavyNew,
                fontSize: fontSize ?? FontSize.sp_13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget buildPersonalizeStep(AuthController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(Images.personalise, scale: 8)),
        Center(
          child: Text(
            "Personalize Your Feed",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryNavyNew,
              fontSize: FontSize.sp_20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_4),
        Center(
          child: Text(
            "Select what matters most to you.",
            style: TextStyle(
              color: AppColor.primaryNavyNew,
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Center(
          child: Text(
            "We'll keep you updated on what you love.",
            style: TextStyle(
              color: AppColor.primaryNavyNew,
              fontSize: FontSize.sp_11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_30),
        Text(
          'Select your interests',
          style: TextStyle(
            color: AppColor.primaryNavyNew,
            fontSize: FontSize.sp_12,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        Obx(() {
          final interests =
              controller.personalisationData.value?.interestOptions ?? [];

          return Wrap(
            spacing: Dimensions.w_10,
            runSpacing: Dimensions.h_10,
            children: interests.map((interest) {
              final isSelected = controller.selectedCategories.contains(interest.id);
              return GestureDetector(
                onTap: () => controller.toggleCategory(interest.id ?? 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedContainer(
                      width: Dimensions.w_100,
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_2,
                        vertical: Dimensions.h_8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xffF5FBF6)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.primaryGreen
                              : Colors.grey.shade500,
                          width: 0.4,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: Dimensions.w_6),
                          AppCacheImage(
                            imageUrl: interest.icon ?? "",
                            size: Dimensions.h_15,
                            widthSize: Dimensions.h_15,
                            fit: BoxFit.contain,
                            isShadow: false,
                          ),
                          SizedBox(width: Dimensions.w_6),
                          Expanded(
                            child: Text(
                              interest.label ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColor.primaryGreen
                                    : AppColor.primaryNavyNew,
                                fontSize: FontSize.sp_10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        top: -3,
                        right: -3,
                        child: Container(
                          width: Dimensions.h_12,
                          height: Dimensions.h_12,
                          decoration: const BoxDecoration(
                            color: AppColor.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: Dimensions.h_10,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          );
        }),
        SizedBox(height: Dimensions.h_20),
        Text(
          'How would you like updates?',
          style: TextStyle(
            color: AppColor.primaryNavyNew,
            fontSize: FontSize.sp_12,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        Obx(() {
          IconData getDeliveryIcon(String? icon) {
            switch (icon) {
              case 'bell':
                return CupertinoIcons.bell;

              case 'email':
                return Icons.email_outlined;

              case 'sms':
                return CupertinoIcons.chat_bubble_text;

              case 'push':
                return Icons.notifications_active_outlined;

              default:
                return Icons.notifications_none_outlined;
            }
          }
          final deliveryOptions =
              controller.personalisationData.value?.deliveryOptions ?? [];

          return Row(
            children: List.generate(deliveryOptions.length, (index) {
              final item = deliveryOptions[index];

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == deliveryOptions.length - 1
                        ? 0
                        : Dimensions.w_8,
                  ),
                  child: _notificationCard(
                    icon: getDeliveryIcon(item.slug),
                    title: item.label ?? '',
                    isSelected: controller.selectedNotifications.contains(item.id),
                    onTap: () => controller.toggleNotification(item.id!),
                  ),
                ),
              );
            }),
          );
        }),
        const Spacer(),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: controller.previousStep,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_6),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                      border: Border.all(
                        color: AppColor.borderDivider,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '<-  Back',
                        style: TextStyle(
                          color: AppColor.primaryNavyNew,
                          fontSize: FontSize.sp_13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_30),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: controller.completeRegistration,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_6),
                    decoration: BoxDecoration(
                      color: AppColor.primaryNavyNew,
                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                    ),
                    child: Center(
                      child: Obx(()=> controller.isLoading.value ? CupertinoActivityIndicator(
                        color: Colors.white,
                        radius: Dimensions.h_7,
                      ): Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Complete Sign Up',
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: FontSize.sp_14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: Dimensions.w_6),
                          Icon(
                            Icons.check,
                            color: AppColor.white,
                            size: Dimensions.h_18,
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_30),
      ],
    );
  }

  Widget _notificationCard({
    IconData? icon,
    String? image,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_3,
          vertical: Dimensions.h_6,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xffF5FBF6)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColor.primaryGreen
                : Colors.grey.shade400,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                if (image != null)
                  AppCacheImage(
                    imageUrl: image,
                    isShadow: false,
                    size: Dimensions.h_15,
                    widthSize: Dimensions.h_15,
                    fit: BoxFit.contain,
                  )
                else
                  Icon(
                    icon,
                    size: Dimensions.h_15,
                    color: isSelected
                        ? AppColor.primaryGreen
                        : AppColor.primaryNavyNew,
                  ),
                SizedBox(width: Dimensions.w_8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColor.primaryGreen
                          : AppColor.primaryNavyNew,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                top: -Dimensions.h_8,
                right: -Dimensions.w_6,
                child: Container(
                  width: Dimensions.h_10,
                  height: Dimensions.h_10,
                  decoration: const BoxDecoration(
                    color: AppColor.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: Dimensions.h_10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildAuthField({
    required String icon,
    required String title,
    required TextEditingController textController,
    bool obscureText = false,
    bool isIcon = false,
    Widget? suffixIcon,
    String? errorText,
    bool isPassword = false,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade500, width: 0.3),
          ),
          child: Row(
            children: [
              SizedBox(width: Dimensions.w_10),
              AppCacheImage(
                imageUrl: icon,
                size: Dimensions.h_16,
                widthSize: Dimensions.h_16,
                fit: BoxFit.contain,
                isShadow: false,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  child: TextField(
                    style: TextStyle(
                      fontSize: FontSize.sp_11,
                      color: AppColor.primaryNavyNew,
                    ),
                    controller: textController,
                    obscureText: obscureText,
                    onChanged: onChanged,
                    cursorColor: AppColor.primaryNavyNew,
                    decoration: InputDecoration(
                      suffixIconConstraints: BoxConstraints(
                        minWidth: Dimensions.h_23,
                        minHeight: Dimensions.h_18,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintText: title,
                      hintStyle: TextStyle(
                        color: AppColor.primaryNavyNew,
                        fontSize: FontSize.sp_10,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_2,
                        vertical: Dimensions.h_10,
                      ),
                      suffixIcon: suffixIcon,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null && errorText.isNotEmpty && isPassword == false)
          Padding(
            padding: EdgeInsets.only(top: Dimensions.h_4, left: Dimensions.w_5),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
