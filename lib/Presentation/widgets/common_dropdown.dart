import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';

class CommonDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T> onChanged;
  final String Function(T item)? itemLabel;
  final IconData? Function(T item)? itemIcon;
  final Color? Function(T item)? itemColor;
  final IconData? icon;
  final String hint;
  final double? height;

  const CommonDropdown({super.key, required this.items, required this.value, required this.onChanged, this.itemLabel, this.itemIcon, this.itemColor, this.icon, this.hint = 'Select', this.height});

  @override
  Widget build(BuildContext context) {
    final blue = AppColor.blue(context);
    final ink = AppColor.ink(context);
    final selected = items.contains(value) ? value : null;
    String label(T item) => itemLabel?.call(item) ?? item.toString();

    Widget row(T? item, {required bool header, bool isSelected = false}) {
      final leading = item == null ? icon : itemIcon?.call(item) ?? (header ? icon : null);
      return Row(
        children: [
          if (leading != null) ...[Icon(leading, size: Dimensions.h_13, color: (item == null ? null : itemColor?.call(item)) ?? blue), SizedBox(width: Dimensions.w_8)],
          Expanded(
            child: Text(
              item == null ? hint : label(item),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: item == null ? AppColor.muted(context) : (isSelected ? blue : ink),
                fontSize: header ? FontSize.sp_11 : FontSize.sp_10,
                fontWeight: header ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: height ?? Dimensions.h_35,
      child: DropdownFlutter<T>(
        // Rebuild when value changes outside the dropdown (e.g. restore defaults); initialItem is only read once.
        key: ValueKey(selected),
        items: items,
        initialItem: selected,
        hintText: hint,
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
        closedHeaderPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
        expandedHeaderPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
        listItemPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
        headerBuilder: (context, item, _) => row(item, header: true),
        hintBuilder: (context, _, _) => row(null, header: true),
        listItemBuilder: (context, item, isSelected, _) => row(item, header: false, isSelected: isSelected),
        decoration: CustomDropdownDecoration(
          closedFillColor: AppColor.surface(context),
          expandedFillColor: AppColor.surface(context),
          closedBorder: Border.all(color: AppColor.border(context), width: 0.5),
          expandedBorder: Border.all(color: AppColor.border(context), width: 0.5),
          closedBorderRadius: BorderRadius.circular(Dimensions.h_10),
          expandedBorderRadius: BorderRadius.circular(Dimensions.h_10),
          closedSuffixIcon: Icon(CupertinoIcons.chevron_down, size: Dimensions.h_10, color: blue),
          expandedSuffixIcon: Icon(CupertinoIcons.chevron_up, size: Dimensions.h_10, color: blue),
          listItemDecoration: ListItemDecoration(selectedColor: AppColor.blueSoft(context), splashColor: Colors.transparent, highlightColor: Colors.transparent),
        ),
      ),
    );
  }
}
