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
  final double? radius;
  final bool textFieldStyle;

  const CommonDropdown({super.key, required this.items, required this.value, required this.onChanged, this.itemLabel, this.itemIcon, this.itemColor, this.icon, this.hint = 'Select', this.height, this.radius, this.textFieldStyle = false});

  @override
  Widget build(BuildContext context) {
    final blue = AppColor.blue(context);
    final selected = items.contains(value) ? value : null;
    final fieldColor = Theme.of(context).highlightColor;
    final border = textFieldStyle ? Border.all(color: fieldColor, width: 0.1) : Border.all(color: AppColor.border(context), width: 0.5);
    final headerPadding = EdgeInsets.symmetric(horizontal: textFieldStyle ? Dimensions.w_10 : Dimensions.w_8, vertical: textFieldStyle ? 0 : Dimensions.h_8);
    Widget header(Widget child) => textFieldStyle ? SizedBox(height: height ?? kMinInteractiveDimension, child: Align(alignment: Alignment.centerLeft, child: child)) : child;
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
                color: item == null ? (textFieldStyle ? Theme.of(context).hintColor : AppColor.muted(context)) : (isSelected ? blue : fieldColor),
                fontSize: header ? FontSize.sp_11 : FontSize.sp_10,
                fontWeight: header ? (textFieldStyle ? FontWeight.w400 : FontWeight.w700) : FontWeight.w500,
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
        closedHeaderPadding: headerPadding,
        expandedHeaderPadding: headerPadding,
        listItemPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
        headerBuilder: (context, item, _) => header(row(item, header: true)),
        hintBuilder: (context, _, _) => header(row(null, header: true)),
        listItemBuilder: (context, item, isSelected, _) => row(item, header: false, isSelected: isSelected),
        decoration: CustomDropdownDecoration(
          closedFillColor: textFieldStyle ? Colors.transparent : AppColor.surface(context),
          // stays opaque: the open list draws over the page
          expandedFillColor: AppColor.surface(context),
          closedBorder: border,
          expandedBorder: border,
          closedBorderRadius: BorderRadius.circular(radius ?? Dimensions.h_10),
          expandedBorderRadius: BorderRadius.circular(radius ?? Dimensions.h_10),
          closedSuffixIcon: Icon(CupertinoIcons.chevron_down, size: Dimensions.h_10, color: blue),
          expandedSuffixIcon: Icon(CupertinoIcons.chevron_up, size: Dimensions.h_10, color: blue),
          listItemDecoration: ListItemDecoration(selectedColor: AppColor.blueSoft(context), splashColor: Colors.transparent, highlightColor: Colors.transparent),
        ),
      ),
    );
  }
}
