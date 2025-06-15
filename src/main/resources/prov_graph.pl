wasControlledBy('createAccount','Alice','owner',1,2).
wasControlledBy('consent','Alice','owner',3,4).
wasControlledBy('askDataAccess','Alice','owner',14,15).
wasControlledBy('sendAdSMS','DC','owner',8,11).
wasControlledBy('sendData','DC','owner',1064,1066).
wasControlledBy('createAccount','Bob','owner',1,2).
wasControlledBy('consent','Bob','owner',3,4).
wasControlledBy('askDataAccess','Bob','owner',24,25).
wasGeneratedBy('phoneNumber_Alice_1','createAccount','personal data',2).
wasGeneratedBy('consent_Alice_1','consent','consent',4).
wasGeneratedBy('ad','sendAdSMS','ad to send',9).
wasGeneratedBy('data_request_Alice','askDataAccess','request',15).
wasGeneratedBy('phoneNumber_Bob_1','createAccount','personal data',2).
wasGeneratedBy('consent_Bob_1','consent','consent',4).
wasGeneratedBy('data_request_Bob','askDataAccess','request',25).
wasGeneratedBy('data_report_Bob','sendData','data response',1066).
used('sendAdSMS','phoneNumber_Alice_1','user phone number',10).
used('sendAdSMS','ad','ad sms',11).
used('sendData','data_request_Bob','data request received',1065).
action('askDataAccess','askDataAccess').
action('consent','consent').
action('createAccount','createAccount').
action('sendData','sendData').
action('sendAdSMS','sendAdSMS').
action('sendThirdPartiesCookie','sendThirdPartiesCookie').
action('updateData','updateData').
action('sendMail','sendMail').
action('sendImprovementCookie','sendImprovementCookie').
action('login','login').
action('buyItem','buyItem').
action('delete','delete').
action('askRefund','askRefund').
action('sendTicket','sendTicket').
action('sendPersonalizationCookie','sendPersonalizationCookie').
action('sendAnalysisCookie','sendAnalysisCookie').
action('providePolicy','providePolicy').
action('askErase','askErase').
action('updateConsent','updateConsent').
action('refund','refund').
purposes('consent_Alice_1','consent_type_purposes',[]).
purposes('consent_Alice_1','phoneNumber_Alice_1_purposes_purposes',['sendAdSMS']).
purposes('consent_Alice_1','consent_type',purposes_consent).
purposes('consent_Bob_1','consent_type_purposes',[]).
purposes('consent_Bob_1','phoneNumber_Bob_1_purposes_purposes',[]).
purposes('consent_Bob_1','consent_type',purposes_consent).
purposes(_,'consent_type_purposes',[]).
purposes(_,'__purposes_purposes',['consent','delete','askErase','sendData','askDataAccess','updateConsent','accessWebPage','updateData','createAccount','login']).
purposes(_,'consent_type',purposes_consent).
