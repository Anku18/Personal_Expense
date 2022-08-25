import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: transactions.isEmpty
              ? Column(
                  children: [
                    Text(
                      'No transactionsn added yet!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assests/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Container(
                              child: FittedBox(
                                  child:
                                      Text('\$${transactions[index].amount}')),
                            ),
                          ),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).appBarTheme.titleTextStyle,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: (() => deleteTx(transactions[index].id)),
                        ),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                ),
        );
      },
    );
  }
}
