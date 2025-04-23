abstract class EbookDetailState {}

class EbookDetailLoading extends EbookDetailState {}

class EbookDetailLoaded extends EbookDetailState {
  final String name;
  final String desc;
  final String localPdfPath;

  EbookDetailLoaded({required this.name, required this.desc, required this.localPdfPath});
}

class EbookDetailError extends EbookDetailState {
  final String message;
  EbookDetailError(this.message);
}
