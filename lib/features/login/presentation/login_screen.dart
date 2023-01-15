import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // input form focus node
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // rive controller
  StateMachineController? _controller;

  SMIInput<bool>? _isChecking;
  SMIInput<double>? _numLook;
  SMIInput<bool>? _isHandsUp;

  _usernameFocus() {
    _isChecking?.change(_usernameFocusNode.hasFocus);
  }

  _passwordFocus() {
    _isHandsUp?.change(_passwordFocusNode.hasFocus);
  }

  @override
  void initState() {
    _usernameFocusNode.addListener(_usernameFocus);
    _passwordFocusNode.addListener(_passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocusNode.removeListener(_usernameFocus);
    _passwordFocusNode.removeListener(_passwordFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(
          //   height: 64,
          // ),
          Text(
            "Rive + Flutter \n Animated Guardian \n Polar Bear",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 252,
            height: 252,
            child: RiveAnimation.asset(
              "assets/animated-login-character.riv",
              fit: BoxFit.fitHeight,
              stateMachines: const ["Login Machine"],
              onInit: (artboard) {
                _riveOnInit(artboard);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: _getInputs(context),
            ),
          )
        ],
      ),
    );
  }

  _riveOnInit(Artboard artboard) {
    _controller = StateMachineController.fromArtboard(
      artboard,
      "Login Machine",
    );
    if (_controller == null) return;
    artboard.addController(_controller!);
    _isChecking = _controller?.findInput("isChecking");
    _numLook = _controller?.findInput("numLook");
    _isHandsUp = _controller?.findInput("isHandsUp");
  }

  Widget _getInputs(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: TextField(
            focusNode: _usernameFocusNode,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Username",
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) {
              _numLook?.change(value.length.toDouble());
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: TextField(
            focusNode: _passwordFocusNode,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
            ),
            obscureText: true,
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) {},
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        _getButton()
      ],
    );
  }

  Widget _getButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          _usernameFocusNode.unfocus();
          _passwordFocusNode.unfocus();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text("Login"),
      ),
    );
  }
}
