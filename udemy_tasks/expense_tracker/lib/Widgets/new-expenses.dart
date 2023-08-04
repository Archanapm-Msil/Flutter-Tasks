import 'package:expense_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Model/expense.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpenses> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Categories _selectedCategory = Categories.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveResponse() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            ),
          ],
          title: const Text(Constants.invalidInput),
          content: const Text(Constants.alertMessage),
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
        Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
   final keyboardSpace =  MediaQuery.of(context).viewInsets.bottom;
   return LayoutBuilder(builder: (ctx,constraints) {
    final width = constraints.maxWidth;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text(Constants.title),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        label: Text(Constants.amount),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  _buildDropDown(),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: const Text(Constants.cancelButtonText)),
                  ElevatedButton(
                    onPressed: _saveResponse,
                    child: const Text(Constants.saveResoponseBtnText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
   });

  }

  DropdownButton _buildDropDown() {
    return DropdownButton(
        value: _selectedCategory,
        items: Categories.values
            .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase()),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value == null) {
              return;
            }
            _selectedCategory = value;
          });
        });
  }
}
