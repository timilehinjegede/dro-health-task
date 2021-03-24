import 'package:dro_health/data/models/models.dart';
import 'package:dro_health/logic/bag/cubit/bag_cubit.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckOutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _bagCubit = BlocProvider.of<BagCubit>(context);
    return BlocBuilder<BagCubit, BagState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                YBox(10),
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                YBox(10),
                Row(
                  children: [
                    SvgPicture.asset(
                      bag,
                      height: 25,
                      width: 25,
                      fit: BoxFit.cover,
                      color: whiteColor,
                    ),
                    XBox(5),
                    Text(
                      'Bag',
                      style: theme.textTheme.headline6.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(45 / 2),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                        ),
                        child: Center(
                          child: Text(
                            state.bagItems.length.toString(),
                            style: theme.textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                YBox(25),
                Container(
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.0),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        color: blackColor.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Tap on an item for add, remove, delete options',
                      style: theme.textTheme.caption.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                YBox(25),
                _BagItemsSection(
                  bagItems: state.bagItems,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: theme.textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: whiteColor,
                      ),
                    ),
                    Text(
                      formatMoney(
                        _bagCubit.getTotalPrice(),
                      ),
                      style: theme.textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
                YBox(15),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    color: whiteColor,
                    textColor: blackColor,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'Checkout',
                      style: theme.textTheme.bodyText1.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BagItemsSection extends StatefulWidget {
  final List<BagItem> bagItems;

  const _BagItemsSection({Key key, this.bagItems}) : super(key: key);

  @override
  __BagItemsSectionState createState() => __BagItemsSectionState();
}

class __BagItemsSectionState extends State<_BagItemsSection> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final _bagCubit = BlocProvider.of<BagCubit>(context);
    return Column(
      children: [
        ...List.generate(
          widget.bagItems.length,
          (index) => Column(
            children: [
              _BagItemEntry(
                bagItem: widget.bagItems[index],
                onTap: () {
                  _bagCubit.getBagItem(widget.bagItems[index].medication);
                  setState(() {
                    if (_selectedIndex == index) {
                      _selectedIndex = -1;
                    } else {
                      _selectedIndex = index;
                    }
                  });
                },
                index: index,
                isSelected: index == _selectedIndex,
              ),
              YBox(10),
            ],
          ),
        ),
      ],
    );
  }
}

class _BagItemEntry extends StatefulWidget {
  final BagItem bagItem;
  final VoidCallback onTap;
  final bool isSelected;
  final int index;

  const _BagItemEntry({
    Key key,
    this.bagItem,
    this.onTap,
    this.isSelected,
    this.index,
  }) : super(key: key);

  @override
  __BagItemEntryState createState() => __BagItemEntryState();
}

class __BagItemEntryState extends State<_BagItemEntry>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _bagCubit = BlocProvider.of<BagCubit>(context);
    return BlocBuilder<BagCubit, BagState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          child: Column(
            children: [
              InkWell(
                onTap: widget.onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              widget.bagItem.medication.imgSrc,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      XBox(10),
                      Text(
                        'x${state.bagItems[widget.index].quantity}',
                        style: theme.textTheme.caption.copyWith(
                          color: whiteColor,
                          fontSize: 15,
                        ),
                      ),
                      XBox(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.bagItems[widget.index].medication.name,
                            style: theme.textTheme.bodyText1.copyWith(
                              color: whiteColor,
                            ),
                          ),
                          YBox(2),
                          Text(
                            state.bagItems[widget.index].medication.type,
                            style: theme.textTheme.caption.copyWith(
                              color: whiteColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        formatMoney(
                          state.bagItems[widget.index].medication.price *
                              state.bagItems[widget.index].quantity,
                        ),
                        style: theme.textTheme.bodyText1.copyWith(
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              YBox(3),
              AnimatedSize(
                alignment: Alignment.topCenter,
                duration: Duration(
                  milliseconds: 400,
                ),
                curve: Curves.easeInOut,
                vsync: this,
                child: widget.isSelected
                    ? Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete_rounded,
                              color: whiteColor,
                              size: 30,
                            ),
                            onPressed: () =>
                                _bagCubit.removeItemFromBag(widget.bagItem),
                          ),
                          Spacer(),
                          _ActionButton(
                            title: '-',
                            onTap: () =>
                                _bagCubit.decreaseItemQuantity(widget.bagItem),
                          ),
                          XBox(5),
                          SizedBox(
                            width: 20,
                            child: Center(
                              child: Text(
                                state.bagItems[widget.index].quantity
                                    .toString(),
                                style: theme.textTheme.bodyText1.copyWith(
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                          XBox(5),
                          _ActionButton(
                            title: '+',
                            onTap: () =>
                                _bagCubit.increaseItemQuantity(widget.bagItem),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ActionButton({
    Key key,
    @required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: whiteColor,
        ),
        child: Center(
          child: Icon(
            title == '+' ? Icons.add : Icons.remove,
            color: purpleColor,
          ),
        ),
      ),
    );
  }
}
