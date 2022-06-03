import 'package:meta/meta.dart';
import 'dart:convert';

AttractionModel attractionModelFromJson(String str) =>
    AttractionModel.fromJson(json.decode(str));

class AttractionModel {
  AttractionModel({
    this.attractions,
  });

  List<Attraction> attractions;

  factory AttractionModel.fromJson(Map<String, dynamic> json) =>
      AttractionModel(
        attractions: List<Attraction>.from(
            json["attractions"].map((x) => Attraction.fromJson(x))),
      );
}

class Attraction {
  Attraction(
      {this.name,
      this.id,
      this.questions,
      this.imageUrl,
      this.latitude,
      this.longitude,
      this.rating,
      this.distance,
      this.feedback});

  String name;
  int id;
  List<Question> questions;
  String imageUrl;
  double latitude;
  double longitude;
  double rating;
  double distance;
  List<String> feedback;

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
      name: json["name"] ?? '',
      id: json["id"],
      questions: List<Question>.from(
          json["questions"].map((x) => Question.fromJson(x))),
      imageUrl: json["imageUrl"],
      latitude: json["latitude"].toDouble(),
      longitude: json["longitude"].toDouble(),
      rating: json["rating"] == null ? null : json["rating"].toDouble(),
      distance: json["distance"] == null ? null : json["distance"],
      feedback: List<String>.from(json["feedback"].map((x) => x)));
}

class Question {
  Question({
    @required this.question,
    @required this.answer,
  });

  String question;
  String answer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answer: json["answer"],
      );
}
