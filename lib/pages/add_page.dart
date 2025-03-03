import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  final Map<String, dynamic>? repair;

  const AddPage({super.key, this.repair});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  DateTime? _selectedDate;
  String _status = 'กำลังดำเนินการ';

  @override
  void initState() {
    super.initState();
    if (widget.repair != null) {
      _titleController.text = widget.repair!['title'];
      _costController.text = widget.repair!['cost'].toString();
      _selectedDate = widget.repair!['date'];
      _status = widget.repair!['status'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มรายการซ่อม'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'รายการซ่อม',
                ),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกชื่อรายการ' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'ค่าใช้จ่ายโดยประมาณ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'กรุณากรอกค่าใช้จ่าย' : null,
              ),
              const SizedBox(height: 16),
              
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? 'เลือกวันที่'
                      : 'วันที่: ${_selectedDate!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField(
                value: _status,
                items: ['รอการอนุมัติ', 'กำลังดำเนินการ', 'เสร็จสิ้น']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'สถานะ',
                ),
              ),
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'title': _titleController.text,
                      'cost': _costController.text,
                      'date': _selectedDate,
                      'status': _status,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: const Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
