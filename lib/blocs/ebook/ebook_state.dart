import '../../data/models/ebook_model.dart';

abstract class EbookState {}

class EbookInitial extends EbookState {}

class EbookLoading extends EbookState {
  final int shimmerCount;
  EbookLoading({required this.shimmerCount});
}

class EbookLoaded extends EbookState {
  final List<Ebook> ebooks;
  EbookLoaded(this.ebooks);
}

class EbookError extends EbookState {
  final String message;
  EbookError(this.message);
}
