import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/const_lib/tr_consts.dart';
import 'package:news_app/core/base_view.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/network/firebase_helper.dart';
import 'package:news_app/network/newscast_api.dart';
import 'package:news_app/ui/component/outline_button.dart';
import 'package:news_app/ui/home/component/news_menu_card.dart';
import 'package:news_app/ui/home/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) {
        model.init();
        model.setContext(context);
        viewModel = model;
      },
      builder: (context, value) => buildScaffold,
      model: HomeViewModel(),
    );
  }

  Scaffold get buildScaffold {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          buildSilverAppBar1,
          buildSliverAppBar2,
          buildSilverAppBar3,
          buildSliverStaggeredGrid,
        ],
      ),
    );
  }

  SliverAppBar get buildSilverAppBar1 {
    return SliverAppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        floating: false,
        pinned: false,
        snap: false,
        expandedHeight: 50,
        flexibleSpace: const FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            'Haberler',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Çıkış',
            onPressed: () async {
              await FirebaseHelper.helperInstance.signOut(viewModel.context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Ayarlar',
            onPressed: () {
              Navigator.pushNamed(
                viewModel.context,
                '/settings',
              );
            },
          ),
        ]);
  }

  SliverAppBar get buildSliverAppBar2 {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: buildSearchField,
      //actions: [buildIconButtonClose],
      bottom: buildCategorySelection,
    );
  }

  Widget get buildSearchField {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
      ),
      child: TextField(
        controller: viewModel.searchController,
        decoration: InputDecoration(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.secondary,
          ),
          hintText: search,
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () => viewModel.resetArticles(),
            icon: Icon(Icons.clear),
          ),
        ),
        onSubmitted: (String keyword) => viewModel.loadArticles(keyword),
      ),
    );
  }

  IconButton get buildIconButtonClose {
    return IconButton(
      onPressed: () => viewModel.resetArticles(),
      icon: Icon(Icons.close, color: Colors.black),
    );
  }

  Widget get buildCategorySelection {
    return PreferredSize(
      preferredSize: Size.fromHeight(70.0),
      child: Observer(builder: (_) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedOutlineButton(
                  text: 'Genel',
                  textColor: viewModel.category == NewsCategory.general
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  borderColor: viewModel.category == NewsCategory.general
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    viewModel.loadArticles('', NewsCategory.general);
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                RoundedOutlineButton(
                  text: 'Ekonomi',
                  textColor: viewModel.category == NewsCategory.business
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  borderColor: viewModel.category == NewsCategory.business
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    viewModel.loadArticles('', NewsCategory.business);
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                RoundedOutlineButton(
                  text: 'Eğlence',
                  textColor: viewModel.category == NewsCategory.entertainment
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  borderColor: viewModel.category == NewsCategory.entertainment
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    viewModel.loadArticles('', NewsCategory.entertainment);
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                RoundedOutlineButton(
                  text: 'Sağlık',
                  textColor: viewModel.category == NewsCategory.health
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  borderColor: viewModel.category == NewsCategory.health
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    viewModel.loadArticles('', NewsCategory.health);
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedOutlineButton(
                  text: 'Bilim',
                  textColor: viewModel.category == NewsCategory.science
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  borderColor: viewModel.category == NewsCategory.science
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    viewModel.loadArticles('', NewsCategory.science);
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                RoundedOutlineButton(
                  text: 'Spor',
                  textColor: viewModel.category == NewsCategory.sports
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  borderColor: viewModel.category == NewsCategory.sports
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    viewModel.loadArticles('', NewsCategory.sports);
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                RoundedOutlineButton(
                  text: 'Teknoloji',
                  textColor: viewModel.category == NewsCategory.technology
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  borderColor: viewModel.category == NewsCategory.technology
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    viewModel.loadArticles('', NewsCategory.technology);
                  },
                ),
              ],
            )
          ],
        );
      }),
    );
  }

  Widget get buildSilverAppBar3 {
    return SliverAppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      expandedHeight: 210,
      floating: false,
      pinned: false,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          color: Colors.white,
          child: Observer(
            builder: (_) {
              return viewModel.loadingCarouselArticles
                  ? Container(
                      color: Theme.of(context).backgroundColor, child: Center(child: CircularProgressIndicator()))
                  : _carouselWithIndicator;
            },
          ),
        ),
      ),
    );
  }

  Widget get buildSliverStaggeredGrid {
    if (viewModel.error.isNotEmpty) {
      _showErrorDialog();
    }

    return SliverPadding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      sliver: Observer(builder: (_) {
        return viewModel.loadingArticles
            ? SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
            : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) =>
                    NewsMenuCardWidget(article: viewModel.articles[index]),
                itemCount: viewModel.articles.length,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                staggeredTileBuilder: (_) {
                  return StaggeredTile.fit(1);
                },
              );
      }),
    );
  }

  Widget get _carouselWithIndicator {
    List<Widget> _imageSliders = viewModel.carouselArticles
        .map((item) => Container(
              color: Theme.of(context).backgroundColor,
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: InkWell(
                    child: Stack(
                      children: <Widget>[
                        _buildImage(item),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '${item.title}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        viewModel.context,
                        '/detail',
                        arguments: item,
                      );
                    },
                  ),
                ),
              ),
            ))
        .toList();

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          CarouselSlider(
            items: _imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  viewModel.changeCarouselIndex(index);
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: viewModel.carouselArticles.map((item) {
              int index = viewModel.carouselArticles.indexOf(item);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: viewModel.carouselIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primaryVariant,
                  // Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Image _buildImage(Article item) {
    if (item.urlToImage != null) {
      return Image.network(
        item.urlToImage,
        fit: BoxFit.cover,
        width: 1000.0,
      );
    } else {
      return Image.asset(
        "assets/app_icon538.png",
        fit: BoxFit.cover,
        width: 1000.0,
      );
    }
  }

  _showErrorDialog() {
    if (viewModel.error.isNotEmpty) {
      showDialog<void>(
        context: viewModel.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: SingleChildScrollView(
              child: Text(
                viewModel.error,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('TAMAM'),
                onPressed: () {
                  viewModel.loadArticles(viewModel.keyword, viewModel.category);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
