import 'package:flutter/material.dart';

class Composer extends StatefulWidget {
  const Composer({super.key, required this.controller, required this.onSubmit});

  final TextEditingController controller;
  final VoidCallback onSubmit;

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  bool _hasFocus = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.trim().isNotEmpty;
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _handleTextChange() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText == _hasText) return;
    setState(() => _hasText = hasText);
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (focused) => setState(() => _hasFocus = focused),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, _hasFocus ? 0.09 : 0.06),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Color.fromRGBO(255, 255, 255, _hasFocus ? 0.25 : 0.12),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                onSubmitted: (_) => widget.onSubmit(),
                decoration: const InputDecoration(
                  hintText: 'Add a task for today...',
                  hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  
                ),
              ),
            ),
            const SizedBox(width: 12),
            AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: _hasText ? 1.0 : 0.95,
              child: FilledButton(
                onPressed: _hasText ? widget.onSubmit : null,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text('Add', style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
