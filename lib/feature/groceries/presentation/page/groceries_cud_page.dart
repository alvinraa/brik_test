import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/core/utils/text_input_formatter.dart';
import 'package:brik_test/core/widget/button/default_button.dart';
import 'package:brik_test/core/widget/dropdown/default_dropdown_item.dart';
import 'package:brik_test/core/widget/text_field/default_text_field.dart';
import 'package:brik_test/core/widget/text_field/dropdown_text_field.dart';
import 'package:brik_test/core/widget/toast/toast.dart';
import 'package:brik_test/feature/groceries/bloc/groceries_add/groceries_add_bloc.dart';
import 'package:brik_test/feature/groceries/bloc/groceries_update/groceries_update_bloc.dart';
import 'package:brik_test/feature/groceries/data/model/groceries_payload.dart';
import 'package:brik_test/feature/groceries/data/model/klontong_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final _formKey = GlobalKey<FormState>();
  final GlobalKey _categoryKey = GlobalKey();

  final _categoryNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  bool isCategoryError = false;
  bool isNameError = false;
  bool isDescriptionError = false;
  bool isStockError = false;
  bool isPriceError = false;

  int? categoryIdSelected;
  String? categoryNameSelected;

  List listCategory = [
    {
      'categoryId': 1,
      'categoryName': 'food',
    },
    {
      'categoryId': 2,
      'categoryName': 'drink',
    },
  ];

  @override
  void initState() {
    if (widget.data != null) {
      groceriesModel = widget.data;
      groceriesId = groceriesModel?.id ?? '';

      // getData
      categoryIdSelected = groceriesModel?.categoryId ?? 1;
      categoryNameSelected = groceriesModel?.categoryName ?? '';

      _categoryNameController.text = groceriesModel?.categoryName ?? '';
      _nameController.text = groceriesModel?.name ?? '';
      _descriptionController.text = groceriesModel?.description ?? '';
      _stockController.text = groceriesModel?.stock?.toString() ?? '';
      _priceController.text = groceriesModel?.price?.toString() ?? '';
      _imageUrlController.text = groceriesModel?.image ?? '';
    }
    // init bloc
    groceriesAddBloc = GroceriesAddBloc();
    groceriesUpdateBloc = GroceriesUpdateBloc();

    setState(() {});

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

    return Form(
      key: _formKey,
      child: Container(
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
            DropdownTextField(
              label: 'category',
              hintText: 'choose_category',
              globalKey: _categoryKey,
              controller: _categoryNameController,
              hasAsterixOnLabel: true,
              suffixIcon: Icon(
                Icons.expand_more_rounded,
                size: 24,
                color: Colors.grey.shade500,
              ),
              readOnly: true,
              items: listCategory
                  .map((val) => DefaultDropdownItem(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _categoryNameController.text =
                              val['categoryName'] ?? "";
                          categoryIdSelected = val['categoryId'] ?? "";
                          categoryNameSelected = val['categoryName'] ?? "";

                          if (isCategoryError) {
                            isCategoryError = false;
                            _formKey.currentState!.validate();
                          }
                        });
                      },
                      name: val['categoryName'] ?? ""))
                  .toList(),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  isCategoryError = true;
                  return 'field_required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DefaultTextField(
              label: 'name',
              hintText: 'input_name',
              controller: _nameController,
              hasAsterixOnLabel: true,
              maxLines: 1,
              inputFormatters: [
                NoLeadingSpacesInputFormatter(),
              ],
              onChanged: (val) {
                if (isNameError) {
                  isNameError = false;
                  _formKey.currentState!.validate();
                }
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  isNameError = true;
                  return 'field_required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            DefaultTextField(
              label: 'description',
              hintText: 'input_description',
              controller: _descriptionController,
              hasAsterixOnLabel: true,
              maxLines: 1,
              inputFormatters: [
                NoLeadingSpacesInputFormatter(),
              ],
              onChanged: (val) {
                if (isDescriptionError) {
                  isDescriptionError = false;
                  _formKey.currentState!.validate();
                }
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  isDescriptionError = true;
                  return 'field_required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            DefaultTextField(
              label: 'stock',
              hintText: 'input_stock',
              controller: _stockController,
              hasAsterixOnLabel: true,
              textInputType: TextInputType.number,
              maxLines: 1,
              inputFormatters: [
                NoLeadingSpacesInputFormatter(),
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              onChanged: (val) {
                if (isStockError) {
                  isStockError = false;
                  _formKey.currentState!.validate();
                }
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  isStockError = true;
                  return 'field_required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            DefaultTextField(
              label: 'price',
              hintText: 'input_price',
              controller: _priceController,
              hasAsterixOnLabel: true,
              textInputType: TextInputType.number,
              maxLines: 1,
              inputFormatters: [
                NoLeadingSpacesInputFormatter(),
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              onChanged: (val) {
                if (isPriceError) {
                  isPriceError = false;
                  _formKey.currentState!.validate();
                }
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  isPriceError = true;
                  return 'field_required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            DefaultTextField(
              label: 'image_url',
              hintText: 'input_image_url',
              controller: _imageUrlController,
              maxLines: 1,
              inputFormatters: [
                NoLeadingSpacesInputFormatter(),
              ],
              onChanged: (val) {},
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget addButton() {
    var colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer(
      bloc: groceriesAddBloc,
      listener: (context, state) {
        if (state is GroceriesAddSuccess) {
          // Toast.showToast(
          //   iconColor: Colors.green,
          //   iconData: Icons.check_circle_outline_outlined,
          //   message: 'success add data',
          // );
          Logger.print('success');

          Navigator.pop(context);
        }
        if (state is GroceriesAddError) {
          // Toast.showToast(
          //   iconColor: colorScheme.primary,
          //   iconData: Icons.info_outlined,
          //   message: state.errorMessage,
          // );
          Logger.print('failed');
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
                  // validate first
                  if (!_formKey.currentState!.validate()) {
                    Toast.showToast(
                        iconColor: colorScheme.primary,
                        iconData: Icons.info_outlined,
                        message: 'please_fill_required');
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    payload.categoryId = categoryIdSelected ?? 1;
                    payload.categoryName = categoryNameSelected ?? '';
                    payload.name = _nameController.text;
                    payload.description = _descriptionController.text;
                    payload.stock = int.parse(_stockController.text);
                    payload.price = int.parse(_priceController.text);
                    payload.image = _imageUrlController.text;

                    // send request
                    setState(() {
                      groceriesAddBloc
                          .add(GroceriesAddRequest(payload: payload));
                    });
                  }
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
          // Toast.showToast(
          //   iconColor: Colors.green,
          //   iconData: Icons.check_circle_outline_outlined,
          //   message: 'success update data',
          // );

          Logger.print('success');

          Navigator.pop(context);
        }
        if (state is GroceriesUpdateError) {
          // Toast.showToast(
          //   iconColor: Theme.of(context).colorScheme.primary,
          //   iconData: Icons.info_outlined,
          //   message: state.errorMessage,
          // );
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
                  // validate first
                  if (!_formKey.currentState!.validate()) {
                    Toast.showToast(
                        iconColor: colorScheme.primary,
                        iconData: Icons.info_outlined,
                        message: 'please_fill_required');
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    payload.categoryId = categoryIdSelected ?? 1;
                    payload.categoryName = categoryNameSelected ?? '';
                    payload.name = _nameController.text;
                    payload.description = _descriptionController.text;
                    payload.stock = int.parse(_stockController.text);
                    payload.price = int.parse(_priceController.text);
                    payload.image = _imageUrlController.text;

                    if (groceriesId != null) {
                      setState(() {
                        groceriesUpdateBloc.add(GroceriesUpdateRequest(
                            id: groceriesId ?? '', payload: payload));
                      });
                    }
                    // send request
                  }
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
