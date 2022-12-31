// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_post.g.dart';

@JsonSerializable(explicitToJson: true)
class ImagePostModel extends Equatable {
  final int id;
  final String link;
  const ImagePostModel({
    required this.id,
    required this.link,
  });
  factory ImagePostModel.fromJson(Map<String, dynamic> json) =>
      _$ImagePostModelFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ImagePostModelToJson(this);
  @override
  String toString() {
    toJson().toString();
    return super.toString();
  }

  @override
  List<Object?> get props => [id, link];
}
