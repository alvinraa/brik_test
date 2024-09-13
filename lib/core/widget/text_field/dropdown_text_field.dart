import 'package:brik_test/core/theme/style.dart';
import 'package:brik_test/core/widget/dialog/custome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final String? label;
  final String? hintText;
  final String? hintDesc;
  final TextStyle? hintDescStyle;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final String? suffixText;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? errorText;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool isDone;
  final Color? fillColor;
  final int maxLines;
  final String? initialValue;
  final TextStyle? hintStyle;
  final int? errorMaxLines;
  final bool hasAsterixOnLabel;
  final List<Widget>? items;
  final bool isLoading;
  final GlobalKey globalKey;
  final double? borderRadius;
  final Color? border;
  final bool isLabelOutside;

  const DropdownTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.isDone = false,
    this.label,
    this.hintText,
    this.prefixText,
    this.prefixIcon,
    this.prefix,
    this.suffixText,
    this.suffixIcon,
    this.suffix,
    this.errorText,
    this.validator,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.textStyle,
    this.labelStyle,
    this.fillColor,
    this.maxLines = 1,
    this.initialValue,
    this.hintStyle,
    this.hintDesc,
    this.hintDescStyle,
    this.errorMaxLines,
    this.hasAsterixOnLabel = false,
    this.items,
    this.isLoading = false,
    required this.globalKey,
    this.borderRadius,
    this.border,
    this.isLabelOutside = false,
  });

  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  TextStyle? _textStyle = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  TextStyle? _labelStyle = GoogleFonts.lato(
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  );

  TextStyle? _hintDescStyle = GoogleFonts.lato(
    textStyle: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
  );

  final ScrollController _scrollController = ScrollController();
  late String hint;

  @override
  void initState() {
    if (widget.textStyle != null) {
      _textStyle = widget.textStyle;
    }

    if (widget.labelStyle != null) {
      _labelStyle = widget.labelStyle;
    }

    if (widget.hintDescStyle != null) {
      _hintDescStyle = widget.hintDescStyle;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    hint = widget.hintText ?? 'choose';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.label != null && widget.isLabelOutside == true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.label ?? '-',
                    style: _labelStyle,
                  ),
                ),
                if (widget.hasAsterixOnLabel)
                  Text(
                    '*',
                    style: TextStyle(
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.w700),
                  ),
              ],
            ),
          ),
        ),
        if (widget.isLoading)
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(width: 2, color: Styles().color.border),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Center(
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
        if (!widget.isLoading)
          Column(
            children: [
              TextFormField(
                key: widget.globalKey,
                initialValue: widget.initialValue,
                controller: widget.controller,
                onTap: _onTap,
                validator: widget.validator,
                textCapitalization: TextCapitalization.none,
                readOnly: widget.readOnly,
                enabled: widget.enabled,
                style: _textStyle,
                keyboardType: widget.textInputType,
                maxLines: widget.maxLines,
                cursorColor: theme.colorScheme.secondary,
                decoration: InputDecoration(
                  label: widget.isLabelOutside == false && widget.label != null
                      ? UnconstrainedBox(
                          child: Row(
                            children: [
                              Text(
                                "${widget.label}",
                                style: widget.enabled == true
                                    ? TextStyle(
                                        color: theme.colorScheme.secondary)
                                    : const TextStyle(color: Colors.grey),
                              ),
                              if (widget.hasAsterixOnLabel)
                                Text(
                                  '*',
                                  style: TextStyle(
                                      color: Colors.red.shade600,
                                      fontWeight: FontWeight.w700),
                                ),
                            ],
                          ),
                        )
                      : null,
                  floatingLabelBehavior: widget.isLabelOutside == false
                      ? FloatingLabelBehavior.always
                      : null,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.prefixIcon == null &&
                              widget.borderRadius != null
                          ? 32
                          : 16,
                      vertical: widget.maxLines > 1 ? 10 : 0.0),
                  filled: true,
                  fillColor: widget.fillColor ??
                      (widget.enabled == false
                          ? Colors.grey.shade200
                          : theme.colorScheme.onPrimary),
                  isDense: widget.prefixIcon != null ? true : false,
                  prefixIconConstraints: widget.prefixIcon != null
                      ? const BoxConstraints(minWidth: 0, minHeight: 0)
                      : null,
                  prefix: widget.prefix,
                  prefixIcon: widget.prefixIcon,
                  prefixText: widget.prefixText,
                  suffix: widget.suffix,
                  suffixText: widget.suffixText,
                  suffixIcon: widget.suffixIcon ??
                      Icon(Icons.keyboard_arrow_down_rounded,
                          size: 24, color: Colors.grey.shade500),
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle ??
                      GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.color
                            ?.withOpacity(0.4),
                      ),
                  errorText: widget.errorText,
                  errorMaxLines: widget.errorMaxLines,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.border ?? Styles().color.border,
                    ),
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 6.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.border ?? Styles().color.border,
                    ),
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 6.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: theme.colorScheme.secondary,
                    ),
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 6.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: widget.border ?? Styles().color.border,
                    ),
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 6.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: theme.colorScheme.error,
                    ),
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 6.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: theme.colorScheme.error,
                    ),
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 6.0),
                  ),
                ),
              ),
            ],
          ),
        Visibility(
          visible: widget.hintDesc != null,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 6.0, bottom: 6.0),
            child: Text(
              widget.hintDesc ?? '-',
              style: _hintDescStyle,
            ),
          ),
        ),
      ],
    );
  }

  _onTap() {
    RenderBox box =
        widget.globalKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double posY = position.dy;
    double height = MediaQuery.of(context).size.height * 0.7;
    _dropdown(context, widget.items ?? [], posY, height);
  }

  void _dropdown(
      BuildContext ctx, List<Widget> items, double posY, double height) {
    showCustomDialog(
      context: ctx,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: posY > height ? posY - 150 : posY,
              width: MediaQuery.of(context).size.width,
              child: CustomDialog(
                alignment: Alignment.centerLeft,
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                scrollable: true,
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                content: Container(
                  constraints: const BoxConstraints(maxHeight: 240),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
