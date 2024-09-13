import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/core/common/navigation.dart';
import 'package:brik_test/core/common/routes.dart';
import 'package:brik_test/core/widget/button/default_button.dart';
import 'package:brik_test/feature/groceries/bloc/groceries_list/groceries_list_bloc.dart';
import 'package:brik_test/feature/groceries/data/model/klontong_response.dart';
import 'package:brik_test/feature/groceries/presentation/widget/groceries_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GroceriesPage extends StatefulWidget {
  final dynamic data;
  const GroceriesPage({super.key, this.data});

  @override
  State<GroceriesPage> createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  // list of bloc
  late GroceriesListBloc groceriesListBloc;

  // tab Controller
  TabController? _tabController;
  int _selectedIndex = 0;
  List<Widget> klobAndCoMenu = [
    Container(), // all
    Container(), // food
    Container(), // drink
  ];

  @override
  void initState() {
    // init bloc
    groceriesListBloc = GroceriesListBloc();
    setState(() {
      groceriesListBloc.add(GetGroceriesListRequest());
    });

    // handle tab controller
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.index = _selectedIndex;
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  // handle scroll to request the data again (pagination)
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      Logger.print('LOADMORE');
      // bloc.add(GetMovieListRequest(isLoadMore: true));
    }
    return false;
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
        'Klotong',
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
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    klobAndCoMenu = [all(), food(), drink()];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // header
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi Alvin,',
                style: GoogleFonts.lato(
                  textStyle: textTheme.labelLarge?.copyWith(
                    color: colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Find your food',
                style: GoogleFonts.lato(
                  textStyle: textTheme.labelLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // tab bar
        TabBar(
          controller: _tabController,
          isScrollable: false,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: GoogleFonts.lato(
            textStyle: textTheme.labelLarge
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          labelColor: colorScheme.secondary,
          indicatorColor: colorScheme.secondary,
          indicator: UnderlineTabIndicator(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            borderSide: BorderSide(
              width: 3.0,
              color: colorScheme.secondary,
            ),
          ),
          tabs: const [
            Tab(
              text: 'All',
            ),
            Tab(
              text: 'Food',
            ),
            Tab(
              text: 'Drink',
            ),
          ],
        ),
        const SizedBox(height: 16),
        // the content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: klobAndCoMenu,
          ),
        ),
        // space for btm
        const SizedBox(height: 24),
        submitButton(),
      ],
    );
  }

  Widget all() {
    return BlocBuilder(
      bloc: groceriesListBloc,
      builder: (context, state) {
        if (state is GroceriesListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GroceriesListError) {
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(child: Text(state.errorMessage ?? "-")),
          );
        }

        return buildListAll(context, state);
      },
    );
  }

  Widget buildListAll(BuildContext context, Object? state) {
    // var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    List<GroceriesModel> listGroceries = [];
    listGroceries = groceriesListBloc.listGroceries;

    return RefreshIndicator(
      onRefresh: () async {
        // get data again
        // groceriesListBloc.add(GetGroceriesListRequest());
      },
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          // return _handleScrollNotification(notification);
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.builder(
            itemCount: listGroceries.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              // this height should not be fixed
              mainAxisExtent: 220,
            ),
            itemBuilder: (context, index) {
              GroceriesModel data = listGroceries[index];

              return Container(
                // margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GroceriesItem(
                  imageUrl: data.image ?? '',
                  productName: data.name ?? '',
                  productDesc: data.description ?? '',
                  price: data.price.toString(),
                  stock: data.stock.toString(),
                  onTap: () {
                    String id = data.id ?? '';
                    Logger.print('id : $id');

                    navigatorKey.currentState
                        ?.pushNamed(
                      Routes.groceriesDetailPage,
                      arguments: id,
                    )
                        .then(
                      (value) {
                        setState(() {
                          groceriesListBloc.add(GetGroceriesListRequest());
                        });
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
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
              navigatorKey.currentState
                  ?.pushNamed(
                Routes.groceriesCUDPage,
              )
                  .then(
                (value) {
                  setState(() {
                    groceriesListBloc.add(GetGroceriesListRequest());
                  });
                },
              );
            },
            label: 'Add New Item',
            height: 40,
          ),
        ),
      ),
    );
  }

  Widget food() {
    return buildOtherList();
  }

  Widget drink() {
    return buildOtherList();
  }

  Widget buildOtherList() {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () async {
        // get data again
      },
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          return _handleScrollNotification(notification);
        },
        child: Center(
          child: Text(
            'Sorry, this page still on development',
            style: GoogleFonts.lato(
              textStyle: textTheme.labelLarge?.copyWith(
                color: colorScheme.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
