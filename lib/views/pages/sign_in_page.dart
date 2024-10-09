import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_calender/models/user.dart';
import 'package:h_calender/router.dart';
import 'package:h_calender/utils/validators.dart';
import 'package:h_calender/utils/errors.dart';
import 'package:h_calender/views/common/common_snackbar.dart';
import 'package:h_calender/views/pages/home_page.dart';
import 'package:h_calender/views/pages/widgets/password_text_field_utils.dart';
import 'package:h_calender/views/pages/widgets/progress_filter.dart';
import 'package:h_calender/views/pages/widgets/un_focus.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Scaffold(
        body: ListView(
      children: const [
        SizedBox(height: 60),
        _TextFields(),
        _SignInButton(),
        SizedBox(height: 10),
        _SignUpButton(),
        SizedBox(height: 10),
        _PasswordResetButton(),
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
              isInProgress: ref.watch(_Providers._isInProgressProvider),
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
      controller: ref.watch(_Providers.emailProvider),
      textInputAction: TextInputAction.next,
      validator: emailValidator,
    );
  }
}

class _PasswordTextField extends ConsumerWidget {
  const _PasswordTextField();

  static const _providerKey = 'sign_up_password';

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
      controller: ref.watch(_Providers.passwordProvider),
      onFieldSubmitted: (text) =>
          ref.watch(_Providers.passwordProvider).clear(),
      validator: passwordValidator,
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

class _SignInButton extends ConsumerWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ButtonSizedBox(
      child: FilledButton(
        onPressed: () async {
          // ログイン処理開始、ローディングを表示
          ref.read(_Providers._isInProgressProvider.notifier).state = true;

          await ref.read(_Providers.signInWithTextFieldValues)(
            onSuccess: () {
              // ログイン成功、ローディングを解除して画面遷移
              ref.read(_Providers._isInProgressProvider.notifier).state = false;
              const HomeRoute().go(context);
            },
            onError: (error) {
              // ログイン失敗、ローディングを解除してエラーメッセージを表示
              ref.read(_Providers._isInProgressProvider.notifier).state = false;
              CommonSnackBar.show(
                context: context,
                message: 'Sign in failed: $error',
              );
            },
          );
        },
        child: const FittedBox(
          child: Text(
            'ログイン',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends ConsumerWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ButtonSizedBox(
      child: TextButton(
        onPressed: () {
          const SignUpRoute().go(context);
        },
        child: const FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('初めて使う人はこちら',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordResetButton extends ConsumerWidget {
  const _PasswordResetButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ButtonSizedBox(
      child: TextButton(
        onPressed: () {
          const PasswordResetRoute().push(context);
        },
        child: const FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('パスワードを忘れた人はこちら',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
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

class SignInProviders {
  static final _isInProgressProvider = StateProvider.autoDispose((ref) {
    return false;
  });

  @visibleForTesting
  static final validateProvider = Provider.autoDispose(
    (ref) => () {
      return ref.read(_formStateProvider).currentState?.validate();
    },
  );

  @visibleForTesting
  static final emailProvider = ChangeNotifierProvider.autoDispose(
    (ref) => TextEditingController(),
  );

  @visibleForTesting
  static final passwordProvider = ChangeNotifierProvider.autoDispose(
    (ref) => TextEditingController(),
  );

  @visibleForTesting
  static final signInWithTextFieldValues = Provider.autoDispose(
    (ref) => ({
      required VoidCallback onSuccess,
      required OnError onError,
    }) async {
      if (ref.read(validateProvider)() == false) return;
      try {
        await ref.read(signInProvider)(
          email: ref.read(emailProvider).text,
          password: ref.read(passwordProvider).text,
        );
        onSuccess();
      } catch (error) {
        print(error);
      }
    },
  );
}

final _formStateProvider = Provider.autoDispose((_) => GlobalKey<FormState>());
const _prefixIconConstraints = BoxConstraints(minWidth: 0);
typedef _Providers = SignInProviders;
