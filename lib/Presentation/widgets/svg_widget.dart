import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class SpriteSvgIcon extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? color;

  const SpriteSvgIcon({super.key, required this.url, this.width, this.height, this.color});

  static final Map<String, String> _cache = {};

  static const Set<String> authRequiredHosts = {'staging.wikixm.com'};

  static Map<String, String> get _basicAuthHeaders {
    const username = 'staging';
    const password = r'XeRfYrA$Japan';

    final credentials = base64Encode(utf8.encode('$username:$password'));

    return {'Authorization': 'Basic $credentials'};
  }

  static Map<String, String>? _resolveHeaders(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (authRequiredHosts.contains(uri.host)) return _basicAuthHeaders;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return SizedBox(width: width, height: height);
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      return SizedBox(width: width, height: height);
    }

    final symbolId = uri.fragment;
    if (symbolId.isEmpty) {
      return SizedBox(width: width, height: height);
    }

    final spriteUrl = uri.replace(fragment: '').toString();

    return FutureBuilder<String>(
      future: _loadSvgSymbol(spriteUrl, symbolId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(width: width, height: height);
        }

        if (snapshot.hasError) {
          debugPrint('SVG ERROR [$symbolId]: ${snapshot.error}');
          return SizedBox(width: width, height: height);
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(width: width, height: height);
        }
        final ambientColor = color ?? IconTheme.of(context).color ?? DefaultTextStyle.of(context).style.color ?? Colors.black;

        return SvgPicture.string(
          snapshot.data!,
          width: width,
          height: height,
          fit: BoxFit.contain,
          theme: SvgTheme(currentColor: ambientColor),
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      },
    );
  }

  static Future<String> _loadSvgSymbol(String spriteUrl, String symbolId) async {
    final cacheKey = '$spriteUrl#$symbolId';

    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    debugPrint('Loading SVG: $spriteUrl');
    debugPrint('Symbol: $symbolId');

    final headers = _resolveHeaders(spriteUrl);

    final response = await http.get(Uri.parse(spriteUrl), headers: headers);

    debugPrint('SVG STATUS [$symbolId]: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load SVG: ${response.statusCode}');
    }

    if (response.body.isEmpty) {
      throw Exception('SVG response is empty');
    }
    final document = XmlDocument.parse(response.body);
    final cssRules = _parseCssRules(document);
    if (cssRules.isNotEmpty) {
      _inlineCssClasses(document.rootElement, cssRules);
    }

    XmlElement? symbol;
    for (final item in document.findAllElements('symbol')) {
      if (item.getAttribute('id') == symbolId) {
        symbol = item;
        break;
      }
    }

    if (symbol == null) {
      debugPrint('Available SVG symbols:');
      for (final item in document.findAllElements('symbol')) {
        debugPrint(' - ${item.getAttribute('id')}');
      }
      throw Exception('SVG symbol "$symbolId" not found');
    }

    final viewBox = symbol.getAttribute('viewBox');
    final widthAttribute = symbol.getAttribute('width');
    final heightAttribute = symbol.getAttribute('height');
    final fill = symbol.getAttribute('fill');
    final stroke = symbol.getAttribute('stroke');
    final strokeWidth = symbol.getAttribute('stroke-width');
    final sharedDefs = document.findAllElements('defs').map((e) => e.toXmlString()).join();

    final svg =
        '''
<svg
  xmlns="http://www.w3.org/2000/svg"
  ${viewBox != null ? 'viewBox="$viewBox"' : ''}
  ${widthAttribute != null ? 'width="$widthAttribute"' : ''}
  ${heightAttribute != null ? 'height="$heightAttribute"' : ''}
  ${fill != null ? 'fill="$fill"' : ''}
  ${stroke != null ? 'stroke="$stroke"' : ''}
  ${strokeWidth != null ? 'stroke-width="$strokeWidth"' : ''}
>
  $sharedDefs
  ${symbol.innerXml}
</svg>
''';
    _cache[cacheKey] = svg;

    return svg;
  }

  static Map<String, Map<String, String>> _parseCssRules(XmlDocument document) {
    final rules = <String, Map<String, String>>{};

    final ruleBlockPattern = RegExp(r'([^{}]+)\{([^{}]+)\}');
    final classSelectorPattern = RegExp(r'\.([a-zA-Z0-9_-]+)');

    for (final styleEl in document.findAllElements('style')) {
      final css = styleEl.innerText;

      for (final match in ruleBlockPattern.allMatches(css)) {
        final selectors = match.group(1) ?? '';
        final body = match.group(2) ?? '';

        final declarations = <String, String>{};
        for (final decl in body.split(';')) {
          final parts = decl.split(':');
          if (parts.length != 2) continue;
          final prop = parts[0].trim();
          final value = parts[1].trim();
          if (prop.isEmpty || value.isEmpty) continue;
          if (prop == 'fill' || prop == 'stroke' || prop == 'stroke-width' || prop == 'opacity') {
            declarations[prop] = value;
          }
        }

        if (declarations.isEmpty) continue;

        for (final classMatch in classSelectorPattern.allMatches(selectors)) {
          final className = classMatch.group(1)!;
          rules.putIfAbsent(className, () => {}).addAll(declarations);
        }
      }
    }

    return rules;
  }

  static void _inlineCssClasses(XmlElement element, Map<String, Map<String, String>> rules) {
    final classAttr = element.getAttribute('class');

    if (classAttr != null && classAttr.trim().isNotEmpty) {
      for (final className in classAttr.trim().split(RegExp(r'\s+'))) {
        final declarations = rules[className];
        if (declarations == null) continue;

        declarations.forEach((prop, value) {
          if (element.getAttribute(prop) == null) {
            element.setAttribute(prop, value);
          }
        });
      }
    }

    for (final child in element.childElements) {
      _inlineCssClasses(child, rules);
    }
  }
}
