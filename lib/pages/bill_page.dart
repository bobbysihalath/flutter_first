import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/widgets/bill_wrapper.dart';

class BillSuccess extends StatelessWidget {
  const BillSuccess({
    this.refId,
    this.date,
    this.time,
    this.amount,
    this.fee,
    this.sender,
    this.recipient,
    this.senderAcct,
    this.recipientCard,
    this.currency,
    this.remark,
    Key key,
    this.recipientImgPath,
  }) : super(key: key);

  final String refId;
  final String date;
  final String time;
  final String amount;
  final String fee;
  final String sender;
  final String recipient;
  final String senderAcct;
  final String recipientCard;
  final String recipientImgPath;
  final String currency;
  final String remark;

  @override
  Widget build(BuildContext context) {
    return BillWrapper(
      header: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'Successfully',
                  style: TextStyle(fontSize: 19, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                AutoSizeText('$date -  $time', style: TextStyle(fontSize: 10)),
                AutoSizeText('Referent ID: $refId', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          // Positioned(child: Image.asset('assets/icons/ldb_wallet_tag.webp', height: 120), top: -5, left: 10),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            ListTile(
              leading: AutoSizeText("From"),
              title: AutoSizeText('$sender', textAlign: TextAlign.end),
              subtitle: AutoSizeText('$senderAcct', textAlign: TextAlign.end),
              trailing: CircleAvatar(
                backgroundImage: AssetImage('assets/icons/ldb_trust_logo.webp'),
                radius: 28,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 35),
              child: Image.asset('assets/images/arrow_down.png'),
            ),
            ListTile(
              leading: AutoSizeText("To"),
              title: AutoSizeText('$recipient', textAlign: TextAlign.end,  maxLines: 1),
              subtitle: AutoSizeText('$recipientCard', textAlign: TextAlign.end),
              trailing: CircleAvatar(
                backgroundImage: AssetImage(recipientImgPath),
                radius: 28,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
