abstract class EbookDetailEvent {}

class FetchEbookDetail extends EbookDetailEvent {
  final String ebookId;
  FetchEbookDetail(this.ebookId);
}
