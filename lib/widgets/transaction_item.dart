import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTx;
  const TransactionItem({Key key, this.transaction, this.deleteTx})
      : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
   Color _bgColor;
  @override
  void initState() {
  const availbleColors=[
    Colors.red,
    Colors.purple,
    Colors.blue,
    Colors.black
  ];
  _bgColor=availbleColors[Random().nextInt(4)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
                child: Text('\$${widget.transaction.amount.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 450
            ? FlatButton.icon(
                onPressed: () {
                  widget.deleteTx(widget.transaction.id);
                },
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor)
            : IconButton(
                color: Theme.of(context).errorColor,
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deleteTx(widget.transaction.id);
                },
              ),
      ),
    );
  }
}
