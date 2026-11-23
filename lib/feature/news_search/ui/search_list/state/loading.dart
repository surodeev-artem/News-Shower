import 'package:material_ui/material_ui.dart';

class SearchListLoadingState extends StatelessWidget {
  const SearchListLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: SizedBox.expand(child: Center(child: CircularProgressIndicator())),
    );
  }
}
