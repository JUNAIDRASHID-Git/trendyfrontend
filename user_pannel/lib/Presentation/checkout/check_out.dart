import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/checkout/bloc/check_out_bloc.dart';
import 'package:trendychef/Presentation/checkout/widgets/check_out_price_row.dart';
import 'package:trendychef/Presentation/widgets/address_row/address_row_container.dart';
import 'package:trendychef/Presentation/widgets/buttons/payment.dart';
import 'package:trendychef/Presentation/widgets/product/expandable_product_list_view.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => CheckOutBloc()..add(CheckOutFetchEvent()),
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.fontWhite),
          ),
          title: Row(
            children: [
              Text(
                "Check Out",
                style: TextStyle(
                  color: AppColors.fontWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 5,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<CheckOutBloc, CheckOutState>(
                builder: (context, state) {
                  if (state is CheckOutLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CheckOutError) {
                    return Center(child: Text("Error: ${state.message}"));
                  } else if (state is CheckOutLoaded) {
                    final user = state.user;
                    final address = user.address;
                    final phone = user.phone;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpandableAddressRow(
                          address: address,
                          phone: phone ?? "",
                        ),
                        const SizedBox(height: 5),
                        ExpandableProductList(state: state),
                        const SizedBox(height: 10),
                        checkOutPriceDetailsRow(state),
                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: paymentSwipeButton(context),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
