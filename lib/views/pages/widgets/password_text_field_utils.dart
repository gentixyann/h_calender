import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordTextFieldSuffixIcon extends ConsumerWidget {
  const PasswordTextFieldSuffixIcon({
    super.key,
    required this.providerKey,
  });

  final String providerKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: (ref.watch(_Providers.obscureFamily(providerKey))
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off)),
      onPressed: ref.read(_Providers._switchFamily(providerKey)),
    );
  }
}

class PasswordTextFieldProviders {
  static final obscureFamily = StateProvider.autoDispose.family(
    (ref, key) => true,
  );
  static final _switchFamily = Provider.autoDispose.family(
    (ref, key) => () {
      final currentState = ref.read(obscureFamily(key));
      ref.read(obscureFamily(key).notifier).state = !currentState;
    },
  );
}

typedef _Providers = PasswordTextFieldProviders;
