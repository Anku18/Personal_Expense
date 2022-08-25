import 'package:flutter/material.dart';
import './Widgets/newtransaction.dart';
import 'Widgets/transaction_list.dart';
import 'models/transaction.dart';
import './chart.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransaction = [
    /*Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 50.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shirt',
      amount: 10.99,
      date: DateTime.now(),
    ),*/
    /* Transaction(
      id: 't3',
      title: 'New Shirt',
      amount: 10.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'New Shirt',
      amount: 10.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'New Shirt',
      amount: 10.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'New Shirt',
      amount: 10.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'New Shirt',
      amount: 10.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'New Shirt',
      amount: 10.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't9',
      title: 'New Shirt',
      amount: 10.99,
      date: DateTime.now(),
    ),*/
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.23,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.77,
              child: TransactionList(_userTransaction, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
