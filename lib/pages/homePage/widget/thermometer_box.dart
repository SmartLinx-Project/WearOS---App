import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinxwearos/services/object/thermometer.dart';

import '../../../services/object/light.dart';
import '../../../services/object/plug.dart';

class ThermometerBox extends StatefulWidget {
  Thermometer device;
  ThermometerBox({super.key, required this.device});

  @override
  State<ThermometerBox> createState() => _ThermometerBoxState();
}

class _ThermometerBoxState extends State<ThermometerBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 300.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/thermometer.png',
              height: 37.h,
            ),
            const Spacer(),
            Text(
              (widget.device.name.length < 10) ? widget.device.name : '${widget.device.name.substring(0,10)}...',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.displayMedium!.fontFamily,
                color: Theme.of(context).textTheme.displayMedium!.color,
                fontSize: 23.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Spacer(),
            Text(
              '${widget.device.temperature.toStringAsFixed(1)}°',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.displayLarge!.fontFamily,
                color: Theme.of(context).textTheme.displayLarge!.color,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              '${widget.device.humidity.toStringAsFixed(0)}%',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.displayLarge!.fontFamily,
                color: Theme.of(context).textTheme.displayLarge!.color,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
