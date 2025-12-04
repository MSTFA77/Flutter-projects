import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();

  String _greetingMessage = '';
  bool _showForm = true;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  void _submitName() {
    setState(() {
      _greetingMessage = 'Hello, ${_nameController.text} 👋';
      _showForm = false;
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: !_showForm
            ? IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color(0xffF2F2F2)),
                onPressed: () async {
                  await _animationController.reverse();

                  setState(() {
                    _showForm = true;
                    _greetingMessage = '';
                    _nameController.clear();
                  });

                  _animationController.reset();
                },
              )
            : null,
        title: const Text(
          "Home",
          style:  TextStyle(
            color: Color(0xffF5F5F5),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.webp'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_showForm) ...[
                TextField(
                  controller: _nameController,
                  style: const TextStyle(
                    color: Color(0xffF8F8F8),
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    labelStyle: const TextStyle(
                      color: Color(0xffE0E0E0),
                    ),
                    filled: true,
                    fillColor:
                        const Color(0xffECECEC).withAlpha(25),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color(0xffD6D6D6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color(0xffA8A8A8),
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xffE0E0E0),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitName,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xffF2F2F2).withAlpha(  230),
                      foregroundColor: const Color(0xff2A2A2A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
              if (!_showForm)
                SlideTransition(
                  position: _slideAnimation,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _greetingMessage,
                      style: const TextStyle(
                        fontSize: 60,
                        fontFamily: 'Caveat',
                        color: Color(0xffFAFAFA),
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 15,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
