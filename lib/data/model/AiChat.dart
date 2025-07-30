class AiChatModel {
  final String question;
  final String answer;
  final DateTime timestamp;
  final bool isUser;

  AiChatModel({
    required this.question,
    required this.answer,
    required this.timestamp,
    required this.isUser,
  });
}
