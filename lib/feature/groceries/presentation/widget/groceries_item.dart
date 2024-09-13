import 'package:brik_test/core/widget/shimmer/default_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceriesItem extends StatelessWidget {
  final void Function()? onTap;
  final String imageUrl;
  final String productName;
  final String productDesc;
  final String price;
  final String stock;
  final bool isLoadmore;

  const GroceriesItem({
    super.key,
    this.onTap,
    required this.imageUrl,
    required this.productName,
    required this.productDesc,
    required this.price,
    required this.stock,
    this.isLoadmore = false,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const DefaultShimmer(
                    width: 80,
                    height: 80,
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://placehold.co/80x80.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                );
              },
            ),
          ),
          // other info
          const SizedBox(height: 8),
          Text(
            productName,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              textStyle: textTheme.labelLarge?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Stock: $stock',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              textStyle: textTheme.labelLarge?.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Rp. $price',
            maxLines: 1,
            style: GoogleFonts.lato(
              textStyle: textTheme.labelLarge?.copyWith(
                color: colorScheme.secondary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
