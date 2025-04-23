class Ebook {
  final String id;
  final String name;
  final String desc;
  final String image;
  final String pdf;
  final String type;
  final String pages;

  Ebook({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.pdf,
    required this.type,
    required this.pages,
  });

  factory Ebook.fromJson(Map<String, dynamic> json) {
    return Ebook(
      id: json['id'],
      name: json['ebook_name'],
      desc: json['ebook_desc'],
      image: json['ebook_image'],
      pdf: json['ebook_pdf'],
      type: json['ebook_type'],
      pages: json['ebook_pages'] ?? '',
    );
  }
}
