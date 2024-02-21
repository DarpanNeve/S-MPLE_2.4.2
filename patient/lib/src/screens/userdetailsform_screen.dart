import 'package:flutter/material.dart';

class UserDetailsFormScreen extends StatefulWidget {
  const UserDetailsFormScreen({Key? key}) : super(key: key);

  @override
  _UserDetailsFormScreenState createState() => _UserDetailsFormScreenState();
}

class _UserDetailsFormScreenState extends State<UserDetailsFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _fullName = '';
  DateTime? _dateOfBirth;
  String _gender = '';
  String _phoneNumber = '';
  String _email = '';
  String _address = '';
  List<String> _allergies = [];
  List<String> _currentMedications = [];
  List<String> _pastMedicalConditions = [];
  List<String> _surgicalHistory = [];
  List<String> _familyMedicalHistory = [];
  String _insuranceProvider = '';
  String _policyNumber = '';
  String _groupNumber = '';
  String _currentHealthConcerns = '';
  String _healthGoals = '';
  String _preferredLanguage = '';
  String _preferredGender = '';
  String _preferredLocation = '';
  bool _consentToUseInformation = false;
  bool _receiveNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFullNameFormField(),
              SizedBox(height: 10,),
              _buildDateOfBirthFormField(),
              SizedBox(height: 10,),
              //_buildGenderFormField(),
              //SizedBox(height: 10,),
              _buildPhoneNumberFormField(),
              SizedBox(height: 10,),
              _buildEmailFormField(),
              SizedBox(height: 10,),
              _buildAddressFormField(),
              SizedBox(height: 10,),
              _buildAllergiesFormField(),
              SizedBox(height: 10,),
              _buildCurrentMedicationsFormField(),
              SizedBox(height: 10,),
              _buildPastMedicalConditionsFormField(),
              SizedBox(height: 10,),
              _buildSurgicalHistoryFormField(),
              SizedBox(height: 10,),
              _buildFamilyMedicalHistoryFormField(),
              SizedBox(height: 10,),
              _buildInsuranceProviderFormField(),
              SizedBox(height: 10,),
              _buildPolicyNumberFormField(),
              SizedBox(height: 10,),
              _buildGroupNumberFormField(),
              SizedBox(height: 10,),
              _buildCurrentHealthConcernsFormField(),
              SizedBox(height: 10,),
              _buildHealthGoalsFormField(),
              SizedBox(height: 10,),
              _buildPreferredLanguageFormField(),
              SizedBox(height: 10,),
              _buildPreferredGenderFormField(),
              SizedBox(height: 10,),
              _buildPreferredLocationFormField(),
              SizedBox(height: 10,),
              _buildConsentToUseInformationFormField(),
              SizedBox(height: 10,),
              _buildReceiveNotificationsFormField(),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Once form is validated and saved, you can submit the data
                    _submitForm();
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullNameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Full Name',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        return null;
      },
      onSaved: (value) {
        _fullName = value!;
      },
    );
  }

  Widget _buildDateOfBirthFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null && pickedDate != _dateOfBirth) {
          setState(() {
            _dateOfBirth = pickedDate;
          });
        }
      },
      readOnly: true,
      validator: (value) {
        if (_dateOfBirth == null) {
          return 'Please select your date of birth';
        }
        return null;
      },
      controller: TextEditingController(
        text: _dateOfBirth != null ? _dateOfBirth!.toString() : '',
      ),
    );
  }


  // Widget _buildGenderFormField() {
  //   return DropdownButtonFormField<String>(
  //     value: _gender,
  //     onChanged: (newValue) {
  //       setState(() {
  //         _gender = newValue!;
  //       });
  //     },
  //     items: [
  //       DropdownMenuItem<String>(
  //         value: 'Male',
  //         child: Text('Male'),
  //       ),
  //       DropdownMenuItem<String>(
  //         value: 'Female',
  //         child: Text('Female'),
  //       ),
  //       DropdownMenuItem<String>(
  //         value: 'Other',
  //         child: Text('Other'),
  //       ),
  //     ],
  //     decoration: const InputDecoration(
  //       labelText: 'Gender',
  //       border: OutlineInputBorder(),
  //     ),
  //   );
  // }



  Widget _buildPhoneNumberFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        return null;
      },
      onSaved: (value) {
        _phoneNumber = value!;
      },
    );
  }


  Widget _buildEmailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }


  Widget _buildAddressFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Address',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your address';
        }
        return null;
      },
      onSaved: (value) {
        _address = value!;
      },
    );
  }


  Widget _buildAllergiesFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Allergies',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your allergies';
        }
        return null;
      },
      onSaved: (value) {
        _allergies = value!.split('\n');
      },
    );
  }


  Widget _buildCurrentMedicationsFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Current Medications',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your current medications';
        }
        return null;
      },
      onSaved: (value) {
        // Split the input by line breaks and add each line as a medication
        _currentMedications = value!.split('\n');
      },
    );
  }


  Widget _buildPastMedicalConditionsFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Past Medical Conditions',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your past medical conditions';
        }
        return null;
      },
      onSaved: (value) {
        // Split the input by line breaks and add each line as a past medical condition
        _pastMedicalConditions = value!.split('\n');
      },
    );
  }


  Widget _buildSurgicalHistoryFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Surgical History',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your surgical history';
        }
        return null;
      },
      onSaved: (value) {
        // Split the input by line breaks and add each line as a surgical history
        _surgicalHistory = value!.split('\n');
      },
    );
  }


  Widget _buildFamilyMedicalHistoryFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Family Medical History',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your family medical history';
        }
        return null;
      },
      onSaved: (value) {
        // Split the input by line breaks and add each line as a family medical history
        _familyMedicalHistory = value!.split('\n');
      },
    );
  }


  Widget _buildInsuranceProviderFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Insurance Provider',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your insurance provider';
        }
        return null;
      },
      onSaved: (value) {
        _insuranceProvider = value!;
      },
    );
  }


  Widget _buildPolicyNumberFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Policy Number',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your policy number';
        }
        return null;
      },
      onSaved: (value) {
        _policyNumber = value!;
      },
    );
  }


  Widget _buildGroupNumberFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Group Number',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your group number';
        }
        return null;
      },
      onSaved: (value) {
        _groupNumber = value!;
      },
    );
  }


  Widget _buildCurrentHealthConcernsFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Current Health Concerns',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your current health concerns';
        }
        return null;
      },
      onSaved: (value) {
        _currentHealthConcerns = value!;
      },
    );
  }


  Widget _buildHealthGoalsFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Health Goals',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your health goals';
        }
        return null;
      },
      onSaved: (value) {
        _healthGoals = value!;
      },
    );
  }


  Widget _buildPreferredLanguageFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Preferred Language',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your preferred language';
        }
        return null;
      },
      onSaved: (value) {
        _preferredLanguage = value!;
      },
    );
  }


  Widget _buildPreferredGenderFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Preferred Gender',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your preferred gender';
        }
        return null;
      },
      onSaved: (value) {
        _preferredGender = value!;
      },
    );
  }


  Widget _buildPreferredLocationFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Preferred Location',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your preferred location';
        }
        return null;
      },
      onSaved: (value) {
        _preferredLocation = value!;
      },
    );
  }


  Widget _buildConsentToUseInformationFormField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
      ),
      child: CheckboxListTile(
        title: const Text('Consent to use information'),
        value: _consentToUseInformation,
        onChanged: (value) {
          setState(() {
            _consentToUseInformation = value!;
          });
        },
      ),
    );
  }


  Widget _buildReceiveNotificationsFormField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
      ),
      child: CheckboxListTile(
        title: const Text('Receive notifications'),
        value: _receiveNotifications,
        onChanged: (value) {
          setState(() {
            _receiveNotifications = value!;
          });
        },
      ),
    );
  }





  void _submitForm() {
    // You can access all the collected data here and perform further actions
    // For example, you can send the data to a backend server, store it locally, etc.
    // Example:
    print('Full Name: $_fullName');
    print('Date of Birth: $_dateOfBirth');
    print('Gender: $_gender');
    print('Phone Number: $_phoneNumber');
    print('Email: $_email');
    print('Address: $_address');
    // Print other collected data
  }
}
