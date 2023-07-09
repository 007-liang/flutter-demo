import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';

LifecycleWrapper lifecycleWrapper(Function onShow, Widget child) =>
      LifecycleWrapper(
          onLifecycleEvent: (event) {
            if (event == LifecycleEvent.visible) {
              onShow();
            }
          },
          child: child);