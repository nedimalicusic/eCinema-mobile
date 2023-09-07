import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
        ),
        body: Column(
        children: [
          Expanded(child: _buildNotificationsList())
    ],
    )
    );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 10),
            _buildNotification(context),
            SizedBox(height: 5), // Dodajte prazan prostor između notifikacija
          ],
        );
      },
    );
  }

  Widget _buildNotification(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal, width: 1.0),
        borderRadius: BorderRadius.circular(16),
        color: Colors.teal
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Center the icon horizontally
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Icon(Icons.access_alarm, color: Colors.white),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rezervacija potvrđena',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  'Uspješno ste rezervisali termin 12. April 2022 u 10:30 sati u Plaza Mostaru.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
