import 'package:brik_test/core/utils/text_input_formatter.dart';
import 'package:brik_test/core/widget/button/default_button.dart';
import 'package:brik_test/core/widget/text_field/default_text_field.dart';
import 'package:brik_test/core/widget/toast/toast.dart';
import 'package:brik_test/feature/groceries/bloc/groceries_add/groceries_add_bloc.dart';
import 'package:brik_test/feature/groceries/bloc/groceries_update/groceries_update_bloc.dart';
import 'package:brik_test/feature/groceries/data/model/groceries_payload.dart';
import 'package:brik_test/feature/groceries/data/model/klontong_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceriesCUDPage extends StatefulWidget {
  final dynamic data;
  const GroceriesCUDPage({super.key, this.data});

  @override
  State<GroceriesCUDPage> createState() => _GroceriesCUDPageState();
}

class _GroceriesCUDPageState extends State<GroceriesCUDPage> {
  late GroceriesAddBloc groceriesAddBloc;
  late GroceriesUpdateBloc groceriesUpdateBloc;

  GroceriesPayload payload = GroceriesPayload();

  GroceriesModel? groceriesModel;
  String? groceriesId;

  // final _formKey = GlobalKey<FormState>();

  final _selfSummaryController = TextEditingController();

  @override
  void initState() {
    if (widget.data != null) {
      groceriesModel = widget.data;
      groceriesId = groceriesModel?.id ?? '';
    }
    // init bloc
    groceriesAddBloc = GroceriesAddBloc();
    groceriesUpdateBloc = GroceriesUpdateBloc();

    setState(() {
      // groceriesDetailBloc.add(GetGroceriesDetailRequest(id: groceriesId ?? ''));
    });

    super.initState();
  }

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
        groceriesId != null ? 'Update Groceries' : 'Add Groceries',
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
        groceriesId != null ? updateButton() : addButton(),
      ],
    );
  }

  Widget buildSection(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'General Information',
            style: GoogleFonts.lato(
              textStyle: textTheme.labelLarge?.copyWith(
                fontSize: 22,
                color: colorScheme.secondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 24),
          DefaultTextField(
            label: 'current_salary',
            hintText: 'fill_self_summarize',
            controller: _selfSummaryController,
            maxLines: 1,
            inputFormatters: [
              NoLeadingSpacesInputFormatter(),
            ],
            onChanged: (val) {
              setState(() {});
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget addButton() {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer(
      bloc: groceriesAddBloc,
      listener: (context, state) {
        if (state is GroceriesAddSuccess) {
          Toast.showToast(
            iconColor: Colors.green,
            iconData: Icons.check_circle_outline_outlined,
            message: 'success add data',
          );

          Navigator.pop(context);
        }
        if (state is GroceriesAddError) {
          Toast.showToast(
            iconColor: Theme.of(context).colorScheme.primary,
            iconData: Icons.info_outlined,
            message: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return Container(
          color: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DefaultButton(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () {
                  // payload.name = _selfSummaryController.text;

                  // groceriesAddBloc.add(GroceriesAddRequest(payload: payload));
                },
                showLoading: state is GroceriesAddLoading,
                label: 'Add',
                height: 40,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget updateButton() {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer(
      bloc: groceriesUpdateBloc,
      listener: (context, state) {
        if (state is GroceriesUpdateSuccess) {
          Toast.showToast(
            iconColor: Colors.green,
            iconData: Icons.check_circle_outline_outlined,
            message: 'success update data',
          );

          Navigator.pop(context);
        }
        if (state is GroceriesUpdateError) {
          Toast.showToast(
            iconColor: Theme.of(context).colorScheme.primary,
            iconData: Icons.info_outlined,
            message: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return Container(
          color: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DefaultButton(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () {
                  // payload.name = _selfSummaryController.text;

                  // groceriesUpdateBloc.add(GroceriesUpdateRequest(payload: payload));
                },
                showLoading: state is GroceriesUpdateLoading,
                label: 'Update',
                height: 40,
              ),
            ),
          ),
        );
      },
    );
  }
}
