import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallBack,
    EverVoidCallback? everCallBack,
    ErrorVoidCallback? errorCallback,
  }) {
    changeNotifier.addListener(
      () {
        if (everCallBack != null) {
          everCallBack(changeNotifier, this);
        }
        if (changeNotifier.loading) {
          Loader.show(context);
        } else {
          Loader.hide();
        }

        if (changeNotifier.hasError) {
          if (errorCallback != null) {
            errorCallback(changeNotifier, this);
          }
          Messages.of(context)
              .showError(changeNotifier.error ?? 'Erro interno');
        } else if (changeNotifier.isSuccess) {
          if (successCallBack != null) {
            successCallBack(changeNotifier, this);
          }
        }
      },
    );
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);

typedef ErrorVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);

typedef EverVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);
