import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usainua/models/scrapping_model.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/services/web_scrapping_service.dart';
import 'package:usainua/utils/constants.dart';

class GoodsSlider extends StatelessWidget {
  const GoodsSlider({
    this.webCite = WebCites.ebay,
    this.websiteSection = WebsiteSections.popular,
    Key? key,
  }) : super(key: key);

  final WebCites webCite;
  final WebsiteSections websiteSection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: FutureBuilder(
        future: WebScrappingService.webScrappingServiceElements(
          webCite: webCite,
          websiteSection: websiteSection,
        ),
        builder: (context, AsyncSnapshot<List<ScrappingModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _skeletSlider();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemBuilder: (BuildContext context, int index) {
                  ScrappingModel scrappingModel = snapshot.data![index];

                  return _card(
                    scrappingModel: scrappingModel,
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                          scrappingModel.url,
                        ),
                      );
                    },
                  );
                },
              );
            }
          }

          return const Center(
            child: Text(
              'Не удалось загрузить список товара',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontSize: AppFonts.sizeXLarge,
                fontWeight: AppFonts.bold,
                letterSpacing: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _skeletSlider() {
  return SizedBox(
    child: ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 160,
              margin: const EdgeInsets.only(
                right: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  width: 2,
                  color: AppColors.primary,
                ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 115,
                      width: 115,
                      child: SkeletonAvatar(),
                    ),
                    Column(
                      children: [
                        SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                            lines: 1,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            lineStyle: SkeletonLineStyle(
                              height: 10,
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                            lines: 1,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            lineStyle: SkeletonLineStyle(
                              height: 8,
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
              right: 7,
              top: -5,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

Widget _card({
  required ScrappingModel scrappingModel,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 160,
          margin: const EdgeInsets.only(
            right: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              width: 2,
              color: AppColors.primary,
            ),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: CachedNetworkImage(
                    imageUrl: scrappingModel.photoUrl,
                    placeholder: (context, _) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.boxShadow,
                        ),
                      );
                    },
                    errorWidget: (context, _, error) {
                      return const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        scrappingModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: AppFonts.sizeXSmall,
                          fontWeight: AppFonts.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'www.ebay.сom',
                      style: TextStyle(
                        fontSize: AppFonts.sizeXSmall,
                        fontWeight: AppFonts.regular,
                        color: AppColors.darkBlue,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        if (scrappingModel.oldPrice != null)
          Positioned(
            right: 7,
            top: 26,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.antiFlashWhite,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${scrappingModel.oldPrice}\$',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: AppFonts.bold,
                    fontSize: AppFonts.sizeXSmall,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          right: 7,
          top: -5,
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.darkBlue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${scrappingModel.currentPrice}\$',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
