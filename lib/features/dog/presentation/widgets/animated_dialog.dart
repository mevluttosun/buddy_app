// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:buddy/config/theme/app_theme.dart';
import 'package:buddy/features/dog/presentation/widgets/animations/bounce_in_animation.dart';
import 'package:buddy/features/dog/presentation/widgets/animations/slide_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Determines the animation that is used when building a [AnimatedDialog].
enum DialogAnimationType {
  // the default material animation
  material,

  // a playful bounce-in animation
  bounce,

  // a subtle slide animation
  slide,
}

/// A styled dialog used with [showDialog].
///
/// Confirming actions should always be placed on the right side while
/// dismissive actions should be placed on the left side.
class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({
    Key? key,
    this.title,
    this.titlePadding,
    this.content,
    this.contentPadding = const EdgeInsets.all(24),
    this.actions,
    this.constrainActionSize = false,
    this.animationType = DialogAnimationType.bounce,
    this.actionsAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided.
  final EdgeInsetsGeometry? titlePadding;

  /// The (optional) content of the dialog is displayed in the center of the
  /// dialog.
  final Widget? content;

  /// Padding around the content.
  ///
  /// If there is no content, no padding will be provided.
  final EdgeInsetsGeometry contentPadding;

  /// The (optional) set of actions that are displayed at the bottom of the
  /// dialog.
  ///
  /// Typically this is a list of [DialogAction] widgets.
  final List<Widget>? actions;

  /// Whether the size of the actions should be constrained to the intrinsic
  /// width of the dialog.
  ///
  /// When `true`, the actions might not have enough space and get clipped.
  final bool constrainActionSize;

  /// Determines the animation used for building the desi dialog.
  final DialogAnimationType animationType;

  /// Shows a [AnimatedDialog] with the given [title] and [content].
  final MainAxisAlignment actionsAlignment;

  @override
  _DesiDialogState createState() => _DesiDialogState();
}

class _DesiDialogState extends State<AnimatedDialog> {
  final GlobalKey _dialogSizeKey = GlobalKey();

  /// Completes with the size of the dialog content.
  ///
  /// Used to configure the size of the button bar to space around the actions
  /// based on the content width.
  final Completer<Size> _dialogSizeCompleter = Completer<Size>();

  EdgeInsets get _titlePadding =>
      widget.titlePadding as EdgeInsets? ??
      EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: widget.content != null || widget.actions != null ? 0 : 24,
      );

  @override
  void initState() {
    super.initState();

    _configureDialogSize();
  }

  void _configureDialogSize() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final box =
          _dialogSizeKey.currentContext?.findRenderObject() as RenderBox?;
      _dialogSizeCompleter.complete(box?.size);
    });
  }

  Widget _buildAnimation({required Widget child}) {
    switch (widget.animationType) {
      case DialogAnimationType.slide:
        return SlideInAnimation(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuad,
          offset: const Offset(0, 40),
          child: child,
        );
      case DialogAnimationType.bounce:
        return BounceInAnimation(child: child);
      case DialogAnimationType.material:
        return child;
    }
  }

  Widget _buildTitle(TextTheme textTheme) {
    return DefaultTextStyle(
      style: textTheme.titleLarge!.copyWith(height: 1.2),
      textAlign: TextAlign.center,
      child: Padding(
        padding: _titlePadding,
        child: widget.title,
      ),
    );
  }

  Widget _buildContent(TextTheme textTheme) {
    return Flexible(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: textTheme.titleSmall!,
            textAlign: TextAlign.center,
            child: Padding(
              padding: widget.contentPadding,
              child: widget.content,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    final Widget actions = widget.actions!.length == 2
        ? Padding(
            padding: widget.contentPadding,
            child: Row(
              mainAxisAlignment: widget.actionsAlignment,
              children: [
                for (Widget action in widget.actions!)
                  Expanded(child: Center(child: action)),
              ],
            ),
          )
        : Padding(
            padding: widget.contentPadding,
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: widget.actions!,
            ),
          );

    if (widget.constrainActionSize) {
      return FutureBuilder<Size>(
        future: _dialogSizeCompleter.future,
        builder: (context, snapshot) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: snapshot.data?.width ?? 0,
            ),
            child: actions,
          );
        },
      );
    } else {
      return actions;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return _buildAnimation(
      child: Dialog(
        insetAnimationDuration: kShortAnimationDuration,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          key: _dialogSizeKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null) _buildTitle(textTheme),
              if (widget.content != null) _buildContent(textTheme),
              if (widget.actions != null) _buildActions(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Builds a [ElevatedButton] as an action for the [AnimatedDialog].
///
/// When [result] is not `null`, [Navigator.pop] is called with the [result]
/// when the button is tapped.
/// An additional [onTap] can be provided that is called when the button is
/// tapped.
///
/// When both [result] and [onTap] is `null`, the button will appear disabled.
///
/// Either [text] or [icon] must not be `null`.
class DialogAction<T> extends StatelessWidget {
  const DialogAction({
    Key? key,
    this.result,
    this.onTap,
    this.text,
    this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
  })  : assert(text != null || icon != null),
        super(key: key);

  final T? result;
  final VoidCallback? onTap;
  final String? text;
  final IconData? icon;
  final EdgeInsets padding;

  void _onTap(BuildContext context) {
    onTap?.call();

    if (result != null) {
      Navigator.of(context).pop<T>(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: result == null && onTap == null ? null : () => _onTap(context),
      child: text != null ? Text(text!) : null,
    );
  }
}
