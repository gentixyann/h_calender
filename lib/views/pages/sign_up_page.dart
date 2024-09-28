import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_calender/router.dart';
import 'package:h_calender/utils/validators.dart';
import 'package:h_calender/views/pages/widgets/password_text_field_utils.dart';
import 'package:h_calender/views/pages/widgets/progress_filter.dart';
import 'package:h_calender/views/pages/widgets/un_focus.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Scaffold(
        body: ListView(
      children: const [
        SizedBox(height: 60),
        _TextFields(),
        SizedBox(height: 20),
        _SignUpButton(),
        SizedBox(height: 20),
        _SignInButton()
      ],
    ));
  }
}

class _Scaffold extends ConsumerWidget {
  const _Scaffold({required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: UnFocus(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ProgressFilter(
              isInProgress: ref.watch(_isInProgressProvider),
              child: Form(
                key: ref.watch(_formStateProvider),
                child: body,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextFields extends StatelessWidget {
  const _TextFields();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 216,
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _EmailTextField(),
          _PasswordTextField(),
          _NameTextField(),
        ],
      ),
    );
  }
}

class _EmailTextField extends ConsumerWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: _PrefixIconContainer(
          child: Icon(Icons.email),
        ),
        prefixIconConstraints: _prefixIconConstraints,
        hintText: 'メールアドレス',
        filled: false,
      ),
      keyboardType: TextInputType.emailAddress,
      controller: ref.watch(emailProvider),
      textInputAction: TextInputAction.next,
      validator: emailValidator,
    );
  }
}

class _PasswordTextField extends ConsumerWidget {
  const _PasswordTextField();

  static const _providerKey = 'sign_in_password';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: _PrefixIconContainer(
          child: Icon(Icons.key),
        ),
        prefixIconConstraints: _prefixIconConstraints,
        hintText: 'パスワード',
        filled: false,
        suffixIcon: PasswordTextFieldSuffixIcon(
          providerKey: _providerKey,
        ),
      ),
      obscureText: ref.watch(
        PasswordTextFieldProviders.obscureFamily(_providerKey),
      ),
      keyboardType: TextInputType.visiblePassword,
      controller: ref.watch(passwordProvider),
      onFieldSubmitted: (text) => ref.watch(passwordProvider).clear(),
      validator: passwordValidator,
    );
  }
}

class _NameTextField extends ConsumerWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: _PrefixIconContainer(
          child: Icon(Icons.person),
        ),
        prefixIconConstraints: _prefixIconConstraints,
        hintText: '名前',
        filled: false,
      ),
      keyboardType: TextInputType.text,
      controller: ref.watch(nameProvider),
      validator: nameValidator,
    );
  }
}

class _PrefixIconContainer extends StatelessWidget {
  const _PrefixIconContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      width: 32,
      child: child,
    );
  }
}

class _SignUpButton extends ConsumerWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ButtonSizedBox(
      child: FilledButton(
        onPressed: () => print('サブミット'),
        child: const FittedBox(
          child: Text(
            'アカウント作成',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _SignInButton extends ConsumerWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ButtonSizedBox(
      child: TextButton(
        onPressed: () {
          const SignInRoute().push<void>(context);
        },
        child: const FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ログインの場合はこちら',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonSizedBox extends StatelessWidget {
  const _ButtonSizedBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: child,
    );
  }
}

const _prefixIconConstraints = BoxConstraints(minWidth: 0);

final _isInProgressProvider = StateProvider.autoDispose((ref) {
  return false;
});

@visibleForTesting
final validateProvider = Provider.autoDispose(
  (ref) => () {
    return ref.read(_formStateProvider).currentState?.validate();
  },
);

@visibleForTesting
final emailProvider = ChangeNotifierProvider.autoDispose(
  (ref) => TextEditingController(),
);

@visibleForTesting
final passwordProvider = ChangeNotifierProvider.autoDispose(
  (ref) => TextEditingController(),
);

@visibleForTesting
final nameProvider = ChangeNotifierProvider.autoDispose(
  (ref) => TextEditingController(),
);

final _formStateProvider = Provider.autoDispose((_) => GlobalKey<FormState>());

class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}
