import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../common/helper.dart';

// not work yet.
class Toast {
  /// [iconColor] is icon color, change based on your warning,
  ///
  /// [iconData] is iconData, change based on your warning
  ///
  /// [durationMiliseconds] default 2500ms, change based on your warning
  static showToast({
    required String? message,
    String? detailMessage,
    Color iconColor = Colors.redAccent,
    IconData iconData = Icons.error_outline_rounded,
    int durationMiliseconds = 3000,
  }) {
    BotToast.showCustomText(
      onlyOne: true,
      duration: Duration(milliseconds: durationMiliseconds),
      toastBuilder: (textCancel) => Align(
        alignment: const Alignment(0, 0.8),
        child: GestureDetector(
          onLongPress: () async {
            await Helper.copyToClipboard(detailMessage ?? message);
            showFloatNotification(title: 'Detail Message Copied');
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        iconData,
                        color: iconColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        message ?? "-",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Show simple toast
  ///
  static showSimpleToast({
    required String message,
    int durationMiliseconds = 2500,
  }) {
    BotToast.showCustomText(
      onlyOne: true,
      duration: Duration(milliseconds: durationMiliseconds),
      toastBuilder: (textCancel) => Align(
        alignment: const Alignment(0, 0.8),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Show snackbar
  ///
  static showSnackBar(
    BuildContext context, {
    required String message,
    int durationMiliseconds = 3000,
    String actionLabel = "OK",
    Color? actionColor,
    Color? backgroundColor,
    IconData iconData = Icons.check_circle_outline_rounded,
    Color iconColor = Colors.greenAccent,
    double? heightText,
    double paddingRightIcon = 8.0,
    required void Function() onPressed,
  }) {
    final scaffold = ScaffoldMessenger.of(context);

    double verticalPadding = 20;

    backgroundColor ??= Theme.of(context).colorScheme.onSurface;

    scaffold.showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
      margin: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 16),
      content: Tooltip(
        message: message,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: paddingRightIcon),
              child: Icon(
                iconData,
                color: iconColor,
              ),
            ),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: heightText,
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: durationMiliseconds),
      action: SnackBarAction(
        label: actionLabel,
        textColor: actionColor ?? Colors.white,
        onPressed: onPressed,
      ),
    ));
  }

  /// Show snackbar
  ///
  static showErrorSnackBar(
    BuildContext context, {
    int durationMiliseconds = 3000,
    String actionLabel = "OK",
    Color? actionColor,
    Color? backgroundColor,
    IconData iconData = Icons.close,
    Color iconColor = Colors.redAccent,
    double? heightText,
    double paddingRightIcon = 8.0,
    required void Function() onPressed,
    required String message,
    List<String> messages = const [],
  }) {
    final scaffold = ScaffoldMessenger.of(context);

    double verticalPadding = 20;

    backgroundColor ??= Theme.of(context).colorScheme.onSurface;

    scaffold.showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
      margin: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 16),
      content: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: heightText,
                        fontSize: 14,
                      ),
                ),
                Visibility(
                  visible: messages.isNotEmpty,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    shrinkWrap: true,
                    itemCount: messages.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                      height: 8,
                    ),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Icon(
                            iconData,
                            size: 16,
                            color: iconColor,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              messages[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: heightText,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: durationMiliseconds),
      action: SnackBarAction(
        label: actionLabel,
        textColor: actionColor ?? Colors.white,
        onPressed: onPressed,
      ),
    ));
  }

  /// Show float Notification
  ///
  static showFloatNotification({
    required String title,
    int durationMiliseconds = 2500,
    Color bgColor = Colors.blueGrey,
    Color titleColor = Colors.white,
    Widget icon = const Icon(
      Icons.check_circle_outline_rounded,
      color: Colors.greenAccent,
    ),
  }) {
    BotToast.showCustomNotification(
        duration: Duration(milliseconds: durationMiliseconds),
        toastBuilder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                icon,
              ],
            ),
          );
        });
  }
}
