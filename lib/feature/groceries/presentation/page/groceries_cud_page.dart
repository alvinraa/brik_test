import 'package:brik_test/core/widget/button/default_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceriesCUDPage extends StatefulWidget {
  final dynamic data;
  const GroceriesCUDPage({super.key, this.data});

  @override
  State<GroceriesCUDPage> createState() => _GroceriesCUDPageState();
}

class _GroceriesCUDPageState extends State<GroceriesCUDPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildContent(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: colorScheme.onPrimary,
      title: Text(
        'Groceries Add / Update / Delete',
        style: GoogleFonts.roboto(
          textStyle: textTheme.labelLarge?.copyWith(
            color: colorScheme.secondary,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              // children
              buildSection(context),
            ],
          ),
        ),
        const SizedBox(height: 24),
        submitButton(),
      ],
    );
  }

  Widget buildSection(BuildContext context) {
    return Container();
  }

  Widget submitButton() {
    // var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DefaultButton(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            onPressed: () {
              // go to add input page
            },
            label: 'Submit',
            height: 40,
          ),
        ),
      ),
    );
  }
}
