import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_calender/models/user.dart';
import 'package:h_calender/router.dart';
import 'package:h_calender/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: const [
            SizedBox(height: 24),
            _EmailTitle(),
            _NameTitle(),
            _SignOutTile(),
            _DeleteTile(),
            _UserInfo(),
            SizedBox(height: 24),
            _SignOutButton(),
          ],
        ));
  }
}

class _EmailTitle extends StatelessWidget {
  const _EmailTitle();

  @override
  Widget build(BuildContext context) {
    return _ListTile(
      icon: const Icon(Icons.email),
      title: 'メールアドレス変更',
      onTap: () => print('メアド変更'),
    );
  }
}

class _NameTitle extends StatelessWidget {
  const _NameTitle();

  @override
  Widget build(BuildContext context) {
    return _ListTile(
      icon: const Icon(Icons.person),
      title: '名前の変更',
      onTap: () => print('名前変更'),
    );
  }
}

class _SignOutTile extends StatelessWidget {
  const _SignOutTile();

  @override
  Widget build(BuildContext context) {
    return _ListTile(
      icon: const Icon(Icons.logout),
      title: 'ログアウト',
      onTap: () => print('ログアウト'),
    );
  }
}

class _DeleteTile extends StatelessWidget {
  const _DeleteTile();

  @override
  Widget build(BuildContext context) {
    return _ListTile(
      icon: const Icon(Icons.delete),
      title: 'アカウント削除',
      onTap: () => print('削除'),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Icon icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: icon,
        title: Text(title),
        onTap: onTap,
      ),
      const Divider(
        height: 0,
        color: AppTheme.darkGray,
      ),
    ]);
  }
}

// ユーザー情報表示ウィジェット
class _UserInfo extends ConsumerWidget {
  const _UserInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ユーザー情報をauthStateChangesProviderから取得
    final userAsyncValue = ref.watch(authStateChangesProvider);

    return userAsyncValue.when(
      data: (user) {
        if (user == null) {
          return const Text('ログインしていません');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('UID: ${user.uid}'),
            Text('Email: ${user.email}'),
            Text('Display Name: ${user.displayName ?? "未設定"}'),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('エラーが発生しました: $error'),
    );
  }
}

class _SignOutButton extends ConsumerWidget {
  const _SignOutButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () async {
        await ref.read(signOutProvider)();
      },
      child: const Text('ログアウト', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}
