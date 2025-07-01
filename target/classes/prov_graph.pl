wasControlledBy('create_account','Bob','owner',10,15).
wasControlledBy('consent','Bob','owner',16,20).
wasControlledBy('joinGroup','Bob','owner',20,21).
wasControlledBy('update','Bob','owner',29,30).
wasControlledBy('askDataAccess','Bob','owner',36,37).
wasControlledBy('sendData','Bob','receiver',44700,44703).
wasControlledBy('askErase','Bob','owner',44800,44800).
wasControlledBy('sendData','DC','owner',44700,44703).
wasGeneratedBy('marketing_cookie','createCookie','cookie',21).
wasGeneratedBy('id_bob','create_account','personal data',15).
wasGeneratedBy('email_bob','create_account','personal data',15).
wasGeneratedBy('privacy_policy_template','create_account','policy',15).
wasGeneratedBy('wall_bob','create_account','personal data',15).
wasGeneratedBy('friend_list_bob','create_account','personal data',15).
wasGeneratedBy('phone_bob','create_account','personal data',15).
wasGeneratedBy('consent_bob_v0','consent','consent',17).
wasGeneratedBy('consent_bob_v1','update','consent',29).
wasGeneratedBy('data_request','askDataAccess','request',37).
wasGeneratedBy('data_report','sendData','data response',44703).
wasTriggeredBy('createCookie','joinGroup','information',21).
wasTriggeredBy('consent','create_account','policy_used',15).
used('createCookie','id_bob','id',21).
used('sendCookie','marketing_cookie','cookie',26).
used('consent','privacy_policy_template','template',16).
used('update','consent_bob_v0','consent',29).
used('sendData','data_request','request',44701).
used('askErase','phone_bob','to erase data',44800).
action('createCookie','createCookie').
action('sendCookie','thirdParties').
action('create_account','createAccount').
action('consent','consent').
action('joinGroup','joinGroup').
action('update','updateConsent').
action('askDataAccess','askDataAccess').
action('sendData','sendData').
action('askErase','askErase').
purposes('consent_bob_v0','__purposes',['thirdParties','analysis','improvement']).
purposes('consent_bob_v0','consent_type',purposes_consent).
purposes('consent_bob_v1','__purposes',['analysis','improvement']).
purposes('consent_bob_v1','consent_type',purposes_consent).
purposes(_,'__purposes',['consent','delete','sendData','askErase','askDataAccess','createCookie']).
purposes(_,'consent_type',purposes_consent).
