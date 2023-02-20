import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    Key? key,
    required this.goForward,
    required this.goBack,
    required this.reload,
    required this.stop,
    required this.isLoading,
    required this.canGoForward,
    required this.canGoBack,
  }) : super(key: key);
  final Function() goForward;
  final Function() goBack;
  final Function() reload;
  final Function() stop;
  final bool isLoading;
  final bool canGoForward;
  final bool canGoBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const SizedBox(width: 8),
            IconButton(
              onPressed: canGoForward ? goForward : null,
              icon: canGoForward
                  ? const Icon(Icons.forward_10, size: 28, color: Colors.black)
                  : const Icon(Icons.forward_10, size: 28, color: Colors.grey),
            ),
            IconButton(
              onPressed: canGoBack ? goBack : null,
              icon: canGoBack
                  ? const Icon(Icons.replay_10, size: 28, color: Colors.black)
                  : const Icon(Icons.replay_10, size: 28, color: Colors.grey),
            ),
            IconButton(
              onPressed: isLoading ? stop : reload,
              icon: isLoading
                  ? const Icon(Icons.stop, size: 28, color: Colors.black)
                  : const Icon(Icons.refresh, size: 28, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
