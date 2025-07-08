class MenuModel {
  final int id;
  final String name;

  MenuModel({
    required this.id,
    required this.name,
  });

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['MenuID'] ?? 0,
      name: map['MenuName'] ?? ''
      );
  }
}

