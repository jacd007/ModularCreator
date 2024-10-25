import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? desktopScreen;
  final Widget? mobileScreen;

  const ResponsiveWidget({
    super.key,
    this.desktopScreen,
    this.mobileScreen,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 600) {
      return desktopScreen ?? mobileScreen ?? const SizedBox();
    }

    return mobileScreen ?? desktopScreen ?? const SizedBox();
  }
}

//
class RowDesktopPage extends StatelessWidget {
  final Widget widgetMenu;
  final Widget widgetContent;
  final Widget? widgetSpacer;
  final double? maxWidth;
  final double? maxHeight;
  final double? maxWidthMenu;
  final double? maxWidthContent;
  final bool isRepeatWidgetSpacer;

  const RowDesktopPage({
    required this.widgetMenu,
    required this.widgetContent,
    this.widgetSpacer,
    this.isRepeatWidgetSpacer = true,
    this.maxWidth,
    this.maxHeight,
    this.maxWidthMenu,
    this.maxWidthContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      height: maxHeight,
      child: Row(
        children: [
          // Menu widget
          SizedBox(width: maxWidthMenu, child: widgetMenu),
          // separate widget
          const VerticalDivider(width: 1, thickness: 1),
          // Expanded Widget 1/3
          if (widgetSpacer != null && isRepeatWidgetSpacer) widgetSpacer!,
          // Content (widget center)
          SizedBox(width: maxWidthContent, child: widgetContent),
          // Expanded Widget 1/3
          if (widgetSpacer != null) widgetSpacer!,
        ],
      ),
    );
  }
}

// ========

/* class ResponsiveWidget extends StatelessWidget {
  final Widget? desktopScreen;
  //final Widget? tabletScreen;
  final Widget? mobileScreen;
  //final Widget? replyWidget;
  //final bool hasTabletAndDesktop;

  const ResponsiveWidget({
    Key? key,
    this.desktopScreen,
    //this.tabletScreen,
    this.mobileScreen,
    //this.replyWidget,
    //this.hasTabletAndDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    /* if (replyWidget != null) return replyWidget!;
    if (hasTabletAndDesktop) {
      return tabletScreen ?? desktopScreen ?? mobileScreen!;
    } */

    if (screenWidth > 950) {
      return desktopScreen /* ?? tabletScreen */ ?? mobileScreen!;
    }
    if (screenWidth > 600) {
      return /* tabletScreen ?? */ mobileScreen ?? desktopScreen!;
    }

    return mobileScreen /* ?? tabletScreen */ ?? desktopScreen!;
  }
} */
