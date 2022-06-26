import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:usainua/models/scrapping_model.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/helpers.dart';

class WebScrappingService {
  const WebScrappingService._();

  static String _webScrappingServiceUrl(WebCites webCite) {
    if (webCite == WebCites.amazon) return 'https://www.amazon.com';
    if (webCite == WebCites.ebay) return 'https://www.ebay.com';

    throw Exception('Web cite does not exist');
  }

  static String _webScrappingServiceSectionUrl({
    required WebsiteSections websiteSection,
    required WebCites webCite,
  }) {
    String webCiteUrl = _webScrappingServiceUrl(webCite);

    if (websiteSection == WebsiteSections.popular && webCite == WebCites.ebay) {
      return '$webCiteUrl/globaldeals/featured';
    }

    if (websiteSection == WebsiteSections.shoes && webCite == WebCites.ebay) {
      return '$webCiteUrl/sch/i.html?_from=R40&_trksid=m570.l1313&_nkw=shoes&_sacat=0';
    }

    if (websiteSection == WebsiteSections.clothes && webCite == WebCites.ebay) {
      return '$webCiteUrl/sch/i.html?_from=R40&_trksid=p2334524.m570.l1313&_nkw=clothes&_sacat=0&LH_TitleDesc=0&_odkw=electronic&_osacat=0';
    }

    if (websiteSection == WebsiteSections.electronics &&
        webCite == WebCites.ebay) {
      return '$webCiteUrl/sch/i.html?_from=R40&_trksid=p2334524.m570.l1313&_nkw=electronic&_sacat=0&LH_TitleDesc=0&_odkw=clothes&_osacat=0';
    }

    throw Exception('Link does not exist');
  }

  static Future<List<ScrappingModel>?> webScrappingServiceElements({
    required WebsiteSections websiteSection,
    required WebCites webCite,
  }) async {
    final String webCiteSectionUrl = _webScrappingServiceSectionUrl(
      webCite: webCite,
      websiteSection: websiteSection,
    );

    late List<ScrappingModel> scrappingModels;

    try {
      final Response response = await Dio().get(webCiteSectionUrl);
      final Document document = parse(response.data);

      if (response.statusCode == 200) {
        if (websiteSection == WebsiteSections.popular &&
            webCite == WebCites.ebay) {
          scrappingModels = _popularEbayPageParser(document);
        }
        if (websiteSection != WebsiteSections.popular &&
            webCite == WebCites.ebay) {
          scrappingModels = _defaultEbayPageParser(document);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return scrappingModels;
  }
}

List<ScrappingModel> _popularEbayPageParser(Document document) {
  List<ScrappingModel> scrappingModels = [];

  final Iterable<Element> items = document.querySelectorAll(
    'div[itemtype="https://schema.org/Product"]',
  );

  for (Element item in items) {
    final Element? child = item.querySelector('a[itemprop="url"]');
    final String name = item.text;
    final String? href = child?.attributes['href'];
    final Element? imageElement = child?.querySelector(
      'div.slashui-image-cntr > img',
    );

    String? photoUrl = imageElement?.attributes['src'];

    if (photoUrl == 'https://ir.ebaystatic.com/pictures/aw/pics/s_1x2.gif') {
      photoUrl = imageElement?.attributes['data-config-src'];
    }

    int? oldPrice = getIntFromString(
      item
          .querySelector(
            'span.itemtile-price-strikethrough',
          )
          ?.text,
    );
    int? currentPrice = getIntFromString(
      item
          .querySelector(
            'span[itemprop="price"]',
          )
          ?.text,
    );

    if (name.isNotEmpty &&
        href != null &&
        photoUrl != null &&
        currentPrice != null) {
      scrappingModels.add(
        ScrappingModel(
          title: name,
          url: href,
          photoUrl: photoUrl,
          oldPrice: oldPrice,
          currentPrice: currentPrice,
        ),
      );
    }
  }

  return scrappingModels;
}

List<ScrappingModel> _defaultEbayPageParser(Document document) {
  List<ScrappingModel> scrappingModels = [];

  final Iterable<Element> items = document.querySelectorAll(
    'ul.srp-results > li.s-item',
  );

  for (Element item in items) {
    final String? href = item
        .querySelector(
          'a.s-item__link',
        )
        ?.attributes['href'];

    final String? photoUrl = item
        .querySelector(
          'img.s-item__image-img',
        )
        ?.attributes['src'];

    final Element? descriptionElement = item.querySelector(
      'div.s-item__info',
    );

    final String? title = descriptionElement
        ?.querySelector(
          'h3.s-item__title',
        )
        ?.text;

    int? oldPrice = getIntFromString(
      descriptionElement
          ?.querySelector(
            'span.STRIKETHROUGH',
          )
          ?.text,
    );
    int? currentPrice = getIntFromString(
      descriptionElement
          ?.querySelector(
            'span.s-item__price',
          )
          ?.firstChild
          ?.text,
    );
    if (currentPrice == 0) currentPrice = 1;

    if (title != null &&
        href != null &&
        photoUrl != null &&
        currentPrice != null) {
      scrappingModels.add(
        ScrappingModel(
          title: title,
          url: href,
          photoUrl: photoUrl,
          oldPrice: oldPrice,
          currentPrice: currentPrice,
        ),
      );
    }
  }

  return scrappingModels;
}
