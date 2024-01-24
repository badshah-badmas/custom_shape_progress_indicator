import 'package:flutter/material.dart';
import 'package:custom_shape_progress_indicator/src/custom_painter.dart';

class CustomShapeProgressIndicator extends StatefulWidget {
  const CustomShapeProgressIndicator({
    this.progressLineThickness = 2,
    this.progressLineColor,
    this.backgroundColor,
    this.progress = 0,
    this.child,
    this.borderRadius = 10,
    this.height,
    this.width,
    this.infinityLoadingDelay = 3,
    this.backgroundLineThickness,
    super.key,
  });

  /// The progress of indicator
  ///
  /// The progress value of 0.0 means no progress and 1.0 means that progress is complete.
  /// The value will be clamped to be in the range 0.0-1.0.
  ///
  /// this progress indicator displays a predetermined animation when the progress is 0
  final double progress;

  /// The thickness of animating progress line
  ///
  /// Default value is 2 pixel
  final double progressLineThickness;

  /// The thickness of background shape line
  ///
  /// if the [backgroundLineThickness] is null,
  /// the [progressLineThickness] will use for background line thickness
  final double? backgroundLineThickness;

  /// The color of animating line
  ///
  /// if the value is null, primary color of app will be used.
  final Color? progressLineColor;

  /// The color of background line
  ///
  /// if the value is null, disabled color of app will be used.
  final Color? backgroundColor;

  /// Border radius of the shape
  ///
  /// default value is 10
  final double borderRadius;

  /// Height and width of the app.
  ///
  /// if the values are null, child widgets size will be adopted
  final double? height, width;

  /// Infinity loading animation delay
  ///
  /// The progress indicator displays a predetermined animation when the [progress] is 0,
  /// animation speed of the predetermined animation
  final int infinityLoadingDelay;

  /// child widget
  final Widget? child;
  @override
  State<CustomShapeProgressIndicator> createState() =>
      _CustomShapeProgressIndicatorState();
}

class _CustomShapeProgressIndicatorState
    extends State<CustomShapeProgressIndicator>
    with SingleTickerProviderStateMixin {
  //
  /// Animation controller for infinity progress animation
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.infinityLoadingDelay),
      vsync: this,
    );

    /// Infinity progress animation only works when the progress is 0
    // if (widget.progress == 0) {
    _controller.repeat();
    // }
  }

  OutLineCustomPainter _backgroundShapePainter(BuildContext context) {
    return OutLineCustomPainter(
      progress: 1,
      borderColor: widget.backgroundColor ?? Theme.of(context).disabledColor,
      radius: widget.borderRadius,
      strokeWidth:
          widget.backgroundLineThickness ?? widget.progressLineThickness,
    );
  }

  OutLineCustomPainter _progressLinePainter(BuildContext context) {
    return OutLineCustomPainter(
        progress: widget.progress,
        borderColor: widget.progressLineColor ?? Theme.of(context).primaryColor,
        strokeWidth: widget.progressLineThickness,
        radius: widget.borderRadius,
        animation: widget.progress == 0 ? _controller : null);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(50, 50),
      painter: _backgroundShapePainter(context),
      child: CustomPaint(
        size: Size(40, 10),
        painter: _progressLinePainter(context),
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
