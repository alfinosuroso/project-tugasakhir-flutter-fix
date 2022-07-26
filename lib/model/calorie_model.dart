import 'package:json_annotation/json_annotation.dart';


CalorieModel _$CalorieModelFromJson(Map<String, dynamic> json) => CalorieModel(
      (json['tempC'] as num).toDouble(),
      (json['humi'] as num).toDouble(),
    );

Map<String, dynamic> _$CalorieModelToJson(CalorieModel instance) => <String, dynamic>{
      'tempC': instance.tempC,
      'humi': instance.humi,
    };

@JsonSerializable(explicitToJson: true)
class CalorieModel {
  CalorieModel(this.tempC, this.humi);
  double tempC;
  double humi;
  factory CalorieModel.fromJson(Map<String, dynamic> json) =>
      _$CalorieModelFromJson(json);
  Map<String, dynamic> toJson() => _$CalorieModelToJson(this);

}
