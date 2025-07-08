
import 'package:html/parser.dart' as html_parser;
class HtmlHelper {
  static String stripHtmlTags(String htmlText) {
    final document = html_parser.parse(htmlText);
    return document.body?.text ?? '';
  }}