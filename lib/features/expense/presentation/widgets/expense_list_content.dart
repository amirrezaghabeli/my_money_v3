import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_money_v3/config/locale/app_localizations.dart';
import 'package:my_money_v3/config/routes/app_routes.dart';
import 'package:my_money_v3/core/utils/date_format.dart';
import 'package:my_money_v3/core/utils/hex_color.dart';
import 'package:my_money_v3/core/utils/price_format.dart';

import '../../../../core/domain/entities/expense.dart';
import '../cubit/expense_cubit.dart';

class ExpenseListContent extends StatefulWidget {
  final List<Expense> expenses;

  const ExpenseListContent({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  @override
  State<ExpenseListContent> createState() => _ExpenseListContentState();
}

class _ExpenseListContentState extends State<ExpenseListContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: widget.expenses.length,
          itemBuilder: (context, index) {
            return ExpenseCard(expense: widget.expenses[index]);
          },
        ),
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.addEditExpanseRoute,
          arguments: {
            'expense': Expense(
              id: expense.id,
              title: expense.title,
              price: expense.price,
              date: expense.date,
              categoryId: expense.categoryId,
            )
          },
        ).then((value) => BlocProvider.of<ExpenseCubit>(context).getExpenses());
      },
      child: Card(
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 100,
          child: Row(
            children: [
              Container(
                width: 10,
                height: 50,
                color: HexColor(expense.category!.color),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(expense.title),
                        Text(
                          '${priceFormat(expense.price)}}',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.translate('date')!}: ${dateFormat(expense.date)}',
                            ),
                            Text(expense.category!.title),
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                            await showDeleteDialog(context).then((value) {
                              if (value != null && value) {
                                BlocProvider.of<ExpenseCubit>(context)
                                    .deleteExpense(expense.id);
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> showDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content:
            Text(AppLocalizations.of(context)!.translate('delete_question')!),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(AppLocalizations.of(context)!.translate('yes')!),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(AppLocalizations.of(context)!.translate('no')!),
          ),
        ],
      );
    },
  );
}
