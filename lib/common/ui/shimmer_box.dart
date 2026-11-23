import 'package:material_ui/material_ui.dart';

class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;

  const ShimmerBox({super.key, required this.width, required this.height});

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();

    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlight = Color.alphaBlend(
      Colors.white.withValues(alpha: 0.5),
      base,
    );

    return AnimatedBuilder(
      animation: _shimmer,
      builder: (_, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final slide = -2.2 + _shimmer.value * 4.4;
            return LinearGradient(
              begin: Alignment(slide, -0.2),
              end: Alignment(slide + 1.5, 0.2),
              colors: [base, base, highlight, base, base],
              stops: const [0.0, 0.1, 0.5, 0.9, 1.0],
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: ColoredBox(
        color: base,
        child: SizedBox(width: widget.width, height: widget.height),
      ),
    );
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }
}
