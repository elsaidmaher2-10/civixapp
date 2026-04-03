class CategoryResponse {
  final List<CategoryItem> items;

  CategoryResponse({required this.items});

  factory CategoryResponse.fromList(List<dynamic> jsonList) {
    return CategoryResponse(
      items: jsonList
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'items': items.map((e) => e.toJson()).toList()};
  }
}

class CategoryItem {
  final int id;
  final String? name;
  CategoryItem({required this.id, this.name});
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(id: json['id'] ?? 0, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }


}
