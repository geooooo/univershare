import 'package:flutter/material.dart';

import '../../services/intl.dart' as intl;
import '../common/vertical_space.dart';

class EventInfo extends StatelessWidget {

  final String eventId;
  final String eventName;

  EventInfo({
    this.eventId,
    this.eventName,
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: 50,
    ),
    child: Column(
      children: <Widget>[
        TextFormField(
          initialValue: eventName,
          decoration: InputDecoration(
            labelText: intl.nameEvent,
          ),
          enabled: false,
        ),
        VerticalSpace(20),
       TextFormField(
          initialValue: eventId,
          decoration: InputDecoration(
            labelText: intl.idEvent,
          ),
          enabled: false,
        ),
      ],
    )
  );

}
