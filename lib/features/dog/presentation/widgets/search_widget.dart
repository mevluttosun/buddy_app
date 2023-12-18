import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String _text = '';

  void _showBottomSheet(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = _text;

    showMaterialModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        // Rounded top corners
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 1.0,
        minChildSize: 0.5,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter text here',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      _text = value;
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
    return Scaffold(
      appBar: AppBar(title: const Text('Text Field Bottom Sheet Demo')),
      body: Center(
        child: GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(_text.isEmpty ? 'Tap here to enter text' : _text),
          ),
        ),
      ),
    );
  }
}
