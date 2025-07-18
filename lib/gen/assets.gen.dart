/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  const Assets._();

  //Splash
  static const AssetGenImage splash = AssetGenImage("assets/images/splash.png");

  //QUIZZ level screen icons
  static const AssetGenImage verbsicon = AssetGenImage(
    'assets/icons/verb (1).png',
  );
  static const AssetGenImage subjecticon = AssetGenImage(
    'assets/icons/subjects.png',
  );
  static const AssetGenImage pronounsicon = AssetGenImage(
    'assets/icons/pronouns.png',
  );

  static const AssetGenImage which = AssetGenImage('assets/icons/which.png');

  static const AssetGenImage who = AssetGenImage('assets/icons/who.png');

  static const AssetGenImage noun = AssetGenImage('assets/icons/noun.png');

  static const AssetGenImage adjectives = AssetGenImage(
    'assets/icons/adjectives.png',
  );

  //ai translation history icon

  static const AssetGenImage aitranslationhistoryicon = AssetGenImage(
    'assets/icons/history.png',
  );

  static const AssetGenImage nointernet = AssetGenImage(
    'assets/icons/no-internet.png',
  );


  //-----------------------------------------------------------

//homeview icons

  static const AssetGenImage aicorrectionicon = AssetGenImage(
    'assets/icons/aicorrectoricon.png',
  );

  static const AssetGenImage paraphrasericon = AssetGenImage(
    'assets/icons/paraphrasericon.png',
  );

  static const AssetGenImage learngrammaricon = AssetGenImage(
    'assets/icons/learngrammar.png',
  );

  static const AssetGenImage askaiicon = AssetGenImage(
    'assets/icons/homeaskaiicon.png',
  );

  static const AssetGenImage topbannericon = AssetGenImage(
    'assets/icons/headerbanerwidget.png',
  );

  static const AssetGenImage bottombannericon = AssetGenImage(
    'assets/icons/bottombanerwidget.png',
  );

  static const AssetGenImage appIcon = AssetGenImage(
    'assets/icons/appicon.png',
  );

  //levels images
  static const AssetGenImage quizimagelevelone = AssetGenImage(
    'assets/icons/level-1.png',
  );

  static const AssetGenImage quizimageleveltwo = AssetGenImage(
    'assets/icons/level-2.png',
  );
  static const AssetGenImage quizimagelevelthree = AssetGenImage(
    'assets/icons/level-3.png',
  );



  static const AssetGenImage premiumscreenpic = AssetGenImage(
    'assets/images/premiumpic.png',
  );

  static const AssetGenImage premiumicon = AssetGenImage(
    'assets/icons/premium icon1.png',
  );


  //nav_bar_images
  static const AssetGenImage askai = AssetGenImage(
    'assets/icons/ask ai (2).png',
  );
  static const AssetGenImage home = AssetGenImage('assets/icons/home (2).png');
  static const AssetGenImage paraphraser = AssetGenImage(
    'assets/icons/urdu dictionary.png',
  );

  static const AssetGenImage correction = AssetGenImage(
    'assets/icons/ai dictionary.png',
  );
  static const AssetGenImage translator = AssetGenImage(
    'assets/icons/translator.png',
  );

  static const AssetGenImage crown = AssetGenImage('assets/icons/crown.png');
  static const AssetGenImage historyicon = AssetGenImage(
    'assets/icons/book.png',
  );
   
  static const AssetGenImage ai = AssetGenImage('assets/ai.png');
  static const AssetGenImage book2 = AssetGenImage('assets/book-2.png');
  static const AssetGenImage bookSale = AssetGenImage('assets/book-sale.png');
  static const AssetGenImage dictionary2 =
      AssetGenImage('assets/dictionary-2.png');
  static const AssetGenImage dictionary =
      AssetGenImage('assets/dictionary.png');
  static const AssetGenImage magicBook = AssetGenImage('assets/magic-book.png');
  static const AssetGenImage translate = AssetGenImage('assets/translate.png');


   
  /// List of all assets
  static List<AssetGenImage> get values =>

      [ai, book2, bookSale, dictionary2, dictionary, magicBook, translate];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
