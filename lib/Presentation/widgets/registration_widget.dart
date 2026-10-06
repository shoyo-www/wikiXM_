import 'package:flutter/material.dart';

import '../../constants/appcolor.dart';
import '../../constants/fontsize.dart';

class RegistrationStepIndicator extends StatelessWidget {
  final int currentStep;

  const RegistrationStepIndicator({super.key, this.currentStep = 1});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStep(step: 1),
        Expanded(child: Container(height: 0.5, color: currentStep >= 2 ? AppColor.primaryGreen : Colors.grey.shade500)),
        _buildStep(step: 2),
        Expanded(child: Container(height: 0.5, color: currentStep >= 3 ? AppColor.primaryGreen : Colors.grey.shade500)),
        _buildStep(step: 3),
        Expanded(child: Container(height: 0.5, color: currentStep >= 3 ? AppColor.primaryGreen : Colors.grey.shade500)),
        _buildStep(step: 4),
      ],
    );
  }

  Widget _buildStep({required int step}) {
    final bool isActive = step <= currentStep;

    return Container(
      height: Dimensions.h_25,
      width: Dimensions.h_25,
      decoration: BoxDecoration(
        color: isActive ? AppColor.primaryGreen : AppColor.white,
        shape: BoxShape.circle,
        border: Border.all(color: isActive ? AppColor.primaryGreen : AppColor.textSecondary, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        '$step',
        style: TextStyle(color: isActive ? AppColor.white : AppColor.textPrimary, fontSize: FontSize.sp_13, fontWeight: FontWeight.w900),
      ),
    );
  }
}
