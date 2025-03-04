import 'dart:convert';

class ListResourceModel {
  final List<ResourceModel> data;

  ListResourceModel({
    required this.data,
  });

  factory ListResourceModel.fromJson(Map<String, dynamic> json) {
    return ListResourceModel(
      data:
          (json['data'] as List).map((e) => ResourceModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  static ListResourceModel fromJsonString(String jsonString) {
    return ListResourceModel.fromJson(json.decode(jsonString));
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}

class ResourceModel {
  final int id;
  final String name;
  final int year;
  final String color;
  final String pantoneValue;

  ResourceModel({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      color: json['color'],
      pantoneValue: json['pantone_value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'year': year,
      'color': color,
      'pantone_value': pantoneValue,
    };
  }
}
