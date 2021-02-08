
import 'package:meta/meta.dart';

class Quote {
  Quote({@required this.id, @required this.quote, this.author});
  final String id;
  final String quote;
  final String author;

  factory Quote.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String quote = data['quote'];
    final String author = data['author'];
    return Quote(
      id: documentId,
      quote: quote,
      author: author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
    };
  }
}