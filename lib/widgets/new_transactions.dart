import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_flat_button.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx) {
    print('Constructor NewTransaction added');
  }

  @override
  _NewTransactionsState createState() {
    print('Create State NewTransaction added');
    return _NewTransactionsState();
  }
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionsState() {
    print('Constructor NewTransaction_State added');
  }
  @override
  void initState() {
    print('InitState NewTransaction added');
    super.initState();
  }

  // lw al parent 7aslo rebuild
  @override
  void didUpdateWidget(covariant NewTransactions oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget NewTransaction added');
  }

  @override
  void dispose() {
    print('Dispose');
    super.dispose();
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    if (_amountController.text.isEmpty) return;
    final enteredAmount = double.parse(_amountController.text);

    if (_selectedDate == null || enteredTitle.isEmpty || enteredAmount <= 0)
      return;
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDataPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    _selectedDate == null
                        ? 'No date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    style: TextStyle(fontSize: 16),
                  )),
                  SizedBox(
                    width: 6,
                  ),
                  AdaptiveFlatButton('Choose Date', _showDataPicker)
                ],
              ),
              RaisedButton(
                  onPressed: _submitData,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
