import 'package:flutter/material.dart';
import 'package:my_money_v3/config/locale/app_localizations.dart';
import 'package:my_money_v3/config/routes/app_routes.dart';
import 'package:my_money_v3/core/domain/entities/expense.dart';
import 'package:my_money_v3/core/utils/id_generator.dart';
import 'package:my_money_v3/core/domain/entities/category.dart';
import 'package:my_money_v3/features/add_edit_expanse/presentation/cubit/add_edit_expense_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditExpenseContent extends StatefulWidget {
  final Expense? expense;
  final List<Category> categories;

  const AddEditExpenseContent({
    Key? key,
    this.expense,
    required this.categories,
  }) : super(key: key);

  @override
  State<AddEditExpenseContent> createState() => _AddEditExpenseContentState();
}

class _AddEditExpenseContentState extends State<AddEditExpenseContent> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleCtrl.text = widget.expense!.title;
      _priceCtrl.text = widget.expense!.price.toString();
      selectedCategory = widget.expense!.category;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _titleCtrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              labelText: AppLocalizations.of(context)!.translate('title')!,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: _priceCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              labelText: AppLocalizations.of(context)!.translate('price')!,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.translate('select_date')!,
                ),
              ),
              const Text(
                '0000',
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)!.translate('category')!,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 0.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Category>(
                      value: selectedCategory,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (Category? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                      items: widget.categories.map<DropdownMenuItem<Category>>(
                        (Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text(value.title),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.addEditCategoryRoute);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              final expense = Expense(
                id: idGenerator(),
                title: _titleCtrl.text,
                date: DateTime.now().millisecondsSinceEpoch,
                categoryId: selectedCategory?.id ?? '',
                price: int.parse(_priceCtrl.text),
              );
              context.read<AddEditExpenseCubit>().addExpense(expense);
            },
            child: Text(AppLocalizations.of(context)!.translate('save')!),
          )
        ],
      ),
    );
  }
}
