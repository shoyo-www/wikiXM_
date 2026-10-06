import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wikixm/constants/images.dart';

class AppCacheImage extends StatelessWidget {
  final String imageUrl;
  final String? errorImage;
  final double size;
  final double widthSize;
  final BoxFit? fit;
  final BoxFit? errorFit;
  final Alignment alignment;

  final bool? isCircle;
  final double? radius;
  final bool? isShimmer;
  final bool? isShadow;
  final Color? borderColor;
  final Color? color;
  final double? borderWidth;

  const AppCacheImage({super.key, this.borderWidth,required this.imageUrl, this.errorImage, this.widthSize = 180, this.size = 65, this.fit, this.errorFit, this.alignment = Alignment.center, this.radius, this.isCircle, this.isShadow, this.borderColor, this.isShimmer = false, this.color});

  static Set<String> authRequiredHosts = <String>{'staging.wikixm.com'};

  static Map<String, String> get _basicAuthHeaders {
    const username = 'staging';
    const password = r'XeRfYrA$Japan';

    final credentials = base64Encode(utf8.encode('$username:$password'));

    return {'Authorization': 'Basic $credentials'};
  }

  Map<String, String>? _resolveHeaders(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (authRequiredHosts.contains(uri.host)) {
      return _basicAuthHeaders;
    }
    if (uri.host == 'wikixm-staging.s3.us-west-2.amazonaws.com') {
      return null;
    }
    return null;
  }

  List<BoxShadow> get _shadow => isShadow == false ? [] : [BoxShadow(color: Colors.grey.shade700.withValues(alpha: 0.25), blurRadius: 2, spreadRadius: 1, offset: const Offset(0, 0))];

  String _normalizeSource(String value) => value.trim();

  bool _isAssetPath(String value) => value.startsWith('assets/') || value.startsWith('packages/');

  bool _isNetworkUrl(String value) {
    final uri = Uri.tryParse(value);
    if (uri == null) return false;
    return uri.scheme == 'http' || uri.scheme == 'https';
  }

  bool _isSvgPath(String value) {
    final cleanPath = value.split('?').first.split('#').first;
    return cleanPath.toLowerCase().endsWith('.svg');
  }

