import 'package:material_ui/material_ui.dart';

class ShimmerBox extends StatelessWidget {
  final Animation<double> animation;
  final double width;
  final double height;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlight = Theme.of(context).colorScheme.surfaceContainerLow;

    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final slide = -2.2 + animation.value * 4.4;
            return LinearGradient(
              begin: Alignment(slide, -0.2),
              end: Alignment(slide + 1, 0.2),
              colors: [base, base, highlight, base, base],
              stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: ColoredBox(
        color: base,
        child: SizedBox(width: width, height: height),
      ),
    );
  }
}
