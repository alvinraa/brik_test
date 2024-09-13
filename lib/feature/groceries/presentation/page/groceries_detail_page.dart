import 'package:brik_test/core/common/navigation.dart';
import 'package:brik_test/core/common/routes.dart';
import 'package:brik_test/core/widget/button/default_button.dart';
import 'package:brik_test/core/widget/dialog/delete_dialog_content.dart';
import 'package:brik_test/core/widget/shimmer/default_shimmer.dart';
import 'package:brik_test/core/widget/toast/toast.dart';
import 'package:brik_test/feature/groceries/bloc/groceries_delete/groceries_delete_bloc.dart';
import 'package:brik_test/feature/groceries/bloc/groceries_detail/groceries_detail_bloc.dart';
import 'package:brik_test/feature/groceries/data/model/klontong_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceriesDetailPage extends StatefulWidget {
  final dynamic data;
  const GroceriesDetailPage({super.key, this.data});

  @override
  State<GroceriesDetailPage> createState() => _GroceriesDetailPageState();
}

class _GroceriesDetailPageState extends State<GroceriesDetailPage> {
  late GroceriesDetailBloc groceriesDetailBloc;
  late GroceriesDeleteBloc groceriesDeleteBloc;

  String? groceriesId;
  GroceriesModel? groceriesModel;

  @override
  void initState() {
    if (widget.data != null) {
      groceriesId = widget.data;
    }
    // init bloc
    groceriesDetailBloc = GroceriesDetailBloc();
    groceriesDeleteBloc = GroceriesDeleteBloc();

    setState(() {
      groceriesDetailBloc.add(GetGroceriesDetailRequest(id: groceriesId ?? ''));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocConsumer(
        bloc: groceriesDetailBloc,
        listener: (context, state) {
          if (state is GroceriesDetailLoaded) {
            groceriesModel = groceriesDetailBloc.groceriesModel;
          }
        },
        builder: (context, state) {
          if (state is GroceriesDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GroceriesDetailError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(child: Text(state.errorMessage ?? "-")),
            );
          }

          return buildContent(context);
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: colorScheme.onPrimary,
      actions: groceriesId != null ? [deleteButton()] : null,
      title: Text(
        'Groceries Detail',
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

  Widget deleteButton() {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer(
      bloc: groceriesDeleteBloc,
      listener: (context, state) {
        if (state is GroceriesDeleteSuccess) {
          Toast.showToast(
            iconColor: Colors.green,
            iconData: Icons.check_circle_outline_outlined,
            message: 'success delete data',
          );

          // Navigator.pop(context);
        }
        if (state is GroceriesDeleteError) {
          Toast.showToast(
            iconColor: Theme.of(context).colorScheme.primary,
            iconData: Icons.info_outlined,
            message: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (groceriesId != null) {
              showDialog(
                context: Navigator.of(context).context,
                barrierDismissible: true,
                builder: (context) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.all(40),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DeleteDialogContent(
                        deleteOnTap: () {
                          groceriesDeleteBloc.add(GroceriesDetailDeleteRequest(
                              id: groceriesId ?? ''));
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        cancelOnTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
          child: state is GroceriesDeleteLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.delete_outline,
                    color: colorScheme.error,
                  ),
                ),
        );
      },
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: buildSection(context),
        ),
        const SizedBox(height: 24),
        buttonUpdate(),
      ],
    );
  }

  Widget buildSection(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    GroceriesModel groceriesData = groceriesDetailBloc.groceriesModel;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // image
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: Image.network(
            groceriesData.image ?? '',
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const DefaultShimmer(
                  width: double.infinity,
                  height: 300,
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://placehold.co/300.png',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              );
            },
          ),
        ),
        // detail data
        Expanded(
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groceriesData.name ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      textStyle: textTheme.labelLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'stock: ',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          textStyle: textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        groceriesData.stock?.toString() ?? '',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          textStyle: textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'price: ',
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.lato(
                          textStyle: textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Rp. ${groceriesData.price?.toString() ?? ''}',
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.lato(
                          textStyle: textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'product category: ',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          textStyle: textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            // color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        groceriesData.categoryName ?? '',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          textStyle: textTheme.labelLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Product Description',
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      textStyle: textTheme.labelLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    groceriesData.description ?? '',
                    maxLines: 5,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      textStyle: textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget buttonUpdate() {
    // var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DefaultButton(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            onPressed: () {
              // go to add input page
              navigatorKey.currentState
                  ?.pushNamed(
                Routes.groceriesCUDPage,
                arguments: groceriesModel,
              )
                  .then(
                (value) {
                  setState(() {
                    groceriesDetailBloc
                        .add(GetGroceriesDetailRequest(id: groceriesId ?? ''));
                  });
                },
              );
            },
            label: 'Edit',
            height: 40,
          ),
        ),
      ),
    );
  }
}
