import 'package:flutter/material.dart';

class LableFeild extends StatefulWidget {
  String lable;
  List<String> selectedItems; // List to store selected tags
  final Function(List<String>)
      onSelectionChanged; // Callback to notify parent widget about selection changes

  LableFeild({
    super.key,
    required this.lable,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  _LableFeildState createState() => _LableFeildState();
}

class _LableFeildState extends State<LableFeild> {
  // Controller for the text field to capture user input
  final TextEditingController customItemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.lable,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 139, 117, 169),
          ),
        ),
        const SizedBox(height: 4),

        TextFormField(
         style: const TextStyle(color: Colors.black, fontSize: 20),
          controller: customItemController,
          // Input decoration for the text field, including label and suffix icon
          decoration: InputDecoration(
            
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              // Icon button with '+' icon to add the tag
              icon: const Icon(Icons.add),
              // Callback when the '+' icon is pressed to add the tag to the list
              onPressed: () {
                String customItem = customItemController.text.trim();
                // Check if the input is not empty and not already in the list
                if (customItem.isNotEmpty &&
                    !widget.selectedItems.contains(customItem)) {
                  setState(() {
                    // Add the input tag to the list and clear the text field
                    widget.selectedItems.add(customItem);
                    customItemController.clear();
                  });
                }
              },
            ),
          ),
        ),

        // Wrap widget to display selected tags as chips
        Wrap(
          spacing: 8,
          children: widget.selectedItems
              .map(
                (item) => Chip(
                  // Display the tag text inside a chip
                  backgroundColor: const Color(0xFFDECBF6),
                  label: Text(
                    item,
                    style: const TextStyle(
                        color: Color(
                          0xFF444444,
                        ),
                        fontSize: 15),
                  ),
                  // Icon button to remove the tag when pressed
                  deleteIcon: const Icon(
                    Icons.cancel,
                    color: Color(0xFF444444),
                  ),
                  // Callback when the delete icon is pressed to remove the tag from the list
                  onDeleted: () {
                    setState(() {
                      widget.selectedItems.remove(item);
                    });
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
