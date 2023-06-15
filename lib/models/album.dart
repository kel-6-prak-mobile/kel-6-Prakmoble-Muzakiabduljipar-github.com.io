class Albums {
  final int userId;
  final int id;
  final String title;

  Albums({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Albums.fromMap(Map<String, dynamic> data) {
    return Albums(
      userId: data['userId'],
      id: data['id'],
      title: data['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }
}
