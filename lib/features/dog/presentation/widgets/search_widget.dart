import 'package:buddy/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.onSearch});

  final Function onSearch;
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

//TODO max lines bug when bottom sheet is full
class _SearchWidgetState extends State<SearchWidget> {
  String _text = '';

  void _showBottomSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController controller = TextEditingController();
    controller.text = _text;

    showMaterialModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        // Rounded top corners
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: .55,
        maxChildSize: .88,
        minChildSize: .55,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPaddingValue),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BottomSheetDashWidget(),
                  TextField(
                    autofocus: true,
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                    //max lines if child size 0.55 then 3 if 0.85 then 5

                    maxLines: getMaxLines(scrollController, size.height),
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      _text = value;
                      widget.onSearch(value);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).then((_) {
      setState(
          () {}); // Update the state with the entered text once the bottom sheet is closed
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddingValue, vertical: kDefaultPaddingValue),
        margin: const EdgeInsets.symmetric(vertical: kDefaultPaddingValue),
        width: size.width,
        height: 64,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(kDefaultBorderRadiusValue),
          color: theme.colorScheme.background,
        ),
        child: SingleChildScrollView(
            child: Text(_text.isEmpty ? 'Search' : _text)),
      ),
    );
  }

  // max lines if child size 0.55 then 3 if 0.85 then infinity
  int? getMaxLines(ScrollController scrollController, double height) {
    if (scrollController.hasClients) {
      if (scrollController.position.viewportDimension <= height * 0.55) {
        return 3;
      } else {
        return null;
      }
    }
    return 3;
  }
}

class BottomSheetDashWidget extends StatelessWidget {
  const BottomSheetDashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        width: 40,
        height: 6,
        decoration: BoxDecoration(
          color: theme.dividerColor,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
