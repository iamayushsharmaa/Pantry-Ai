class UserProfile {
  final String? photoUrl;

  const UserProfile({
    this.photoUrl,
  });

  bool get hasPhoto => photoUrl != null && photoUrl!.isNotEmpty;
}
