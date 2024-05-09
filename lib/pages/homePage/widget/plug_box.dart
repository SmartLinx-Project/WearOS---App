import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/object/light.dart';
import '../../../services/object/plug.dart';

class PlugBox extends StatefulWidget {
  Function sendMessage;
  Plug device;
  PlugBox({super.key, required this.device, required this.sendMessage});

  @override
  State<PlugBox> createState() => _PlugBoxState();
}

class _PlugBoxState extends State<PlugBox> {
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
              'assets/images/plug.png',
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
            (widget.device.isOnline)
                ? Transform.scale(
                    scale: 0.6,
                    child: Switch(
                        value: widget.device.state,
                        onChanged: (newValue) {
                          setState(() {
                            if(newValue){
                              widget.sendMessage(widget.device.deviceID, true, 'plug');
                            } else{
                              widget.sendMessage(widget.device.deviceID, false, 'plug');
                            }
                          });
                        }),
                  )
                : Text(
                    'Offline',
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.displaySmall!.fontFamily,
                      color: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .color
                          ?.withOpacity(0.7),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
            if (!widget.device.isOnline) const Spacer(),
          ],
        ),
      ),
    );
  }
}
