import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:fluttermoji/fluttermoji_assets/fluttermojimodel.dart';
import 'package:get/get.dart';
import 'package:star_wars_filmes_personagens/controller/avatar_controller.dart';
import 'package:star_wars_filmes_personagens/model/avatar_model.dart';
import 'package:star_wars_filmes_personagens/model/avatar_repository.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// This widget provides a UI for customizing the Fluttermoji
///
/// Accepts a [outerTextTitle] which defaults to "Customize:"
///
/// Accepts an optional [scaffoldHeight] and [scaffoldWidth].
/// When using in landscape mode, it is advised to pass a [scaffoldWidth] to the widget
///
/// Adapts to the enclosing MaterialApp's dark theme settings
///
/// It is advised that a [FluttermojiCircleAvatar] also be present in the same page.
class AlternativeFluttermojiCustomizer extends StatefulWidget {
  final String outerTitleText;
  final double scaffoldHeight;
  final double scaffoldWidth;
  AlternativeFluttermojiCustomizer(
      {Key? key,
        this.outerTitleText = 'Editar:',
        this.scaffoldHeight = 0.0,
        this.scaffoldWidth = 0.0})
      : super(key: key);

  @override
  _AlternativeFluttermojiCustomizerState createState() => _AlternativeFluttermojiCustomizerState();
}

