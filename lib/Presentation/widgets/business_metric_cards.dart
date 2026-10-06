import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FaIconData, FaIcon;
import '../../constants/fontsize.dart';

class BusinessMetricCard extends StatelessWidget {
  final dynamic icon;
  final String value;
  final String title;
  final Color iconColor;
  final double? iconSize;

  const BusinessMetricCard({super.key, required this.icon, required this.value, required this.title, this.iconColor = const Color(0xFF0b6030), this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3, vertical: Dimensions.h_2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500, width: 0.3),
        borderRadius: BorderRadius.circular(Dimensions.h_6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIcon(),
          SizedBox(height: Dimensions.h_4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_15, fontWeight: FontWeight.w700, height: 1.05),
          ),
          SizedBox(height: Dimensions.h_4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1.05),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (icon is FaIconData) {
      return FaIcon(icon, color: iconColor, size: iconSize ?? Dimensions.h_22);
    }
    return Icon(icon as IconData, color: iconColor, size: iconSize ?? Dimensions.h_22);
  }
}
