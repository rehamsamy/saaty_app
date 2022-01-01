Expanded(
flex: 1,
child: Card(
margin: EdgeInsets.all(2),
elevation: 6,
child: Padding(
padding: EdgeInsets.all(5),
child: TextFormField(
controller: _searcController,
focusNode: _textFocus,
onChanged: onTextChange,
decoration: InputDecoration(
hintText: 'search',
prefixIcon: Icon(
Icons.search,
color: Cons.accent_color,
size: 25,
),
suffixIcon: IconButton(
icon: Icon(
Icons.filter_list_alt,
color: Cons.accent_color,
size: 25,
),
onPressed: () {
buildFilterDialogWidget(context);
},
),
// SizedBox(
//     width:10,
//     height:10,child: Image.asset('assets/images/nav_filter.png',width: 15,height: 15,)),
enabledBorder: UnderlineInputBorder(
borderSide: BorderSide(
color: Cons.accent_color,
width: 1.0,
),
)
//ثى prefix: Icon(Icons.search,color: Cons.accent_color,)
),
),
),
),
),