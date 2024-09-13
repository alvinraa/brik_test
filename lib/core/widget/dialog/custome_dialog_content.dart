import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogContent extends StatefulWidget {
  final void Function()? actionOnTap;
  final void Function()? cancelOnTap;
  final String actionWarning;
  final String actionLabel;
  final String cancelLabel;

  const CustomDialogContent({
    super.key,
    required this.actionWarning,
    required this.actionLabel,
    required this.actionOnTap,
    required this.cancelLabel,
    required this.cancelOnTap,
  });

  @override
  State<CustomDialogContent> createState() => _CustomDialogContentState();
}

class _CustomDialogContentState extends State<CustomDialogContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    widget.actionWarning,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.lato(
                      textStyle:
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.cancelOnTap,
                  child: Text(
                    widget.cancelLabel,
                    style: GoogleFonts.lato(
                      textStyle:
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: widget.actionOnTap,
                  child: Text(
                    widget.actionLabel,
                    style: GoogleFonts.roboto(
                      textStyle:
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
