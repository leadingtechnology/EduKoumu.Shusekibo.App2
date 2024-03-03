/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsEnvGen {
  const $AssetsEnvGen();

  /// File path: assets/env/.env.development
  String get envDevelopment => 'assets/env/.env.development';

  /// File path: assets/env/.env.production
  String get envProduction => 'assets/env/.env.production';

  /// File path: assets/env/.env.staging
  String get envStaging => 'assets/env/.env.staging';

  /// List of all assets
  List<String> get values => [envDevelopment, envProduction, envStaging];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/default_pkg_icon.png
  AssetGenImage get defaultPkgIcon =>
      const AssetGenImage('assets/icons/default_pkg_icon.png');

  /// File path: assets/icons/koumu.png
  AssetGenImage get koumu => const AssetGenImage('assets/icons/koumu.png');

  /// File path: assets/icons/koumu5.png
  AssetGenImage get koumu5 => const AssetGenImage('assets/icons/koumu5.png');

  /// File path: assets/icons/koumu6.png
  AssetGenImage get koumu6 => const AssetGenImage('assets/icons/koumu6.png');

  /// File path: assets/icons/koumu7.png
  AssetGenImage get koumu7 => const AssetGenImage('assets/icons/koumu7.png');

  /// File path: assets/icons/notfound.png
  AssetGenImage get notfound =>
      const AssetGenImage('assets/icons/notfound.png');

  /// File path: assets/icons/seito.png
  AssetGenImage get seito => const AssetGenImage('assets/icons/seito.png');

  /// File path: assets/icons/seito1.png
  AssetGenImage get seito1 => const AssetGenImage('assets/icons/seito1.png');

  /// File path: assets/icons/seito2.png
  AssetGenImage get seito2 => const AssetGenImage('assets/icons/seito2.png');

  /// File path: assets/icons/seito3.png
  AssetGenImage get seito3 => const AssetGenImage('assets/icons/seito3.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        defaultPkgIcon,
        koumu,
        koumu5,
        koumu6,
        koumu7,
        notfound,
        seito,
        seito1,
        seito2,
        seito3
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/login_page_logo.png
  AssetGenImage get loginPageLogo =>
      const AssetGenImage('assets/images/login_page_logo.png');

  /// File path: assets/images/login_page_logo2.png
  AssetGenImage get loginPageLogo2 =>
      const AssetGenImage('assets/images/login_page_logo2.png');

  /// File path: assets/images/login_page_picture.png
  AssetGenImage get loginPagePicture =>
      const AssetGenImage('assets/images/login_page_picture.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [loginPageLogo, loginPageLogo2, loginPagePicture];
}

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/lang/en.json
  String get en => 'assets/lang/en.json';

  /// File path: assets/lang/ja.json
  String get ja => 'assets/lang/ja.json';

  /// List of all assets
  List<String> get values => [en, ja];
}

class Assets {
  Assets._();

  static const AssetGenImage appLogo = AssetGenImage('assets/app_logo.png');
  static const $AssetsEnvGen env = $AssetsEnvGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLangGen lang = $AssetsLangGen();

  /// List of all assets
  List<AssetGenImage> get values => [appLogo];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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
