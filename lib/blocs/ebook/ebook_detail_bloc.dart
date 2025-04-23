import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../utils/constants/api_endpoints.dart';
import 'ebook_detail_event.dart';
import 'ebook_detail_state.dart';

class EbookDetailBloc extends Bloc<EbookDetailEvent, EbookDetailState> {
  final _storage = const FlutterSecureStorage();

  EbookDetailBloc() : super(EbookDetailLoading()) {
    on<FetchEbookDetail>(_onFetchEbookDetail);
  }

  Future<void> _onFetchEbookDetail(
      FetchEbookDetail event, Emitter<EbookDetailState> emit) async {
    emit(EbookDetailLoading());
    try {
      final token = await _storage.read(key: 'access_token');
      final url = '${ApiEndpoints.ebookById}/${event.ebookId}';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token ?? ''},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final ebookData = responseData['data'];

        final name = ebookData['ebook_name'];
        final desc = ebookData['ebook_desc'];
        final pdfUrl = ebookData['ebook_pdf'];

        final path = await _downloadAndSavePdf(pdfUrl, event.ebookId);

        emit(EbookDetailLoaded(name: name, desc: desc, localPdfPath: path));
      } else {
        emit(EbookDetailError('Failed to fetch ebook details'));
      }
    } catch (e) {
      emit(EbookDetailError('Error: $e'));
    }
  }

  Future<String> _downloadAndSavePdf(String url, String id) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/ebook_$id.pdf');

    await file.writeAsBytes(bytes);
    return file.path;
  }
}
