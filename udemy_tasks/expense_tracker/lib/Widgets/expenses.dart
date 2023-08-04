import 'dart:math';

import 'package:expense_tracker/Model/expense.dart';
import 'package:expense_tracker/Widgets/charts/chart.dart';
import 'package:expense_tracker/Widgets/new-expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/utils/constants.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Categories.work),
    Expense(
        title: 'Cinema',
        amount: 16.69,
        date: DateTime.now(),
        category: Categories.leisure),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(onAddExpense: addExpense));
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(Constants.expenseDeleted),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text(Constants.emptyMessage),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = _buildExpenseList(_registeredExpenses, _removeExpense);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            Constants.titleText,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(onPressed: _openAddExpense, icon: const Icon(Icons.add))
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: 
                  Chart(expenses: _registeredExpenses),
                  ),
                  Expanded(child: mainContent)
                ],
              ));
  }

  ListView _buildExpenseList(
      List<Expense> expenses, void Function(Expense) removeItem) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          onDismissed: (direction) {
            removeItem(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: _buildExpenseItem(expenses[index])),
    );
  }

  Card _buildExpenseItem(Expense expense) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(height: 8),
                    Text(expense.FormattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
