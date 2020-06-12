class UserData {
  String username;
  int workoutCount;

  UserData({
    this.username,
    this.workoutCount,
  });

  factory UserData.initial(String username) {
    return UserData(
      username: username,
      workoutCount: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'workoutCount': workoutCount,
    };
  }
}
