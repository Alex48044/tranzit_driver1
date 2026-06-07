class FeatureModel {
  final String id;
  final String name;
  final bool enabled;
  final String? description;

  FeatureModel({
    required this.id,
    required this.name,
    required this.enabled,
    this.description,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'] as String,
      name: json['name'] as String,
      enabled: json['enabled'] as bool,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'enabled': enabled,
      'description': description,
    };
  }
}
