import 'package:flutter/material.dart';

import '../../constants/appcolor.dart';
import '../../constants/fontsize.dart';

class OtpInputField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  const OtpInputField({super.key, this.onChanged, this.onCompleted});

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  String get otpCode => controllers.map((e) => e.text).join();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: Dimensions.h_40,
          height: Dimensions.h_40,
          child: TextFormField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textInputAction: index == 5 ? TextInputAction.done : TextInputAction.next,
            textAlign: TextAlign.center,
            maxLength: 1,
            cursorColor: AppColor.primaryNavyNew,
            style: TextStyle(color: AppColor.primaryNavyNew, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              counterText: '',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h_10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.borderDivider, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.primaryNavyNew, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.error, width: 1),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                focusNodes[index + 1].requestFocus();
              }

              if (value.isEmpty && index > 0) {
                focusNodes[index - 1].requestFocus();
              }

              final otp = otpCode;

              widget.onChanged?.call(otp);

              if (otp.length == 6) {
                widget.onCompleted?.call(otp);
                FocusScope.of(context).unfocus();
              }
            },
          ),
        );
      }),
    );
  }
}
