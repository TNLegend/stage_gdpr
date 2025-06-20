wasControlledBy('createAccount','user0','owner',1,7).
wasGeneratedBy('bankAccount_user0_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('address_user0_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('phoneNumber_user0_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user0_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user0_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user0_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 8, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 9).
used('sendAnalysisCookie','id_user0_1', 'user id', 10).
used('sendAnalysisCookie', 'mail_user0_1', 'extra data', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasControlledBy('consent','user0','owner', 13, 19).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 14, 18).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 15).
used('sendAnalysisCookie','id_user0_1', 'user id', 16).
used('sendAnalysisCookie', 'address_user0_1', 'extra data', 17).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 18).

wasGeneratedBy('consent_user0_1','consent', 'consent', 19).

purposes(_,'bankAccount_user0_1',['buyItem','askRefund','refund']).
purposes(_,'address_user0_1',['buyItem']).
purposes('consent_user0_1','phoneNumber_user0_1',['sendAdSMS','buyItem','refund']).
purposes(_,'mail_user0_1',['sendMail','sendTicket']).
purposes(_,'name_user0_1',['buyItem']).
purposes('consent_user0_1','id_user0_1',['sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('askDataAccess','user0','owner', 20, 21).


wasGeneratedBy('data_request_user0', 'askDataAccess', 'request', 21).

wasControlledBy('sendData','DC', 'owner', 53812, 53814).
used('sendData', 'data_request_user0', 'request received', 53813).
wasGeneratedBy('data_report_user0','sendData', 'data response', 53814).

wasControlledBy('sendData','user0', 'receiver', 53815, 53816).
used('sendData', 'data_report_user0', 'request response received', 53816).

wasControlledBy('updateConsent','user0', 'owner', 22, 24).
used('updateConsent', 'consent_user0_1', 'consent', 23).
wasGeneratedBy('consent_user0_2', 'updateConsent', 'consent', 24).


purposes('consent_user0_2','phoneNumber_user0_1',['buyItem','refund']).
purposes('consent_user0_2','id_user0_1',['sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).





wasControlledBy('updateData','user0', 'owner', 25, 27).
used('updateData','mail_user0_1', 'data to update', 26).
wasGeneratedBy('mail_user0_2', 'updateData', 'updated data', 27).


wasControlledBy('updateConsent','user0', 'owner', 28, 30).
used('updateConsent', 'consent_user0_2', 'consent', 29).
wasGeneratedBy('consent_user0_3', 'updateConsent', 'consent', 30).


purposes('consent_user0_3','phoneNumber_user0_1',['sendAdSMS','buyItem','refund']).
purposes('consent_user0_3','id_user0_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie']).


wasControlledBy('sendAdSMS','DC', 'owner', 31, 34).
wasGeneratedBy('ad', 'sendAdSMS', 'ad to send', 32).
used('sendAdSMS','phoneNumber_user0_1', 'user phone number', 33).
used('sendAdSMS','ad', 'ad sms', 34).



wasControlledBy('updateConsent','user0', 'owner', 35, 37).
used('updateConsent', 'consent_user0_3', 'consent', 36).
wasGeneratedBy('consent_user0_4', 'updateConsent', 'consent', 37).


purposes('consent_user0_4','phoneNumber_user0_1',['buyItem']).
purposes('consent_user0_4','id_user0_1',['sendThirdPartiesCookie','sendImprovementCookie']).



wasControlledBy('buyItem','user0', 'owner', 38, 45).
used('buyItem','bankAccount_user0_1', 'bank account', 39).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 40, 44).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 41).
used('sendPersonalizationCookie','id_user0_1', 'user id', 42).
used('sendPersonalizationCookie', 'name_user0_1', 'extra data', 43).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 44).

wasGeneratedBy('receipt', 'buyItem', 'receipt', 45).

wasControlledBy('sendTicket','user0', 'owner', 46, 49).

used('sendTicket','mail_user0_2', 'ticket sender mail', 47).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 48).
used('sendTicket', 'ticket', 'ticket sent', 49).



wasControlledBy('updateConsent','user0', 'owner', 50, 52).
used('updateConsent', 'consent_user0_4', 'consent', 51).
wasGeneratedBy('consent_user0_5', 'updateConsent', 'consent', 52).


purposes('consent_user0_5','phoneNumber_user0_1',['sendAdSMS','buyItem']).
purposes('consent_user0_5','id_user0_1',['sendThirdPartiesCookie','sendImprovementCookie']).





wasControlledBy('updateData','user0', 'owner', 53, 55).
used('updateData','mail_user0_2', 'data to update', 54).
wasGeneratedBy('mail_user0_3', 'updateData', 'updated data', 55).


wasControlledBy('updateConsent','user0', 'owner', 56, 58).
used('updateConsent', 'consent_user0_5', 'consent', 57).
wasGeneratedBy('consent_user0_6', 'updateConsent', 'consent', 58).


purposes('consent_user0_6','phoneNumber_user0_1',['buyItem']).
purposes('consent_user0_6','id_user0_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).



wasControlledBy('askRefund','user0', 'owner', 59, 60).

used('askRefund', 'receipt', 'bank account', 60).

wasControlledBy('refund','DC', 'owner', 85826, 85827).

used('refund', 'bankAccount_user0_1', 'bank account', 85827).



used('revokeConsent','consent_user0_6','revokeConsent', 61).

wasControlledBy('sendTicket','DC', 'owner', 30491, 30494).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 30492).
used('sendTicket','mail_user0_3', 'ticket reply sent', 30493).
used('sendTicket','ticketReply', 'ticket reply sent', 30494).

wasControlledBy('sendImprovementCookie','DC', 'owner', 22223, 22227).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 22224).
used('sendImprovementCookie','id_user0_1', 'user id', 22225).
used('sendImprovementCookie', 'name_user0_1', 'extra data', 22226).

used('sendImprovementCookie','improvement_cookie', 'cookie', 22227).

wasControlledBy('sendTicket','user0', 'owner', 22228, 22229).
used('sendTicket', 'ticketReply', 'ticket reply received', 22229).

action('sendData', 'sendData').
action('sendThirdPartiesCookie', 'sendThirdPartiesCookie').
action('updateData', 'updateData').
action('revokeConsent', 'revokeConsent').
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
