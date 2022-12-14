import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Function(String val)? onSubmitted;
  final Function(String val) onChange;


  const CustomTextField({
    Key? key,
    required this.title,
    required this.onChange,
    this.onSubmitted,
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
        onChanged: onChange,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: title,
          suffixIcon: SizedBox(
            width: 50,
            child: Row(
              children: [
                const VerticalDivider(
                  width: 2,
                  thickness: 1,
                  indent: 13,
                  endIndent: 10,
                  color: Colors.grey,
                ),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: const Icon(
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
