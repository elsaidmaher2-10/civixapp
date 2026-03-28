
class ReportModel {
  final String id;
  final String title;
  final String address;
  final String timeAgo;
  final String status;
  final String imageUrl;
  final bool isTopImpact;

  const ReportModel({
    required this.id,
    required this.title,
    required this.address,
    required this.timeAgo,
    required this.status,
    required this.imageUrl,
    this.isTopImpact = false,
  });
}

final List<ReportModel> dummyTopReports = [
  ReportModel(
    id: '1',
    title: 'Major Street Repair',
    address: '22-Oraby Street',
    timeAgo: '2 hours ago',
    status: 'progress',
    imageUrl:
        'https://images.unsplash.com/photo-1584466977773-e625c37cdd50?w=400&q=80',
    isTopImpact: true,
  ),
  ReportModel(
    id: '2',
    title: 'Park Clean-up',
    address: '55-Montazah Street',
    timeAgo: '1 day ago',
    status: 'resolved',
    imageUrl:
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80',
  ),
  ReportModel(
    id: '3',
    title: 'Street Lighting',
    address: '10-Nile Corniche',
    timeAgo: '5 hours ago',
    status: 'submitted',
    imageUrl:
        'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=400&q=80',
    isTopImpact: true,
  ),
];

final List<ReportModel> dummyResolvedReports = [
  ReportModel(
    id: '4',
    title: 'Accident Site Clear',
    address: '13-SAYAD Street',
    timeAgo: '3 days ago',
    status: 'resolved',
    imageUrl:
        'https://images.unsplash.com/photo-1584466977773-e625c37cdd50?w=200&q=80',
  ),
  ReportModel(
    id: '5',
    title: 'Waste Collection',
    address: '55-Montazah Street',
    timeAgo: '2 weeks ago',
    status: 'resolved',
    imageUrl:
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200&q=80',
  ),
  ReportModel(
    id: '6',
    title: 'Secondary Hole Fix',
    address: '22-Oraby Street',
    timeAgo: '1 month ago',
    status: 'resolved',
    imageUrl:
        'https://images.unsplash.com/photo-1515162305285-0293e4cb4b77?w=200&q=80',
  ),
];