import 'package:frontend_mentor_rock_paper_scissors/common.dart';

class LayoutProvider extends InheritedWidget {
  const LayoutProvider({
    super.key,
    required super.child,
    required this.isDesktop,
  });

  final bool isDesktop;

  static LayoutProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LayoutProvider>();
  }

  static LayoutProvider of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No LayoutProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LayoutProvider oldWidget) =>
      isDesktop != oldWidget.isDesktop;
}
