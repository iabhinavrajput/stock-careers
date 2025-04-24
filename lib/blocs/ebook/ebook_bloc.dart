import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/data/services/ebook_service.dart';
import 'ebook_event.dart';
import 'ebook_state.dart';

class EbookBloc extends Bloc<EbookEvent, EbookState> {
  final EbookService ebookService;

  EbookBloc(this.ebookService) : super(EbookInitial()) {
    on<LoadEbooks>((event, emit) async {
      try {
        emit(EbookLoading(shimmerCount: 0)); // Initial loading count
        final ebooks = await ebookService.fetchEbooks();
        emit(EbookLoading(shimmerCount: ebooks.length)); // Dynamic shimmer count
        await Future.delayed(const Duration(seconds: 1));
        emit(EbookLoaded(ebooks));
      } catch (e) {
        emit(EbookError(e.toString()));
      }
    });
  }
}
