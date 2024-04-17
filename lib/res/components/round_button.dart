import 'package:flutter/material.dart';
import 'package:mvvm/res/components/color.dart';

class RoundButton extends StatefulWidget {
  final String title;
  final bool loading;
  final VoidCallback onpress;
  const RoundButton({super.key, this.loading =false, required this.onpress, required this.title});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColor.buttoncolor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: widget.loading ? CircularProgressIndicator() : Text(widget.title,style: TextStyle(color: AppColor.white),)),
      ),
    );
  }
}
