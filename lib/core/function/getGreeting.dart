String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return 'Good morning\n';
  } else if (hour >= 12 && hour < 17) {
    return 'Good afternoon\n';
  } else if (hour >= 17 && hour < 21) {
    return 'Good evening\n';
  } else {
    return 'Good night\n';
  }
}
