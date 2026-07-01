import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wikixm/constants/images.dart';

class AppCacheImage extends StatelessWidget {
  final String imageUrl;
  final String? errorImage;
  final double size;
  final double widthSize;
  final BoxFit? fit;
  final BoxFit? errorFit;
  final bool? isCircle;
  final double? radius;
  final bool? isShimmer;
  final bool? isShadow;
  final Color? borderColor;

  const AppCacheImage({
    super.key,
    required this.imageUrl,
    this.errorImage,
    this.widthSize = 180,
    this.size = 65,
    this.fit,
    this.errorFit,
    this.radius,
    this.isCircle,
    this.isShadow,
    this.borderColor,
    this.isShimmer = false,
  });

  List<BoxShadow> get _shadow => isShadow == false
      ? []
      : [
    BoxShadow(
      color: Colors.grey.shade700.withValues(alpha: 0.25),
      blurRadius: 2,
      spreadRadius: 1,
      offset: const Offset(0, 0),
    ),
  ];

  String _normalizeSource(String value) => value.trim();

  bool _isAssetPath(String value) =>
      value.startsWith('assets/') || value.startsWith('packages/');

  bool _isNetworkUrl(String value) {
    final uri = Uri.tryParse(value);
    if (uri == null) return false;
    return uri.scheme == 'http' || uri.scheme == 'https';
  }

  bool _isSvgPath(String value) => value.toLowerCase().endsWith('.svg');

  String _resolveSafeFallbackSource() {
    final rawFallback = _normalizeSource(errorImage ?? '');
    if (rawFallback.isEmpty) {
      return Images.invite;
    }
    if (_isNetworkUrl(rawFallback) || _isAssetPath(rawFallback)) {
      return rawFallback;
    }
    return Images.invite;
  }

  Widget _shimmerBox() {
    return Shimmer.fromColors(
      baseColor: isShimmer == true ? Colors.grey.shade300 : Colors.transparent,
      highlightColor: isShimmer == true
          ? Colors.grey.shade100
          : Colors.transparent,
      child: Container(
        height: size,
        width: widthSize,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle == true
              ? null
              : BorderRadius.circular(radius ?? 4),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration({ImageProvider? provider}) {
    return BoxDecoration(
      boxShadow: _shadow,
      shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: isCircle == true
          ? null
          : BorderRadius.circular(radius ?? 4),
      border: borderColor != null
          ? Border.all(color: borderColor!, width: 0.4)
          : null,
      image: provider != null
          ? DecorationImage(image: provider, fit: fit ?? BoxFit.cover)
          : null,
    );
  }

  Widget _clipToShape(Widget child) {
    if (isCircle == true) {
      return ClipOval(child: child);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 4),
      child: child,
    );
  }

  Widget _assetWidget({
    required String assetPath,
    required double width,
    required double height,
    required BoxFit resolvedFit,
  }) {


    return _clipToShape(
      SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          assetPath,
          fit: resolvedFit,
          height: height,
          width: width,
        ),
      ),
    );
  }

  Widget _buildFallbackContainer({
    required double width,
    required double height,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: _shadow,
        shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle == true
            ? null
            : BorderRadius.circular(radius ?? 4),
        border: Border.all(
          color: borderColor ?? Colors.grey.shade400,
          width: 0.4,
        ),
      ),
      child: _fallbackWidget(width: width, height: height),
    );
  }

  Widget _fallbackWidget({required double width, required double height}) {
    final fallback = _resolveSafeFallbackSource();
    final bool isSvgAsset = _isSvgPath(fallback);
    final bool isNetworkFallback = _isNetworkUrl(fallback);
    final resolvedFit = errorFit ?? fit ?? BoxFit.cover;
    if (isNetworkFallback) {

      return _clipToShape(
        CachedNetworkImage(
          imageUrl: fallback,
          width: width,
          height: height,
          fit: resolvedFit,
          errorWidget: (context, fbUrl, fbErr) {
             return Image.asset(
              Images.invite,
              fit: BoxFit.contain,
              height: height,
              width: width,
            );
          },
        ),
      );
    }
    return _assetWidget(
      assetPath: isSvgAsset ? fallback : fallback,
      width: width,
      height: height,
      resolvedFit: resolvedFit,
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      final double safeWidth = widthSize.isFinite ? widthSize : 1;
      final double safeHeight = size.isFinite ? size : 1;
      final normalizedImageUrl = _normalizeSource(imageUrl);

      if (normalizedImageUrl.isEmpty) {
        return _buildFallbackContainer(width: safeWidth, height: safeHeight);
      }

      if (_isAssetPath(normalizedImageUrl)) {
        return _assetWidget(
          assetPath: normalizedImageUrl,
          width: safeWidth,
          height: safeHeight,
          resolvedFit: fit ?? BoxFit.cover,
        );
      }

      if (!_isNetworkUrl(normalizedImageUrl)) {
        return _buildFallbackContainer(width: safeWidth, height: safeHeight);
      }


      return CachedNetworkImage(
        height: safeHeight,
        width: safeWidth,
        memCacheHeight: safeHeight.toInt(),
        memCacheWidth: safeWidth.toInt(),
        imageUrl: normalizedImageUrl,
        cacheKey: normalizedImageUrl,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => _shimmerBox(),
        imageBuilder: (context, imageProvider) {
          return Container(
            height: safeHeight,
            width: safeWidth,
            decoration: _boxDecoration(provider: imageProvider),
          );
        },
        errorWidget: (context, url, error) {
          return _buildFallbackContainer(width: safeWidth, height: safeHeight);
        },
      );
    } catch (e, st) {
      debugPrint('Error in WikixmCacheImage build: $e\n$st');
      return Container(
        height: size,
        width: widthSize,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          boxShadow: _shadow,
        ),
      );
    }
  }
}
