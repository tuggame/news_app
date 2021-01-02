import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_app/const_lib/tr_consts.dart';
import 'package:news_app/core/pref_store.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PrefStore>(
      builder: (context, prefStore, _) => Material(
        child: Scaffold(
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
          ),
          body: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    settings,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Theme.of(context).dividerColor),
                                ),
                              ),
                              padding: EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.article,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: TextButton(
                                      onPressed: () {
                                        showLicensePage(context: context);
                                      },
                                      child: Text(
                                        licenses,
                                        style: Theme.of(context).textTheme.headline3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
                              ),
                              padding: EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.flag,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Haber Kaynağı Ülke',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text(
                                                  'Türkiye',
                                                  style: Theme.of(context).textTheme.subtitle1,
                                                ),
                                              ),
                                              Opacity(
                                                opacity: 0.5,
                                                child: Text(
                                                  'Bütün haberler seçili ülkeye göre getirilir',
                                                  style: Theme.of(context).textTheme.subtitle2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(6),
                                              child: Image.asset('assets/tr.png', width: 72),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
                              ),
                              padding: EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.format_paint_rounded,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Özelleştirme',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Observer(
                              builder: (_) => Padding(
                                padding: const EdgeInsets.only(left: 16, top: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Karanlık temayı kullan',
                                          style: Theme.of(context).textTheme.subtitle1,
                                        ),
                                        Switch(
                                          value: prefStore.darkMode,
                                          onChanged: prefStore.setDarkMode,
                                          activeColor: Theme.of(context).accentColor,
                                        ),
                                        /*=> Material(
                                        child: Switch(
                                          value: prefStore.useDarkMode,
                                          onChanged: prefStore.setDarkMode,
                                          activeColor: Theme.of(context).accentColor,
                                        ),
                                      ),

                                       */
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
                              ),
                              padding: EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.developer_mode,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Geliştirici',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text(
                                                  'Tuğçe Avşar',
                                                  style: Theme.of(context).textTheme.subtitle1,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Opacity(
                                                    opacity: 0.6,
                                                    child: TextButton(
                                                      onPressed: () async {
                                                        await launch('https://www.linkedin.com/in/avsartugce/');
                                                      },
                                                      child: Text(
                                                        '@avsartugce',
                                                        style: Theme.of(context).textTheme.subtitle2,
                                                        textAlign: TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(6),
                                              child: Image.asset('assets/avstug.png', width: 72),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
