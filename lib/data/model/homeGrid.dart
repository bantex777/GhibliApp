class HomeGrid {
  final String title;
  final String info;
  final String imageUrl;

  HomeGrid({required this.title, required this.info, required this.imageUrl});

  factory HomeGrid.fromJson(Map<String, dynamic> json) {
    return HomeGrid(
      title: json['title'] ?? '',
      info: json['info'] ?? '',
      imageUrl: json['imagePath'] ?? '',
    );
  }
}
