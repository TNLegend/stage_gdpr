wasControlledBy('createAccount','David','owner',1,7).
wasGeneratedBy('bankAccount_David_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('phoneNumber_David_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('mail_David_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('name_David_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('physicalAddress_David_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_David_1', 'createAccount', 'personal data', 7 ).


wasControlledBy('consent','David', 'owner', 8, 9).
wasGeneratedBy('consent_David_1', 'consent', 'consent', 9).

purposes(_,'bankAccount_David_1',['buyItem','askRefund','refund']).
purposes('consent_David_1','phoneNumber_David_1',['sendAdSMS']).
purposes(_,'mail_David_1',['sendMail','sendTicket']).
purposes(_,'name_David_1',['buyItem']).
purposes(_,'physicalAddress_David_1',['buyItem']).
purposes('consent_David_1','id_David_1',['sendImprovementCookie','sendThirdPartiesCookie']).

wasControlledBy('sendTicket','David', 'owner', 10, 13).
used('sendTicket', 'mail_David_1', 'ticket sender mail', 11).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 12).
used('sendTicket', 'ticket', 'ticket sent', 13).


action('sendData', 'sendData').
action('sendThirdPartiesCookie', 'sendThirdPartiesCookie').
action('updateData', 'updateData').
action('sendAdSMS', 'sendAdSMS').
action('sendMail', 'sendMail').
action('sendImprovementCookie', 'sendImprovementCookie').
action('createAccount', 'createAccount').
action('consent', 'consent').
action('buyItem', 'buyItem').
action('delete', 'delete').
action('askDataAccess', 'askDataAccess').
action('askRefund', 'askRefund').
action('sendTicket', 'sendTicket').
action('sendPersonalizationCookie', 'sendPersonalizationCookie').
action('sendAnalysisCookie', 'sendAnalysisCookie').
action('providePolicy', 'providePolicy').
action('askErase', 'askErase').
action('updateConsent', 'updateConsent').
action('refund', 'refund').
purposes(_,_,['consent','delete','askErase','sendData','askDataAccess','updateConsent','updateData','createAccount']).
