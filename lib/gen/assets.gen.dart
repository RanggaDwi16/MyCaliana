/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/avatar.jpg
  AssetGenImage get avatar => const AssetGenImage('assets/images/avatar.jpg');

  /// File path: assets/images/illustration1.jpg
  AssetGenImage get illustration1Jpg =>
      const AssetGenImage('assets/images/illustration1.jpg');

  /// File path: assets/images/illustration1.png
  AssetGenImage get illustration1Png =>
      const AssetGenImage('assets/images/illustration1.png');

  /// File path: assets/images/illustration2.jpg
  AssetGenImage get illustration2Jpg =>
      const AssetGenImage('assets/images/illustration2.jpg');

  /// File path: assets/images/illustration2.png
  AssetGenImage get illustration2Png =>
      const AssetGenImage('assets/images/illustration2.png');

  /// File path: assets/images/illustration3.jpg
  AssetGenImage get illustration3Jpg =>
      const AssetGenImage('assets/images/illustration3.jpg');

  /// File path: assets/images/illustration3.png
  AssetGenImage get illustration3Png =>
      const AssetGenImage('assets/images/illustration3.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_caliana.png
  AssetGenImage get logoCaliana =>
      const AssetGenImage('assets/images/logo_caliana.png');

  /// File path: assets/images/mycaliana.png
  AssetGenImage get mycaliana =>
      const AssetGenImage('assets/images/mycaliana.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        avatar,
        illustration1Jpg,
        illustration1Png,
        illustration2Jpg,
        illustration2Png,
        illustration3Jpg,
        illustration3Png,
        logo,
        logoCaliana,
        mycaliana
      ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
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
