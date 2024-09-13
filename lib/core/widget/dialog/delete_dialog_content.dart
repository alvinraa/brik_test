import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteDialogContent extends StatefulWidget {
  final void Function()? deleteOnTap;
  final void Function()? cancelOnTap;
  final String? deleteWarning;

  const DeleteDialogContent({
    super.key,
    required this.deleteOnTap,
    required this.cancelOnTap,
    this.deleteWarning,
  });

  @override
  State<DeleteDialogContent> createState() => _DeleteDialogContentState();
}

class _DeleteDialogContentState extends State<DeleteDialogContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.deleteWarning ?? 'Are you sure to delete this data?',
                textAlign: TextAlign.start,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                )),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.cancelOnTap,
                  child: Text(
                    "Cancel",
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
                  onPressed: widget.deleteOnTap,
                  child: Text(
                    "Yes, delete",
                    style: GoogleFonts.lato(
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
