import 'dart:ui';

import 'package:flutter/material.dart';



class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();

}

class Language {
  int id;
  String name;

  Language(this.id, this.name);

  static List<Language> getLanguages(){
    return <Language> [
      Language(1, "Slovenščina"),
      Language(2, "English"),
    ];

  }
}


class _SettingsState extends State<Settings> {
  List<bool> variables = [false,false,false];
  List<Language> languages = Language.getLanguages();
  List<DropdownMenuItem<Language>> dropDownMenuItems;
  Language selectedLangauge;

  @override
  void initState() {
      dropDownMenuItems = buildMenuItems(languages);
      selectedLangauge = dropDownMenuItems[0].value;
      super.initState();
  }

  List<DropdownMenuItem<Language>> buildMenuItems(List langs){
     List<DropdownMenuItem<Language>> items = [];
     for(Language lang in langs) {
        items.add(DropdownMenuItem(
          value: lang,
          child: Text(lang.name),

        ));
     }
    return items;
  }

  onChangeDropdownItem(Language selLangs) {
      setState(() {
        selectedLangauge = selLangs;
      });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nastavitve"),
          backgroundColor: Colors.blue,
        ),
        body: Container(

          padding:
              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),

          child: Column(


            crossAxisAlignment: CrossAxisAlignment.start,
          
            children: <Widget>[ 
              Row( 
                children: <Widget>[
                Text("Jezik: ", style: new TextStyle(fontSize: 20),),
                 SizedBox(width: 150),
                DropdownButton<Language>(
                      value: selectedLangauge,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      underline: SizedBox(),
                      items: dropDownMenuItems, 
                      onChanged: onChangeDropdownItem, 
                ),
                ]
              ), 
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: variables[0],
                title: Text("Notifications:", style: new TextStyle(fontSize: 20),),
                onChanged: (bool value) {
                  setState(() {
                    variables[0] = value;
                  });
                },
              ),
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: variables[1],
                title: Text("Avtomatsko pošiljanje hroščev na strežnik:", style: new TextStyle(fontSize: 20),),
                onChanged: (bool value) {
                  setState(() {
                    variables[1] = value;
                  });
                },
              ),
              SwitchListTile(
                activeColor: Colors.blue,
                contentPadding: const EdgeInsets.all(0),
                value: variables[2],
                title: Text("Uporabi mojo lokacijo:", style: new TextStyle(fontSize: 20),),
                onChanged: (bool value) {
                  setState(() {
                    variables[2] = value;
                  });
                },
              ),

            ]
          ),
          ),
        );
  }
}
