/// Достопримечательность
class Attraction {
  final String name;
  final int id;

  /// Ссылка на изображение достопримечательности
  String imageUrl;

  double _rating = 1.0;

  /// между 1.0 и 5.0 или Nan если еще нет рейтинга
  set rating(double value) {
    if (value <= 5.0 && value >= 1.0 || value.isNaN) {
      _rating = value;
    }
  }

  /// между 1.0 и 5.0 или Nan если еще нет рейтинга
  double get rating => _rating;

  /// Часто задаваемые и интересные вопросы
  Map<String, String> questions = {};

  /// Координаты: широтаБ долгота.
  double latitude, longitude;

  Attraction(this.name, this.id,
      {this.questions,
      this.latitude,
      this.longitude,
      this.imageUrl,
      double rating = double.nan}) {
    this.rating = rating;
  }
}
