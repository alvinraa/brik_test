import 'package:brik_test/core/common/logger.dart';
import 'package:brik_test/feature/home/data/model/groceries_model.dart';
import 'package:brik_test/feature/home/presentation/widget/groceries_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final dynamic data;
  const HomePage({super.key, this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  TabController? _tabController;
  int _selectedIndex = 0;
  List<Widget> klobAndCoMenu = [
    // all
    Container(
      height: 200,
      color: Colors.red,
      child: const Center(
        child: Text('this is all'),
      ),
    ),
    // foods
    Container(
      height: 200,
      color: Colors.yellow,
      child: const Center(
        child: Text('this is food'),
      ),
    ),
    // drinks
    Container(
      height: 200,
      color: Colors.green,
      child: const Center(
        child: Text('this is drink'),
      ),
    ),
  ];

  @override
  void initState() {
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
      // controller: _scrollController,
      // physics: const AlwaysScrollableScrollPhysics(),
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
                    fontSize: 36,
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
      ],
    );
  }

  Widget all() {
    return buildListAll();
  }

  Widget buildListAll() {
    // var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () async {
        // get data again
      },
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          return _handleScrollNotification(notification);
        },
        child: ListView.separated(
          itemCount: groceriesItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            GroceriesModel data = groceriesItems[index];

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
              child: GroceriesItem(
                imageUrl: data.imageUrl,
                title: data.title,
                desc: data.desc,
                price: data.price,
                onTap: () {
                  Logger.print('go to detail');
                },
              ),
            );
          },
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
