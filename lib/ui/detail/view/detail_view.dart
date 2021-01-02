import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_app/const_lib/tr_consts.dart';
import 'package:news_app/core/base_view.dart';
import 'package:news_app/ui/component/toast_message.dart';
import 'package:news_app/ui/detail/view_model/detail_view_model.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailView extends StatefulWidget {
  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  DetailViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailViewModel>(
      onModelReady: (model) {
        if (Platform.isAndroid) {
          WebView.platform = SurfaceAndroidWebView();
        }
        model.init();
        model.setContext(context);
        viewModel = model;
      },
      builder: (context, value) => buildScaffold,
      model: DetailViewModel(),
    );
  }

  Widget get buildScaffold {
    return Observer(
      builder: (_) {
        return viewModel.article == null
            ? Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : Scaffold(
                body: buildWebView,
                floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                floatingActionButton: FloatingActionButton(
                  elevation: 3,
                  onPressed: () {
                    try {
                      if (viewModel.article.url != null) {
                        Share.share(viewModel.article.url, subject: viewModel.article.title);
                      } else {
                        ToastMessage(
                          text: 'Haber sitesine ulaşılamıyor!',
                        ).showToastMessage(context);
                      }
                    } on Exception catch (e) {
                      ToastMessage(
                        text: something_wrongs,
                      ).showToastMessage(context);
                    }
                  },
                  child: Icon(
                    Icons.share,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  color: Theme.of(context).colorScheme.primary,
                  shape: CircularNotchedRectangle(),
                  child: Row(
                    children: <Widget>[
                      BackButton(
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'Ana Sayfa',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ));
      },
    );
  }

  Widget get buildWebView {
    return viewModel.error
        ? Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              buildImage,
              Expanded(child: _articleDetails),
            ],
          )
        : WebView(
            initialUrl: viewModel.article.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebResourceError: (error) {
              debugPrint("ERRORRR !!!!!!!!!!!!!!!!!!!");
              viewModel.failedWebview();
            },
          );
  }

  Image get buildImage {
    if (viewModel.article.urlToImage != null) {
      return Image.network(
        viewModel.article.urlToImage,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                      : null,
                ),
                Icon(Icons.image, size: 16),
              ],
            ),
          );
        },
      );
    } else {
      return Image.asset(
        "assets/images/app_icon538.png",
        fit: BoxFit.cover,
      );
    }
  }

  Widget get _articleDetails {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                viewModel.article.title.substring(
                    0,
                    viewModel.article.title.lastIndexOf('-') > 0
                        ? viewModel.article.title.lastIndexOf('-')
                        : viewModel.article.title.length),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${viewModel.article.author ?? 'Bilinmiyor'}',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    viewModel.article == null
                                        ? 'Yayın Tarihi Bilinmiyor'
                                        : relativeTimeString(viewModel.article.publishedAt),
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Opacity(
              opacity: 0.75,
              child: Text(
                viewModel.article.description ?? 'Haber detayı belirtilmemiş.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              margin: EdgeInsets.symmetric(vertical: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      please_news_details,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: OutlineButton.icon(
                        onPressed: () async {
                          if (viewModel.article.url != null && await canLaunch(viewModel.article.url)) {
                            await launch(viewModel.article.url);
                          } else {
                            ToastMessage(
                              text: 'Haber sitesine ulaşılamıyor!',
                            ).showToastMessage(context);
                          }
                        },
                        icon: Icon(Icons.link),
                        label: Text(go_to_news_website),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String relativeTimeString(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
