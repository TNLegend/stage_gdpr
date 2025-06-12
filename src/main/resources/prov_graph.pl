wasControlledBy('createAccount','David','owner',1,7).
wasControlledBy('consent','David','owner',8,9).
wasControlledBy('sendTicket','David','owner',10,13).
wasGeneratedBy('physicalAddress_David_1','createAccount','personal data',6).
wasGeneratedBy('id_David_1','createAccount','personal data',7).
wasGeneratedBy('consent_David_1','consent','consent',9).
wasGeneratedBy('ticket','sendTicket','ticket to send',12).
wasGeneratedBy('bankAccount_David_1','createAccount','personal data',2).
wasGeneratedBy('phoneNumber_David_1','createAccount','personal data',3).
wasGeneratedBy('mail_David_1','createAccount','personal data',4).
wasGeneratedBy('name_David_1','createAccount','personal data',5).
used('sendTicket','ticket','ticket sent',13).
used('sendTicket','mail_David_1','ticket sender mail',11).
action('createAccount','createAccount').
action('consent','consent').
action('sendTicket','sendTicket').
action('sendData','sendData').
action('sendThirdPartiesCookie','sendThirdPartiesCookie').
action('updateData','updateData').
action('sendAdSMS','sendAdSMS').
action('sendMail','sendMail').
action('sendImprovementCookie','sendImprovementCookie').
action('buyItem','buyItem').
action('delete','delete').
action('askDataAccess','askDataAccess').
action('askRefund','askRefund').
action('sendPersonalizationCookie','sendPersonalizationCookie').
action('sendAnalysisCookie','sendAnalysisCookie').
action('providePolicy','providePolicy').
action('askErase','askErase').
action('updateConsent','updateConsent').
action('refund','refund').
purposes('consent_David_1','consent_type_purposes',[]).
purposes('consent_David_1','phoneNumber_David_1_purposes_purposes_purposes_purposes',['sendAdSMS']).
purposes('consent_David_1','id_David_1_purposes_purposes_purposes_purposes',['sendImprovementCookie','sendThirdPartiesCookie']).
purposes('consent_David_1','consent_type_purposes_purposes',[]).
purposes('consent_David_1','consent_type_purposes_purposes_purposes',[]).
purposes('consent_David_1','consent_type',purposes_consent).
purposes(_,'physicalAddress_David_1_purposes_purposes_purposes_purposes',['buyItem']).
purposes(_,'consent_type_purposes',[]).
purposes(_,'name_David_1_purposes_purposes_purposes_purposes',['buyItem']).
purposes(_,'mail_David_1_purposes_purposes_purposes_purposes',['sendMail','sendTicket']).
purposes(_,'consent_type_purposes_purposes',[]).
purposes(_,'consent_type_purposes_purposes_purposes',[]).
purposes(_,'bankAccount_David_1_purposes_purposes_purposes_purposes',['buyItem','askRefund','refund']).
purposes(_,'consent_type',purposes_consent).
purposes(_,'__purposes_purposes_purposes_purposes',['consent','delete','askErase','sendData','askDataAccess','updateConsent','updateData','createAccount']).
