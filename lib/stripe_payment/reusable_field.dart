import 'package:flutter/material.dart';

class ReusableField extends StatefulWidget {
   const ReusableField({super.key ,required this.formKey ,required this.title,required 
   this.hint , this.isNumber,required this.textController});
final Key formKey;
final String title,hint;
final bool? isNumber;
final TextEditingController textController;


  @override
  State<ReusableField> createState() => _ReusableFieldState();
}

class _ReusableFieldState extends State<ReusableField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: widget.textController,
      keyboardType: (widget.isNumber ==null) 
      ? TextInputType.text
      : TextInputType.number ,
      decoration: InputDecoration(
        label: Text(widget.title),
        hintText: widget.hint
      ),
      // validator: (value)=> value!.isEmpty ? "Cannot be Empty" :null,
      onSaved: (value){
        debugPrint("$value button clicked");
      },
      ) );
  }
}