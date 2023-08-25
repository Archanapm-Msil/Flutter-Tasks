import 'package:flutter/material.dart';


class CreateContactGroupBottomSheet extends StatefulWidget {
  final Function(String groupName) onCreateGroup;

  const CreateContactGroupBottomSheet({required this.onCreateGroup});

  @override
  _CreateContactGroupBottomSheetState createState() =>
      _CreateContactGroupBottomSheetState();
}

class _CreateContactGroupBottomSheetState
    extends State<CreateContactGroupBottomSheet> {
  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         const Text(
            'Enter Group Name',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
         const SizedBox(height: 8),
          TextField(
            controller: _groupNameController,
            decoration:const InputDecoration(
              hintText: 'Group Name',
              border: OutlineInputBorder(),
            ),
          ),
         const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final groupName = _groupNameController.text;
              if (groupName.isNotEmpty) {
                widget.onCreateGroup(groupName);
                Navigator.pop(context);
              }
            },
            child:const Text('Create Contact Group'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }
}
