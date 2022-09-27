import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Function(String val) onSubmitted;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xffF2F2F2),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)]),
      child: TextField(
        textAlign: TextAlign.start,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: title,
          suffixIcon: Container(
            width: 50,
            child: Row(
              children: [
                VerticalDivider(
                  width: 2,
                  thickness: 1,
                  indent: 13,
                  endIndent: 10,
                  color: Colors.grey,
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_list_alt,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
