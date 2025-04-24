import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../utils/constants/colors.dart';

class EbookDetailScreen extends StatefulWidget {
  final String ebookId;

  const EbookDetailScreen({Key? key, required this.ebookId}) : super(key: key);

  @override
  State<EbookDetailScreen> createState() => _EbookDetailScreenState();
}

class _EbookDetailScreenState extends State<EbookDetailScreen> {
  final _storage = const FlutterSecureStorage();
  bool loading = true;
  String? name;
  String? desc;
  String? localPdfPath;

  @override
  void initState() {
    super.initState();
    fetchEbookDetails();
  }

  Future<void> fetchEbookDetails() async {
    final token = await _storage.read(key: 'access_token');
    final url = 'https://stockcareers.com/api/ebook_by_id/${widget.ebookId}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token ?? ''},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final ebookData = responseData['data'];

        name = ebookData['ebook_name'];
        desc = ebookData['ebook_desc'];
        final pdfUrl = ebookData['ebook_pdf'];

        final path = await downloadAndSavePdf(pdfUrl);
        setState(() {
          localPdfPath = path;
          loading = false;
        });
      } else {
        throw Exception('Failed to fetch ebook details');
      }
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<String> downloadAndSavePdf(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/ebook_${widget.ebookId}.pdf');

    await file.writeAsBytes(bytes);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? 'Ebook Detail'),
        backgroundColor:  Theme.of(context).brightness == Brightness.dark
              ? AppColors.background
              : Colors.white,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : localPdfPath != null
              ? Column(
                  children: [
                    if (desc != null)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(desc!, style: const TextStyle(fontSize: 16)),
                      ),
                    Expanded(
                      child: PDFView(
                        filePath: localPdfPath!,
                        enableSwipe: true,
                        swipeHorizontal: false,
                        autoSpacing: false,
                        pageFling: true,
                      ),
                    ),
                  ],
                )
              : const Center(child: Text('Failed to load PDF')),
    );
  }
}
