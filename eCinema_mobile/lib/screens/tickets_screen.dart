import 'package:ecinema_mobile/models/reservation.dart';
import 'package:ecinema_mobile/providers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/error_dialog.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late ReservationProvider _reservationProvider;
  List<Reservation> reservations = <Reservation>[];

  @override
  void initState() {
    super.initState();
    _reservationProvider = context.read<ReservationProvider>();
    loadReservations();
  }

  Future loadReservations() async {
    try {
      var data = await _reservationProvider.getByUserId(1);
      print(data);
      setState(() {
        reservations = data;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tickets"),
      ),
      body:Column(
        children: [
          SizedBox(height: 20,),
          Text(
            "Moje Rezervacije",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.teal),
          ),
          SizedBox(height: 10), // Add spacing between title and list
          Expanded(
            child: _buildReservationList(reservations),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationList(List<Reservation> reservations) {
    return ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        return _buildReservation(context, reservations[index]);
      },
    );
  }

  Widget _buildReservation(BuildContext context, Reservation reservation) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal, width: 1.0), // Adjust color and width
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ),
      child: Row(
        children: [
          // Left side: Image
          Container(
            margin: EdgeInsets.only(right: 16),
            child:ClipRRect(
              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
              child: Image.network(
                'https://picsum.photos/250?image=1',
                width: 120,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Right side: Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(Icons.play_arrow_rounded, color: Colors.teal),
                  SizedBox(height: 15), // Add spacing between icons and text
                  Icon(Icons.calendar_month, color: Colors.teal),
                  SizedBox(height: 15), // Add spacing between icons and text
                  Icon(Icons.timer_outlined, color: Colors.teal),
                ],
              ),
              SizedBox(width: 15), // Add spacing between icons and text
              Column(
                children: [
                  Text(
                    reservation.show.movie.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  SizedBox(height: 15), // Add spacing between icons and text
                  Text(
                    reservation.show.date.toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  SizedBox(height: 15), // Add spacing between icons and text
                  Text(
                    reservation.show.startTime.toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
