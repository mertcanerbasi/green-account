import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:greenaccount/models/app_preferences_model.dart';
import 'package:provider/provider.dart';

import '../../services/sharedPref.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final DataService _dataService = DataService();
  bool? _switchSelected;
  AppPreferencesModel? _appPreferencesModel;
  bool _isLoading = true;
  void _clearExpenseList() async {
    await _dataService.clearExpenseList();
  }

  void _clearIncomesList() async {
    await _dataService.clearIncomesList();
  }

  void _clearNotificationsList() async {
    await _dataService.clearNotificationsList();
  }

  void _clearAppPreferences() async {
    await _dataService.clearAppPreferences();
  }

  Future<void> _writeToAppPreferences(
      AppPreferencesModel? appPreferencesModel) async {
    await _dataService.writeAppPreferences(appPreferencesModel);
  }

  Future<void> _readAppPreferences() async {
    AppPreferencesModel? data = await _dataService.readAppPreferences();
    setState(() {
      _appPreferencesModel = data;
      _switchSelected = _appPreferencesModel?.theme ?? false;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _readAppPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == false
        ? ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  iconColor: Colors.black,
                  leading: const Icon(Icons.color_lens),
                  title: const Text(
                    "Karanlık Tema",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Switch.adaptive(
                      activeColor: Colors.black,
                      value: _switchSelected as bool,
                      onChanged: (value) async {
                        setState(() {
                          _switchSelected = !(_switchSelected as bool);
                          _appPreferencesModel = AppPreferencesModel(
                              theme: _switchSelected,
                              language: _appPreferencesModel?.language ?? "tr");
                        });

                        await _writeToAppPreferences(_appPreferencesModel);
                        log("TODO : Tema Bölümü Eklenecek");
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    log("TODO : Uygulama Kilidi Bölümü Eklenecek");
                  },
                  child: ListTile(
                    iconColor: Colors.black,
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: const Text(
                      "Uygulama Kilidi",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.adaptive.arrow_forward),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(child: Text('Verileri Temizle')),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                InkWell(
                                  onTap: _clearExpenseList,
                                  child: ListTile(
                                    title: Text("Giderleri Temizle"),
                                    trailing:
                                        Icon(Icons.adaptive.arrow_forward),
                                  ),
                                ),
                                InkWell(
                                  onTap: _clearIncomesList,
                                  child: ListTile(
                                    title: Text("Gelirleri Temizle"),
                                    trailing:
                                        Icon(Icons.adaptive.arrow_forward),
                                  ),
                                ),
                                InkWell(
                                  onTap: _clearNotificationsList,
                                  child: ListTile(
                                    title: Text("Geçmişi Temizle"),
                                    trailing:
                                        Icon(Icons.adaptive.arrow_forward),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _clearAppPreferences();
                                    _readAppPreferences();
                                  },
                                  child: ListTile(
                                    title:
                                        Text("Uygulama Terchilerini Temizle"),
                                    trailing:
                                        Icon(Icons.adaptive.arrow_forward),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    iconColor: Colors.black,
                    leading: const Icon(Icons.cleaning_services),
                    title: const Text(
                      "Verileri temizle",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.adaptive.arrow_forward),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    log("TODO : Gizlilik Bölümü Eklenecek");
                  },
                  child: ListTile(
                    iconColor: Colors.black,
                    leading: const Icon(Icons.lock_outline),
                    title: const Text(
                      "Gizlilik Şartları",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.adaptive.arrow_forward),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(child: Text('Dil Seçenekleri')),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _appPreferencesModel =
                                          AppPreferencesModel(
                                              theme: _switchSelected,
                                              language: "en");
                                    });
                                    await _writeToAppPreferences(
                                        _appPreferencesModel);
                                  },
                                  child: ListTile(
                                    leading: Image.asset(
                                      'assets/en.png',
                                      height: 25,
                                      width: 40,
                                    ),
                                    title: Text("English"),
                                    trailing:
                                        Icon(Icons.adaptive.arrow_forward),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _appPreferencesModel =
                                          AppPreferencesModel(
                                              theme: _switchSelected,
                                              language: "tr");
                                    });
                                    await _writeToAppPreferences(
                                        _appPreferencesModel);
                                  },
                                  child: ListTile(
                                    leading: Image.asset(
                                      'assets/tr.png',
                                      height: 25,
                                      width: 40,
                                    ),
                                    title: Text("Türkçe"),
                                    trailing:
                                        Icon(Icons.adaptive.arrow_forward),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    iconColor: Colors.black,
                    leading: const Icon(Icons.language),
                    title: const Text(
                      "Dil Ayarları",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.adaptive.arrow_forward),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    log("TODO : Destek Bölümü Eklenecek");
                  },
                  child: ListTile(
                    iconColor: Colors.black,
                    leading: const Icon(Icons.support_outlined),
                    title: const Text(
                      "Yardım",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.adaptive.arrow_forward),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    log("TODO : Hakkında Bölümü Eklenecek");
                  },
                  child: ListTile(
                    iconColor: Colors.black,
                    leading: const Icon(Icons.info_outline),
                    title: const Text(
                      "Hakkında",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.adaptive.arrow_forward),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: InkWell(
                  onTap: () {
                    log("TODO : Paylaş Bölümü Eklenecek");
                  },
                  child: ListTile(
                    iconColor: Colors.black,
                    leading: const Icon(Icons.share_outlined),
                    title: const Text(
                      "Uygulamayı Paylaş",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.adaptive.arrow_forward),
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
