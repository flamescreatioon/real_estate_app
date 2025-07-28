import 'package:flutter/material.dart';

class RecoveryOptionsScreen extends StatefulWidget {
  @override
  _RecoveryOptionsScreenState createState() => _RecoveryOptionsScreenState();
}

class _RecoveryOptionsScreenState extends State<RecoveryOptionsScreen> {
  String selectedOption = 'Email';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Recovery options',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'How would you like to recover your account?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),
            
            // Email Option
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 'Email';
                });
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedOption == 'Email' 
                        ? Colors.blue.withOpacity(0.3) 
                        : Colors.grey[200]!,
                    width: selectedOption == 'Email' ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "We'll send a recovery link to your email address.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<String>(
                      value: 'Email',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // SMS Option
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 'SMS';
                });
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedOption == 'SMS' 
                        ? Colors.blue.withOpacity(0.3) 
                        : Colors.grey[200]!,
                    width: selectedOption == 'SMS' ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SMS',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "We'll send a verification code to your phone number.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<String>(
                      value: 'SMS',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Verification Code Option
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 'Verification code';
                });
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedOption == 'Verification code' 
                        ? Colors.blue.withOpacity(0.3) 
                        : Colors.grey[200]!,
                    width: selectedOption == 'Verification code' ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Verification code',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Enter the verification code you received.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<String>(
                      value: 'Verification code',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            
            Spacer(),
            
            // Continue Button
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue action
                  _handleContinue();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _handleContinue() {
    // Show a dialog or navigate to next screen based on selected option
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recovery Method Selected'),
          content: Text('You selected: $selectedOption'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}