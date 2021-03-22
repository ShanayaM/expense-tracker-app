// import "package:flutter/material.dart";

// class ChartBar extends StatefulWidget {
//   final String label;
//   final double spendingAmount;
//   final double spendingPctOfTotal;

//   ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

//   @override
//   _ChartBarState createState() => _ChartBarState();
// }

// class _ChartBarState extends State<ChartBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Container(
//           height: 20,
//           child: FittedBox(
//               child: Text("${widget.spendingAmount.toStringAsFixed(0)}"))),
//       SizedBox(height: 6),
//       Container(
//         height: 60,
//         width: 10,
//         child: Stack(children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey, width: 1.0),
//               color: Colors.grey,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           FractionallySizedBox(
//               heightFactor: widget.spendingPctOfTotal,
//               child: Container(
//                   decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: BorderRadius.circular(10),
//               )))
//         ]),
//       ),
//       SizedBox(height: 6),
//       Text(widget.label),
//       SizedBox(height: 6),
//     ]);
//   }
// }
