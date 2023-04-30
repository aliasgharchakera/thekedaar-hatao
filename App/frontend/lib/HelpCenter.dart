import 'package:flutter/material.dart';
import 'Drawer.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'ABOUT US',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'At thekeydaar hatao, we believe in providing our users with a seamless and hassle-free experience. We are committed to helping you build your dream home, from start to finish.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'FAQs',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    FaqWidget(
                      question: 'How does Thekeydaar Hatao work?',
                      answer:
                          'Thekeydaar Hatao is an app that eliminates the need for a middleman when building your dream house. We provide a platform for users to connect, a calculator to determine the amount of raw material needed, and a marketplace to purchase materials if required.',
                    ),
                    SizedBox(height: 16),
                    FaqWidget(
                      question:
                          'Is it possible to get assistance with the construction process?',
                      answer:
                          'Yes, Thekeydaar Hatao has a forum where users can connect with other users to get advice and assistance with the construction process. Additionally, we have a team of experts who are available to answer any questions you may have.',
                    ),
                    SizedBox(height: 16),
                    FaqWidget(
                      question:
                          'How do I calculate the amount of raw material required for my construction project?',
                      answer:
                          'Thekeydaar Hatao has a calculator feature that allows users to input their construction plans and dimensions to determine the amount of raw material required. This calculator is easy to use and provides accurate estimates for your construction project.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'CONTACT US',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'For further assistance, and any help regarding the application, please contact us at:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '09007811 (telephone)',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: MyBottomNavigationBar(authToken: widget.authToken),
      drawer: const CustomDrawer(),
    );
  }
}

class FaqWidget extends StatefulWidget {
  final String question;
  final String answer;

  const FaqWidget({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FaqWidgetState createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isOpen = !_isOpen;
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.question,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Icon(_isOpen
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
            ],
          ),
        ),
        if (_isOpen) ...[
          const SizedBox(height: 8),
          Text(
            widget.answer,
            style: const TextStyle(fontSize: 16),
          ),
        ],
        const Divider(),
      ],
    );
  }
}
