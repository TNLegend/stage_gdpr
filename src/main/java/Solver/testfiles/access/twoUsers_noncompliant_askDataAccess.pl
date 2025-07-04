%%Attendu: erreur sur Alice (pas de réponse dans les temps)
wasControlledBy('createAccount','Alice','owner',1,2).
wasGeneratedBy('phoneNumber_Alice_1','createAccount','personal data', 2 ).

wasControlledBy('consent','Alice','owner',3, 4).
wasGeneratedBy('consent_Alice_1','consent','consent', 4).

purposes('consent_Alice_1','phoneNumber_Alice_1',['sendAdSMS']).

wasControlledBy('sendAdSMS','DC','owner', 8, 11).
wasGeneratedBy('ad','sendAdSMS','ad to send', 9).
used('sendAdSMS','phoneNumber_Alice_1','user phone number', 10).
used('sendAdSMS','ad','ad sms', 11).


wasControlledBy('askDataAccess','Alice','owner', 14, 15).
wasGeneratedBy('data_request_Alice','askDataAccess','request', 15).


wasControlledBy('createAccount','Bob','owner',1,2).
wasGeneratedBy('phoneNumber_Bob_1','createAccount','personal data', 2 ).

wasControlledBy('consent','Bob','owner',3, 4).
wasGeneratedBy('consent_Bob_1','consent','consent', 4).

purposes('consent_Bob_1','phoneNumber_Bob_1',['']).

wasControlledBy('askDataAccess','Bob','owner', 24, 25).
wasGeneratedBy('data_request_Bob','askDataAccess','request', 25).

wasControlledBy('sendData','DC','owner', 1064, 1066).
used('sendData','data_request_Bob', 'data request received',1065).
wasGeneratedBy('data_report_Bob','sendData','data response', 1066).



action('sendData', 'sendData').
action('sendThirdPartiesCookie', 'sendThirdPartiesCookie').
action('updateData', 'updateData').
action('sendAdSMS', 'sendAdSMS').
action('sendMail', 'sendMail').
action('sendImprovementCookie', 'sendImprovementCookie').
action('createAccount', 'createAccount').
action('consent', 'consent').
action('login', 'login').
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
purposes(_,_,['consent','delete','askErase','sendData','askDataAccess','updateConsent','accessWebPage','updateData','createAccount','login']).