  String _resolveSafeFallbackSource() {
    final fallback = _normalizeSource(errorImage ?? '');
    if (fallback.isEmpty) {
      return Images.invite;
    }
    if (_isNetworkUrl(fallback) || _isAssetPath(fallback)) {
      return fallback;
    }
    return Images.invite;
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: isShimmer == true ? Colors.grey.shade300 : Colors.transparent,
      highlightColor: isShimmer == true ? Colors.grey.shade100 : Colors.transparent,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: Colors.white, shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle, borderRadius: isCircle == true ? null : BorderRadius.circular(radius ?? 4)),
      ),
    );
  }

  Widget _clipToShape(Widget child) {
    if (isCircle == true) {
      return ClipOval(child: child);
    }
    return ClipRRect(borderRadius: BorderRadius.circular(radius ?? 4), child: child);
  }

  Widget _withDecoration({required double width, required double height, required Widget child}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: _shadow,
        shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle == true ? null : BorderRadius.circular(radius ?? 4),
        border: borderColor != null ? Border.all(color: borderColor!, width: isCircle == true ? 1.5 : 0.4) : null,
      ),
      child: _clipToShape(child),
    );
  }

  Widget _assetWidget({required String assetPath, required double width, required double height, required BoxFit resolvedFit}) {
    final bool isSvg = _isSvgPath(assetPath);

    return _withDecoration(
      width: width,
      height: height,
      child: isSvg
          ? SvgPicture.asset(assetPath, width: width, height: height, fit: resolvedFit, alignment: alignment, color: color)
          : Image.asset(
              assetPath,
              width: width,
              height: height,
              fit: resolvedFit,
              alignment: alignment,
              errorBuilder: (context, error, stackTrace) {
                return _defaultFallback(width: width, height: height);
              },
            ),
    );
  }

  Widget _networkSvg({required String url, required double width, required double height, required BoxFit resolvedFit}) {
    return _withDecoration(
      width: width,
      height: height,
      child: SvgPicture.network(
        url,
        width: width,
        height: height,
        headers: _resolveHeaders(url),
        fit: resolvedFit,
        alignment: alignment,
        color: color,
        placeholderBuilder: (context) {
          return _shimmerBox(width: width, height: height);
        },
      ),
    );
  }

  Widget _defaultFallback({required double width, required double height}) {
    if (_isSvgPath(Images.invite)) {
      return SvgPicture.asset(Images.invite, width: width, height: height, color: color, fit: errorFit ?? BoxFit.contain, alignment: alignment);
    }

    return Image.asset(Images.invite, width: width, height: height, fit: errorFit ?? BoxFit.contain, alignment: alignment);
  }

  Widget _fallbackWidget({required double width, required double height}) {
    final fallback = _resolveSafeFallbackSource();

    final resolvedFit = errorFit ?? fit ?? BoxFit.cover;

    final bool isNetwork = _isNetworkUrl(fallback);
    final bool isSvg = _isSvgPath(fallback);

    if (isNetwork && isSvg) {
      return SvgPicture.network(
        fallback,
        width: width,
        height: height,

        // BASIC AUTH (only applied if host is in authRequiredHosts)
        headers: _resolveHeaders(fallback),

        fit: resolvedFit,
        alignment: alignment,
        color: color,
        placeholderBuilder: (context) {
          return _shimmerBox(width: width, height: height);
        },
      );
    }

    if (isNetwork) {
      return CachedNetworkImage(
        imageUrl: fallback,
        width: width,
        height: height,

        // BASIC AUTH (only applied if host is in authRequiredHosts)
        httpHeaders: _resolveHeaders(fallback),

        fit: resolvedFit,
        alignment: alignment,
        placeholder: (context, url) {
          return _shimmerBox(width: width, height: height);
        },
        errorWidget: (context, url, error) {
          return _defaultFallback(width: width, height: height);
        },
      );
    }

    if (isSvg) {
      return SvgPicture.asset(fallback, width: width, height: height, color: color, fit: resolvedFit, alignment: alignment);
    }

    return Image.asset(
      fallback,
      width: width,
      height: height,
      fit: resolvedFit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        return _defaultFallback(width: width, height: height);
      },
    );
  }

  Widget _buildFallbackContainer({required double width, required double height}) {
    return _withDecoration(
      width: width,
      height: height,
      child: _fallbackWidget(width: width, height: height),
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      final double safeWidth = widthSize.isFinite && widthSize > 0 ? widthSize : 1;

      final double safeHeight = size.isFinite && size > 0 ? size : 1;

      final normalizedImageUrl = _normalizeSource(imageUrl);

      final resolvedFit = fit ?? BoxFit.cover;

      if (normalizedImageUrl.isEmpty) {
        return _buildFallbackContainer(width: safeWidth, height: safeHeight);
      }

      if (_isAssetPath(normalizedImageUrl)) {
        return _assetWidget(assetPath: normalizedImageUrl, width: safeWidth, height: safeHeight, resolvedFit: resolvedFit);
      }

      if (!_isNetworkUrl(normalizedImageUrl)) {
        return _buildFallbackContainer(width: safeWidth, height: safeHeight);
      }

      if (_isSvgPath(normalizedImageUrl)) {
        return _networkSvg(url: normalizedImageUrl, width: safeWidth, height: safeHeight, resolvedFit: resolvedFit);
      }

      return CachedNetworkImage(
        height: safeHeight,
        width: safeWidth,
        memCacheHeight: safeHeight.toInt(),
        memCacheWidth: safeWidth.toInt(),
        imageUrl: normalizedImageUrl,
        cacheKey: normalizedImageUrl,

        // BASIC AUTH - only applied if host is in authRequiredHosts
        httpHeaders: _resolveHeaders(normalizedImageUrl),

        fit: resolvedFit,
        alignment: alignment,

        placeholder: (context, url) {
          return _shimmerBox(width: safeWidth, height: safeHeight);
        },

        imageBuilder: (context, imageProvider) {
          return Container(
            width: safeWidth,
            height: safeHeight,
            decoration: BoxDecoration(
              boxShadow: _shadow,
              shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircle == true ? null : BorderRadius.circular(radius ?? 4),
              border: borderColor != null ? Border.all(color: borderColor!, width: isCircle == true ? 1.5 : borderWidth ?? 0.5) : null,
              image: DecorationImage(image: imageProvider, fit: resolvedFit, alignment: alignment),
            ),
          );
        },

        errorWidget: (context, url, error) {
          debugPrint('Image loading error: $url');
          debugPrint('Error: $error');

          return _buildFallbackContainer(width: safeWidth, height: safeHeight);
        },
      );
    } catch (e, st) {
      debugPrint('Error in AppCacheImage: $e\n$st');

      return Container(
        height: size,
        width: widthSize,
        decoration: BoxDecoration(color: Colors.grey.shade300, boxShadow: _shadow),
      );
    }
  }
}
