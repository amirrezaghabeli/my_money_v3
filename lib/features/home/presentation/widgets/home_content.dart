import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_money_v3/core/utils/hex_color.dart';
import 'package:my_money_v3/core/utils/price_format.dart';
import 'package:my_money_v3/features/home/domain/entities/home_info_entity.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../config/routes/app_routes.dart';
import '../cubit/home_info_cubit.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.homeInfoList,
  }) : super(key: key);

  final HomeInfoEntity homeInfoList;

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height - 24;
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          reportGeneral(height),
          reportByCategory(height, context),
        ],
      ),
    );
  }

  Container reportGeneral(double height) {
    final jalali = Jalali.now();
    return Container(
      padding: const EdgeInsets.all(12),
      height: height * .3,
      child: Column(
        children: [
          reportGeneralItem(
            'هزینه امروز (${jalali.formatShortMonthDay()})',
            homeInfoList.todayPrice,
          ),
          const SizedBox(
            height: 12,
          ),
          reportGeneralItem(
            'هزینه ماه (${jalali.formatter.mN})',
            homeInfoList.monthPrice,
          ),
          const SizedBox(
            height: 12,
          ),
          reportGeneralItem('هزینه ۳۰ روز گذشته', homeInfoList.thirtyDaysPrice),
          const SizedBox(
            height: 12,
          ),
          reportGeneralItem('هزینه ۹۰ روز گذشته', homeInfoList.ninetyDaysPrice),
        ],
      ),
    );
  }

  Container reportGeneralItem(String title, int price) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(priceFormat(price)),
        ],
      ),
    );
  }

  Container reportByCategory(double height, BuildContext context) {
    return Container(
      height: height * .7,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'هزینه های این ماه با دسته بندی',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.expenseListRoute).then(
                    (value) =>
                        BlocProvider.of<HomeInfoCubit>(context).getHomeInfo(),
                  );
                },
                child: const Text('مشاهده همه'),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: homeInfoList.expenseByCategory.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemBuilder: (context, index) {
                final item = homeInfoList.expenseByCategory[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                color: HexColor(
                                  item.color,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(item.title),
                            ],
                          ),
                          Text(
                            priceFormat(item.price),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 2,
                      color: HexColor(item.color),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
