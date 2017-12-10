Update Providers
  Set doctorType = 'OD'
  Where doctorType = 'DDS';

Update Account_Members
  Set firstName = 'Lil John'
  Where policyAccountID = 1 and memberID = 2;
