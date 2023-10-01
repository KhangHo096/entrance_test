import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  bool? selected;

  CategoryModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.selected,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
