enum MethodTypes {
  get,
  post,
  put,
  delete,
  head,
  patch,
}

class MethodsModel {
  String name;
  String return1;
  String return2;
  String params1;
  String params2;
  String content1;
  String content2;
  MethodTypes methodTypes;

  /// Constructor
  MethodsModel({
    required this.name,
    required this.return1,
    required this.return2,
    required this.params1,
    required this.params2,
    required this.content1,
    required this.content2,
    required this.methodTypes,
  });

  /// Copy with Method
  MethodsModel copyWith({
    String? name,
    String? return1,
    String? return2,
    String? params1,
    String? params2,
    String? content1,
    String? content2,
    MethodTypes? methodTypes,
  }) {
    return MethodsModel(
      name: name ?? this.name,
      return1: return1 ?? this.return1,
      return2: return2 ?? this.return2,
      params1: params1 ?? this.params1,
      params2: params2 ?? this.params2,
      content1: content1 ?? this.content1,
      content2: content2 ?? this.content2,
      methodTypes: methodTypes ?? this.methodTypes,
    );
  }

  /// from Json method
  factory MethodsModel.fromJson(Map<String, dynamic> json) {
    return MethodsModel(
      name: json['name'] ?? '',
      return1: json['return1'] ?? '',
      return2: json['return2'] ?? '',
      params1: json['params1'] ?? '',
      params2: json['params2'] ?? '',
      content1: json['content'] ?? '',
      content2: json['content2'] ?? '',
      methodTypes: MethodTypes.values[json["methodTypes"] ?? ''],
    );
  }

  /// to Json method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'return1': return1,
      'return2': return2,
      'params1': params1,
      'params2': params2,
      'content': content1,
      'content2': content2,
      'methodTypes': methodTypes.index,
    };
  }

  /// Empty method
  factory MethodsModel.empty({
    String name = '',
    String retorno1 = '',
    String retorno2 = '',
    String params1 = '',
    String params2 = '',
    String content1 = '',
    String content2 = '',
    MethodTypes methodTypes = MethodTypes.get,
  }) {
    return MethodsModel(
      name: name,
      return1: retorno1,
      return2: retorno2,
      params1: params1,
      params2: params2,
      content1: content1,
      content2: content2,
      methodTypes: methodTypes,
    );
  }
}
