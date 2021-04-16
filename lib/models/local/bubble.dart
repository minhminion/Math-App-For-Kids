enum BubbleType { success, error, hello }

class Bubble {
  final String message;
  final BubbleType type;

  Bubble(this.message, this.type);
}
