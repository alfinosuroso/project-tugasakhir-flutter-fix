import 'package:json_annotation/json_annotation.dart';


CalorieModel _$CalorieModelFromJson(Map<String, dynamic> json) => CalorieModel(
      (json['calibration'] as num).toDouble(),
      (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$CalorieModelToJson(CalorieModel instance) => <String, dynamic>{
      'calibration': instance.calibration,
      'weight': instance.weight,
    };

@JsonSerializable(explicitToJson: true)
class CalorieModel {
  CalorieModel(this.calibration, this.weight);
  double calibration;
  double weight;
  factory CalorieModel.fromJson(Map<String, dynamic> json) =>
      _$CalorieModelFromJson(json);
  Map<String, dynamic> toJson() => _$CalorieModelToJson(this);

}