class _AlternativeFluttermojiCustomizerState extends State<AlternativeFluttermojiCustomizer>
    with SingleTickerProviderStateMixin {

  AvatarController _avatarController = AvatarController(AvatarRepository());

  late FluttermojiController fluttermojiController;
  late TabController tabController;
  var heightFactor = 0.4;
  var widthFactor = 0.95;

  @override
  void initState() {
    super.initState();
    var _fluttermojiController;
    Get.put(FluttermojiController());
    _fluttermojiController = Get.find<FluttermojiController>();
    setState(() {
      tabController = TabController(length: 11, vsync: this);
      fluttermojiController = _fluttermojiController;
    });
  }

  @override
  void dispose() {
    // This ensures that unsaved edits are reverted
    fluttermojiController.restoreState();
    super.dispose();
  }

  /// Widget that renders an expanded layout for customization
  /// Accepts a [cardTitle] and a [attributes].
  ///
  /// [attribute] is an object with the fields attributeName and attributeKey
  Widget expandedCard(
      {required String cardTitle,
        required List<ExpandedFluttermojiCardItem> attributes}) {
    var size = MediaQuery.of(context).size;

    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var iconColor = (!isDarkMode) ? Colors.grey[600] : Colors.white;
    //final double mediumfont = size.height * 0.038;
    var attributeRows = <Widget>[];
    var navbarWidgets = <Widget>[];
    var _appbarcolor = (!isDarkMode) ? Colors.white : Colors.grey[600];
    var _bgcolor = (!isDarkMode) ? Color(0xFFF1F1F1) : Colors.grey[800];

    attributes.forEach((attribute) {
      if (!fluttermojiController.selectedIndexes.containsKey(attribute.key)) {
        fluttermojiController.selectedIndexes[attribute.key] = 0;
      }
      var attributeListLength =
          fluttermojiProperties[attribute.key!]!.property!.length;
      var gridCrossAxisCount = 4;
      int? i = fluttermojiController.selectedIndexes[attribute.key];
      if (attributeListLength < 12)
        gridCrossAxisCount = 3;
      else if (attributeListLength < 9) gridCrossAxisCount = 2;
      Widget bottomNavWidget = Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
          child: SvgPicture.asset(
            attribute.iconAsset!,
            package: 'fluttermoji',
            height: (attribute.iconsize == 0)
                ? widget.scaffoldHeight > 0
                ? widget.scaffoldHeight / heightFactor * 0.03
                : size.height * 0.03
                : attribute.iconsize,
            color: iconColor,
            semanticsLabel: attribute.title,
          ));

      Widget _row = Column(children: [
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            color: _appbarcolor,
            child: Center(
              child: Text(
                attribute.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: widget.scaffoldHeight > 0
                      ? widget.scaffoldHeight / heightFactor * 0.024
                      : size.height * 0.024,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 11,
          // height: size.height*0.25,
          child: GridView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: attributeListLength,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCrossAxisCount,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              if (index == i) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.green,
                      width: 3.0,
                    ),
                  ),
                  child: SvgPicture.string(
                    fluttermojiController.getComponentSVG(attribute.key, i),
                    height: 20,
                    semanticsLabel: "Your Fluttermoji",
                    placeholderBuilder: (context) => Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                );
              }

              return InkWell(
                onTap: () {
                  fluttermojiController.selectedIndexes[attribute.key] = index;
                  fluttermojiController.updatePreview();
                  setState(() {});
                },
                child: SvgPicture.string(
                  fluttermojiController.getComponentSVG(attribute.key, index),
                  height: 20,
                  semanticsLabel: 'Your Fluttermoji',
                  placeholderBuilder: (context) => Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              );
            },
          ),
        ),
      ]);
      attributeRows.add(_row);
      navbarWidgets.add(bottomNavWidget);
    });

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: widget.scaffoldWidth > 0
                ? widget.scaffoldWidth * widthFactor
                : size.width * widthFactor,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: DefaultTabController(
              length: attributeRows.length,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Scaffold(
                  key: ValueKey('FMojiCustomizer'),
                  backgroundColor: _bgcolor,
                  body: TabBarView(
                      physics: ClampingScrollPhysics(),
                      controller: tabController,
                      children: attributeRows),
                  bottomNavigationBar: Container(
                    color: _appbarcolor, //Colors.grey[400],
                    child: TabBar(
                        controller: tabController,
                        isScrollable: true,
                        labelPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        indicatorColor: Colors.blue,
                        indicatorPadding: EdgeInsets.all(2),
                        tabs: navbarWidgets),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.9, -1),
          child: Visibility(
            visible: !(tabController.length == tabController.index + 1),
            child: IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
                size: widget.scaffoldHeight > 0
                    ? widget.scaffoldHeight / heightFactor * 0.025
                    : size.height * 0.025,
              ),
              onPressed: () {
                var _currentIndex = tabController.index;
                tabController.animateTo(_currentIndex < tabController.length
                    ? _currentIndex + 1
                    : _currentIndex);
                setState(() {});
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment(-0.9, -1),
          child: Visibility(
            visible: !(tabController.index == 0),
            child: IconButton(
              splashRadius: 20,
              icon: Icon(
                Icons.arrow_back_ios,
                color: iconColor,
                size: widget.scaffoldHeight > 0
                    ? widget.scaffoldHeight / heightFactor * 0.025
                    : size.height * 0.025,
              ),
              onPressed: () {
                int _currentIndex = tabController.index;
                tabController.animateTo(_currentIndex < tabController.length
                    ? _currentIndex - 1
                    : _currentIndex);
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color? iconColor = (!isDarkMode) ? Colors.grey[700] : Colors.white;
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.outerTitleText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: widget.scaffoldHeight > 0
                          ? widget.scaffoldHeight / heightFactor * 0.03
                          : size.height * 0.03,
                      fontWeight: FontWeight.w700),
                ),
                IconButton(
                  onPressed: () async {
                    fluttermojiController.setFluttermoji();

                    // salvando emoji em banco de dados local
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    _avatarController.save(AvatarModel(pref.getString('fluttermoji')!));

                    setState(() {});
                  },
                  icon: Icon(
                    Icons.save,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: widget.scaffoldHeight > 0
                ? widget.scaffoldHeight
                : size.height * heightFactor,
            width: widget.scaffoldWidth > 0 ? widget.scaffoldWidth : size.width,
            child: expandedCard(cardTitle: "Customize", attributes: [
              /*  ExpandedFluttermojiCardItem(
                        iconAsset: "attributeicons/hair.svg",
                        title: "Fluttermoji Style",
                        key: "style"), */
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/hair.svg",
                  title: "Cabelo",
                  key: "topType"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/haircolor.svg",
                  title: "Cor do Cabelo",
                  key: "hairColor"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/beard.svg",
                  title: "Barba e Bigode",
                  key: "facialHairType"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/beardcolor.svg",
                  title: "Cor da Barba",
                  key: "facialHairColor"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/outfit.svg",
                  title: "Roupa",
                  key: "clotheType"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/outfitcolor.svg",
                  title: "Cor da Roupa",
                  key: "clotheColor"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/eyes.svg",
                  title: "Olhos",
                  key: "eyeType"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/eyebrow.svg",
                  title: "Sobrancelhas",
                  key: "eyebrowType"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/mouth.svg",
                  title: "Boca",
                  key: "mouthType"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/skin.svg",
                  title: "Pele",
                  key: "skinColor"),
              ExpandedFluttermojiCardItem(
                  iconAsset: "attributeicons/accessories.svg",
                  title: "Óculos",
                  key: "accessoriesType"),
            ]),
          )
        ]);
  }
}
