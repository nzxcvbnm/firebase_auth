class CurrentUser {
  String? id;
  String username;
  String email;
  String password;
  String? emailOrUsername;
  String? imageUrl;
  String description;
  DateTime createdAt;
  List<String> favorites;

  CurrentUser(
    this.username,
    this.email,
    this.password, {
    this.id,
    this.imageUrl,
    this.emailOrUsername,
    required this.description,
    required this.createdAt,
    this.favorites = const [],
  });

  CurrentUser copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? emailOrUsername,
    String? imageUrl,
    String? description,
    DateTime? createdAt,
    List<String>? favorites,
  }) {
    return CurrentUser(
      username ?? this.username,
      email ?? this.email,
      password ?? this.password,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      emailOrUsername: emailOrUsername ?? this.emailOrUsername,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      favorites: favorites ?? this.favorites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': 'password',
      'imageUrl': imageUrl,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'favorites': favorites,
    };
  }

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
      map['username'] as String,
      map['email'] as String,
      map['password'] as String,
      id: map['id'],
      imageUrl: map['imageUrl'] ?? emptyProfilePic,
      emailOrUsername: map['emailOrUsername'] as String?,
      description: map['description'] ?? '',
      createdAt: map['createdAt'] == null
          ? DateTime(2000, 1, 1)
          : DateTime.parse(map['createdAt'] as String),
      favorites: List<String>.from(map['favorites'] ?? []),
    );
  }

  static CurrentUser empty() => CurrentUser(
        '',
        '',
        '',
        id: '',
        imageUrl: emptyProfilePic,
        description: '',
        createdAt: DateTime.now(),
        favorites: [],
      );
}

const String emptyProfilePic =
    'https://media.istockphoto.com/id/1130884625/vector/user-member-vector-icon-for-ui-user-interface-or-profile-face-avatar-app-in-circle-design.jpg?s=612x612&w=0&k=20&c=1ky-gNHiS2iyLsUPQkxAtPBWH1BZt0PKBB1WBtxQJRE=';
