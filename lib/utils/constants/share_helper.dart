import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static void shareBlog(String blogTitle) {
    final formattedTitle = blogTitle.toLowerCase().replaceAll(' ', '-');
    final url = 'https://stockcareers.com/blog-details/$formattedTitle';
    final message = 'Check out this blog: $url\nLearn more with StockCareers!';
    Share.share(message);
  }
}
