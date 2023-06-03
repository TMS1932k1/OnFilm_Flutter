import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/representations/widgets/auth/option_item_bar.dart';
import 'package:onfilm_app/representations/widgets/auth/sigin_other.dart';
import 'package:onfilm_app/representations/widgets/circular_progress_loading.dart';

class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _FormInputState();
}

enum AuthState { SignIn, SignUp }

class _FormInputState extends State<FormInput> with TickerProviderStateMixin {
  AuthState _state = AuthState.SignIn;
  var _isLoading = false;

  Map<String, String> auth = {
    'email': '',
    'password': '',
  };

  final GlobalKey<FormState> _formKey = GlobalKey();
  // To check match with confirm password
  final _passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  void _update(AuthState state) {
    setState(() {
      if (_state == AuthState.SignIn) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      if (_state != state) _state = state;
    });
  }

  // Check email password to sign up
  // If success will
  // If failed will show snackbar mes to show error
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: auth['email']!,
        password: auth['password']!,
      );

      await signInWithEmailAndPassword(); // Auto sign in
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(
          context,
          'The password provided is too weak!!',
        );
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
          context,
          'The account already exists for that email!!',
        );
      }
    } catch (e) {
      showSnackBar(
        context,
        'Have error in sign up!!',
      );
    }
  }

  // Check email password to sign in
  // If success will pop screen
  // If failed will show snackbar mes to show error
  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: auth['email']!,
        password: auth['password']!,
      );

      Navigator.of(context).pop(); // Back screen
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(
          context,
          'No user found for that email!!',
        );
      } else if (e.code == 'wrong-password') {
        showSnackBar(
          context,
          'Wrong password provided for that user!!',
        );
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return; // Invalid
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_state == AuthState.SignUp) {
      await createUserWithEmailAndPassword().then(
        (value) => setState(() {
          _isLoading = false;
        }),
      );
    } else if (_state == AuthState.SignIn) {
      await signInWithEmailAndPassword().then(
        (value) => setState(() {
          _isLoading = false;
        }),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        children: [
          _buildMenuAuth(),
          _buildBoxInput(),
        ],
      ),
    );
  }

  Widget _buildBoxInput() {
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(
        DimenssionConstant.kPandingMedium,
      ),
      height: _state == AuthState.SignIn ? 280 : 360,
      constraints: BoxConstraints(
        minHeight: _state == AuthState.SignIn ? 280 : 360,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            _state == AuthState.SignIn ? 0 : DimenssionConstant.kRadiusSmall,
          ),
          topRight: Radius.circular(
            _state == AuthState.SignUp ? 0 : DimenssionConstant.kRadiusSmall,
          ),
          bottomLeft: const Radius.circular(
            DimenssionConstant.kRadiusSmall,
          ),
          bottomRight: const Radius.circular(
            DimenssionConstant.kRadiusSmall,
          ),
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  icon: FaIcon(
                    FontAwesomeIcons.envelope,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  hintText: 'Input your email',
                  hintStyle: TextStyleConstant.labelMedium.copyWith(
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value == null) return 'Invalid email!';
                  // Check format email
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (value.trim().isEmpty || !emailValid) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (newValue) => auth['email'] = newValue!,
                style: TextStyleConstant.labelMedium.copyWith(
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
              const SizedBox(
                height: DimenssionConstant.kPandingSmall,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  icon: FaIcon(
                    FontAwesomeIcons.key,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  hintText: 'Input password',
                  hintStyle: TextStyleConstant.labelMedium.copyWith(
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 7) {
                    return 'Invalid password!';
                  }
                  return null;
                },
                onSaved: (newValue) => auth['password'] = newValue!,
                style: TextStyleConstant.labelMedium.copyWith(
                  color: Colors.white,
                ),
                obscureText: true,
                maxLines: 1,
              ),
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 300),
                constraints: BoxConstraints(
                    maxHeight: _state == AuthState.SignUp ? 80 : 0,
                    minHeight: _state == AuthState.SignUp ? 80 : 0),
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: DimenssionConstant.kPandingSmall,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: FaIcon(
                              FontAwesomeIcons.circleCheck,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            hintText: 'Confirm password',
                            hintStyle: TextStyleConstant.labelMedium.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyleConstant.labelMedium.copyWith(
                            color: Colors.white,
                          ),
                          validator: _state == AuthState.SignUp
                              ? (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                  return null;
                                }
                              : null,
                          obscureText: true,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: DimenssionConstant.kPandingMedium,
              ),
              if (_isLoading) const CirculaProgressLoading(),
              if (!_isLoading)
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                      _state == AuthState.SignIn ? 'Login' : 'Register',
                      style: TextStyleConstant.headlineSmall,
                    ),
                  ),
                ),
              const SizedBox(
                height: DimenssionConstant.kPandingSmall,
              ),
              const Text(
                'Or',
                style: TextStyleConstant.labelMedium,
              ),
              const SizedBox(
                height: DimenssionConstant.kPandingSmall,
              ),
              if (_isLoading) const CirculaProgressLoading(),
              if (!_isLoading)
                SiginOther(
                  signGoogle: _signGoogle,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuAuth() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _update(AuthState.SignIn),
          child: OptionItemBar('Sign In', _state == AuthState.SignIn),
        ),
        GestureDetector(
          onTap: () => _update(AuthState.SignUp),
          child: OptionItemBar('Sign Up', _state == AuthState.SignUp),
        ),
      ],
    );
  }

  void _signGoogle() async {
    setState(() {
      _isLoading = true;
    });

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? authentication =
        await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop(); // Back screen
  }

  void showSnackBar(BuildContext context, String mes) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mes),
      ),
    );
  }
}
