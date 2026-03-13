class CategoryResponse {
  final List<CategoryItem> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  CategoryResponse({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => CategoryItem.fromJson(e))
          .toList(),
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 20,
      totalCount: json['totalCount'] ?? 0,
      totalPages: json['totalPages'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'page': page,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
    };
  }
}

class CategoryItem {
  final int id;
  final String? name;
  final String? description;
  final String? departmentName;
  final String? status;
  final List<dynamic> reports;

  CategoryItem({
    required this.id,
    this.name,
    this.description,
    this.departmentName,
    this.status,
    required this.reports,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      departmentName: json['departmentName'],
      status: json['status'],
      reports: json['reports'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'departmentName': departmentName,
      'status': status,
      'reports': reports,
    };
  }
}
