class BooksModel {
  String? kind;
  String? fullSortKey;
  String? title;
  String? url;
  String? coverColor;
  String? author;
  String? cover;
  String? epoch;
  String? href;
  bool? hasAudio;
  String? genre;
  String? simpleThumb;
  String? slug;
  String? coverThumb;
  bool? liked; // Updated this line

  BooksModel({
    this.kind,
    this.fullSortKey,
    this.title,
    this.url,
    this.coverColor,
    this.author,
    this.cover,
    this.epoch,
    this.href,
    this.hasAudio,
    this.genre,
    this.simpleThumb,
    this.slug,
    this.coverThumb,
    this.liked,
  });

  // ... other methods ...

  BooksModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    fullSortKey = json['full_sort_key'];
    title = json['title'];
    url = json['url'];
    coverColor = json['cover_color'];
    author = json['author'];
    cover = json['cover'];
    epoch = json['epoch'];
    href = json['href'];
    hasAudio = json['has_audio'];
    genre = json['genre'];
    simpleThumb = json['simple_thumb'];
    slug = json['slug'];
    coverThumb = json['cover_thumb'];
    liked = json['liked'] ?? false; // Updated this line
  }

  // ... other methods ...
}
