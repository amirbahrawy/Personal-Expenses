import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTx;

  TransactionList(this._transactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 375,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                            child: Text(
                                '\$${_transactions[i].amount.toStringAsFixed(2)}')),
                      ),
                    ),
                    title: Text(
                      _transactions[i].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle:
                        Text(DateFormat.yMMMd().format(_transactions[i].date)),
                    trailing: IconButton(
                      color: Theme.of(context).errorColor,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteTx(_transactions[i].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}
