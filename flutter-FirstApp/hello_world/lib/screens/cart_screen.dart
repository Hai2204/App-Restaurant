import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hello_world/data/data.dart';
import 'package:hello_world/modals/order.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  _buildCartItem(Order order) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 130.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(order.food.imageUrl),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            order.food.name,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow
                                .ellipsis, // and Expanded and container
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            order.restaurant.name,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(width: 0.8, color: Colors.black54),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //or mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        // color: Colors.red,
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Text(
                                  order.quantity.toString(),
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 20.0),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        // color: Colors.red,
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: Text('\$${order.food.price * order.quantity}',
                  style:
                      TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cart.forEach(
        (Order order) => {totalPrice += order.quantity * order.food.price});
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Card (${currentUser.cart.length})',
          textAlign: TextAlign.right,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: ListView.separated(
           physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (index < currentUser.cart.length) {
                Order order = currentUser.cart[index];
                return _buildCartItem(order);
              } // total...
              return Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Estimated Delivery Time:',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '25 min',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Cost:',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // '\$${totalPrice.round()}',
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700]),
                        ),
                      ],
                    ),
                     SizedBox(height: 10.0),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 20.0,
                color: Colors.grey,
              );
            },
            itemCount: currentUser.cart.length + 1),
      ),
      bottomSheet: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, -1), blurRadius: 6.0),
          ],
        ),
        child: Center(
          child: FlatButton(
            child: Text('CHECKOUT', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17.0,letterSpacing: 1.2),),
            onPressed: (){},
          ),
        ),
      ),
    );
  }
}
