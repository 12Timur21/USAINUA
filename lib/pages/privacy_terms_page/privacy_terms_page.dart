import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:usainua/resources/app_icons.dart';

class PrivacyTermsPage extends StatefulWidget {
  const PrivacyTermsPage({
    required this.mdFileName,
    Key? key,
  }) : super(key: key);

  static const routeName = '/privacy_terms_page';

  final String mdFileName;

  @override
  State<PrivacyTermsPage> createState() => _PrivacyTermsPageState();
}

class _PrivacyTermsPageState extends State<PrivacyTermsPage> {
  void _returnBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        centerTitle: true,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: _returnBack,
          icon: SvgPicture.asset(
            AppIcons.leftArrow,
            width: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString(
          'assets/md/privacy_policy.md',
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Markdown(
                data: snapshot.data,
                styleSheet: _markdownStyleSheet(context),
                styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                onTapLink: (String text, String? href, String link) {
                  if (href != null) launchUrlString(href);
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

MarkdownStyleSheet _markdownStyleSheet(context) {
  return MarkdownStyleSheet(
    p: Theme.of(context).textTheme.bodyText1,
  );
}
