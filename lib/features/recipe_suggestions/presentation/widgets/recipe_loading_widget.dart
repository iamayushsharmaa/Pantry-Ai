import 'package:flutter/material.dart';

class RecipeLoadingWidget extends StatefulWidget {
  const RecipeLoadingWidget({super.key});

  @override
  State<RecipeLoadingWidget> createState() => _RecipeLoadingWidgetState();
}

class _RecipeLoadingWidgetState extends State<RecipeLoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;

  int _messageIndex = 0;

  static const _messages = [
    'Scanning your ingredients...',
    'Finding the best recipes...',
    'Almost ready...',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 2500));
      if (!mounted) return false;
      await _controller.reverse();
      if (!mounted) return false;
      setState(() {
        _messageIndex = (_messageIndex + 1) % _messages.length;
      });
      _controller.forward();
      return mounted;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: cs.primary,
              backgroundColor: cs.primary.withOpacity(0.1),
            ),
          ),

          const SizedBox(height: 28),

          FadeTransition(
            opacity: _fadeAnim,
            child: Text(
              _messages[_messageIndex],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: cs.onSurface.withOpacity(0.55),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'This may take a few seconds',
            style: TextStyle(
              fontSize: 12,
              color: cs.onSurface.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
