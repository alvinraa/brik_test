import 'package:brik_test/core/widget/button/shimmer/default_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceriesItem extends StatelessWidget {
  final void Function()? onTap;
  final String imageUrl;
  final String title;
  final String desc;
  final String price;
  final bool isLoadmore;

  const GroceriesItem({
    super.key,
    this.onTap,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.price,
    this.isLoadmore = false,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 140,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const DefaultShimmer(
                    width: 120,
                    height: 140,
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://placehold.co/140x120.png',
                  width: 120,
                  height: 140,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                );
              },
            ),
          ),
          // other info
          const SizedBox(width: 20),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: textTheme.labelLarge?.copyWith(
                    color: colorScheme.secondary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: GoogleFonts.lato(
                  textStyle: textTheme.labelLarge?.copyWith(
                    // color: colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Rp. ',
                    style: GoogleFonts.lato(
                      textStyle: textTheme.labelLarge?.copyWith(
                        // color: colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    price,
                    style: GoogleFonts.lato(
                      textStyle: textTheme.labelLarge?.copyWith(
                        color: colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
