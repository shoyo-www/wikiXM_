import 'package:flutter/material.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';

typedef CategoryTab = ({String title, String subtitle, IconData icon, Color color});

/// Horizontal row of tabs that scrolls the selected one to the center. The first and last
/// stay at their edges because the scroll is clamped to the row's ends.
class CenteredTabRow extends StatefulWidget {
  const CenteredTabRow({super.key, required this.count, required this.selected, required this.itemBuilder, this.spacing});

  final int count;
  final int selected;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double? spacing;

  @override
  State<CenteredTabRow> createState() => _CenteredTabRowState();
}

class _CenteredTabRowState extends State<CenteredTabRow> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey _rowKey = GlobalKey();
  List<GlobalKey> _keys = [];

  @override
  void initState() {
    super.initState();
    _keys = List.generate(widget.count, (_) => GlobalKey());
    _center(animate: false);
  }

  @override
  void didUpdateWidget(CenteredTabRow old) {
    super.didUpdateWidget(old);
    if (widget.count != _keys.length) _keys = List.generate(widget.count, (_) => GlobalKey());
    if (widget.selected != old.selected || widget.count != old.count) _center();
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  // Scrollable.ensureVisible would also scroll the page vertically, so this scrolls only the row
  void _center({bool animate = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients || widget.selected < 0 || widget.selected >= _keys.length) return;
      final tab = _keys[widget.selected].currentContext?.findRenderObject() as RenderBox?;
      final row = _rowKey.currentContext?.findRenderObject() as RenderBox?;
      if (tab == null || row == null) return;
      final position = _scroll.position;
      final tabCenter = tab.localToGlobal(Offset(tab.size.width / 2, 0), ancestor: row).dx;
      final target = (tabCenter - position.viewportDimension / 2).clamp(0.0, position.maxScrollExtent);
      animate ? _scroll.animateTo(target, duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic) : _scroll.jumpTo(target);
    });
  }

  @override
  Widget build(BuildContext context) {
    // a Row, not a lazy ListView, so every tab has a size to center on
    return SingleChildScrollView(
      controller: _scroll,
      scrollDirection: Axis.horizontal,
      child: Row(
        key: _rowKey,
        children: [
          for (var i = 0; i < widget.count; i++) ...[
            if (i > 0) SizedBox(width: widget.spacing ?? Dimensions.w_6),
            KeyedSubtree(key: _keys[i], child: widget.itemBuilder(context, i)),
          ],
        ],
      ),
    );
  }
}

/// Category chips: icon, title and count.
class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key, required this.tabs, required this.selected, required this.onTap});

  final List<CategoryTab> tabs;
  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final blue = AppColor.blue(context);
    final ink = Theme.of(context).highlightColor;
    return SizedBox(
      height: Dimensions.h_30,
      child: CenteredTabRow(
        count: tabs.length,
        selected: selected,
        spacing: Dimensions.w_10,
        itemBuilder: (context, i) {
          final tab = tabs[i];
          final isSelected = i == selected;
          return Semantics(
            button: true,
            selected: isSelected,
            child: GestureDetector(
              onTap: () => onTap(i),
              child: Container(
                height: Dimensions.h_30,
                padding: EdgeInsets.fromLTRB(Dimensions.w_5, 0, Dimensions.w_12, 0),
                decoration: BoxDecoration(
                  color: isSelected ? blue : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: Border.all(color: isSelected ? blue : AppColor.border(context)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimensions.h_3),
                      decoration: BoxDecoration(color: isSelected ? AppColor.white.withValues(alpha: 0.2) : tab.color.withValues(alpha: 0.12), shape: BoxShape.circle),
                      child: Icon(tab.icon, size: Dimensions.h_12, color: isSelected ? AppColor.white : tab.color),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tab.title,
                          style: TextStyle(color: isSelected ? AppColor.white : ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          tab.subtitle,
                          style: TextStyle(color: isSelected ? AppColor.white : ink, fontSize: FontSize.sp_8_5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Text-only pill tabs.
class PillTabs extends StatelessWidget {
  const PillTabs({super.key, required this.tabs, required this.selected, required this.onTap});

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return CenteredTabRow(
      count: tabs.length,
      selected: selected,
      itemBuilder: (context, i) => Semantics(
        button: true,
        selected: i == selected,
        child: GestureDetector(
          onTap: () => onTap(i),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_5),
            // the selected tab gets a matching border so tabs keep the same size when switching
            decoration: BoxDecoration(
              color: i == selected ? AppColor.blue(context) : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.h_6),
              border: Border.all(color: i == selected ? AppColor.blue(context) : AppColor.border(context), width: 0.5),
            ),
            child: Text(
              tabs[i],
              style: TextStyle(color: i == selected ? AppColor.surface(context) : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
