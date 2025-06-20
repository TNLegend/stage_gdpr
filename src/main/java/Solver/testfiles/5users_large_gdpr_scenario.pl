%% Graphe de Scenario GDPR Complexe et Large pour 5 Utilisateurs
%% Chaque utilisateur a un cycle de vie de données détaillé avec créations, consentements, usages, mises à jour et suppressions.

% User: Alice (user0)
wasControlledBy('createAccount','Alice','owner',1,7).
wasGeneratedBy('bankAccount_Alice_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('address_Alice_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('phoneNumber_Alice_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_Alice_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_Alice_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_Alice_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('consent','Alice','owner',8,9).
wasGeneratedBy('consent_Alice_1','consent','consent',9).
purposes('consent_Alice_1','phoneNumber_Alice_1',['sendAdSMS','marketing']).

wasControlledBy('updateConsent','Alice','owner',10,12).
used('updateConsent','consent_Alice_1','consent',11).
wasGeneratedBy('consent_Alice_2','updateConsent','consent',12).
purposes('consent_Alice_2','phoneNumber_Alice_1',['marketing','analytics']). % Changed purpose

wasControlledBy('sendAnalysisCookie','DC', 'owner', 13, 16).
wasGeneratedBy('analysis_cookie_Alice', 'sendAnalysisCookie', 'cookie to send', 14).
used('sendAnalysisCookie','id_Alice_1', 'user id', 15).
used('sendAnalysisCookie','analysis_cookie_Alice', 'cookie', 16).

wasControlledBy('buyItem','Alice','owner',17,20).
used('buyItem','bankAccount_Alice_1','bank account',18).
wasGeneratedBy('receipt_Alice_1','buyItem','receipt',19).
used('buyItem','id_Alice_1','user id',20).

wasControlledBy('askDataAccess','Alice','owner',21,22).
wasGeneratedBy('dataRequest_Alice_1','askDataAccess','request',22).
wasControlledBy('sendData','DC','owner',23,24).
used('sendData','dataRequest_Alice_1','request',23).
wasGeneratedBy('dataReport_Alice_1','sendData','response',24).

wasControlledBy('askErase','Alice','owner',25,26).
used('askErase','mail_Alice_1','data to erase',26).
wasControlledBy('delete','DC','owner',27,28).
used('delete','mail_Alice_1','data erased',28).

wasControlledBy('revokeConsent','Alice','owner',29,30).
used('revokeConsent','consent_Alice_2','consent to revoke',30).


% User: Bob (user1) - A similar, slightly varied flow
wasControlledBy('createAccount','Bob','owner',101,107).
wasGeneratedBy('bankAccount_Bob_1', 'createAccount', 'personal data', 102 ).
wasGeneratedBy('address_Bob_1', 'createAccount', 'personal data', 103 ).
wasGeneratedBy('phoneNumber_Bob_1', 'createAccount', 'personal data', 104 ).
wasGeneratedBy('mail_Bob_1', 'createAccount', 'personal data', 105 ).
wasGeneratedBy('name_Bob_1', 'createAccount', 'personal data', 106 ).
wasGeneratedBy('id_Bob_1', 'createAccount', 'personal data', 107 ).

wasControlledBy('consent','Bob','owner',108,109).
wasGeneratedBy('consent_Bob_1','consent','consent',109).
purposes('consent_Bob_1','id_Bob_1',['sendAnalysisCookie','sendImprovementCookie']).

wasControlledBy('sendImprovementCookie','DC','owner',110,113).
used('sendImprovementCookie','id_Bob_1','user id',111).
wasGeneratedBy('improvementCookie_Bob','sendImprovementCookie','cookie',112).
used('sendImprovementCookie','improvementCookie_Bob','cookie sent',113).

wasControlledBy('updateData','Bob','owner',114,116).
used('updateData','phoneNumber_Bob_1','old phone',115).
wasGeneratedBy('phoneNumber_Bob_2','updateData','new phone',116).

wasControlledBy('sendMail','DC','owner',117,119).
used('sendMail','mail_Bob_1','recipient mail',118).
wasGeneratedBy('promoMail_Bob','sendMail','mail content',119).

wasControlledBy('askRefund','Bob','owner',120,121).
used('askRefund','bankAccount_Bob_1','account for refund',121).
wasControlledBy('refund','DC','owner',122,123).
used('refund','bankAccount_Bob_1','refund processed to',123).

% User: Charlie (user2)
wasControlledBy('createAccount','Charlie','owner',201,207).
wasGeneratedBy('bankAccount_Charlie_1', 'createAccount', 'personal data', 202 ).
wasGeneratedBy('address_Charlie_1', 'createAccount', 'personal data', 203 ).
wasGeneratedBy('phoneNumber_Charlie_1', 'createAccount', 'personal data', 204 ).
wasGeneratedBy('mail_Charlie_1', 'createAccount', 'personal data', 205 ).
wasGeneratedBy('name_Charlie_1', 'createAccount', 'personal data', 206 ).
wasGeneratedBy('id_Charlie_1', 'createAccount', 'personal data', 207 ).

wasControlledBy('consent','Charlie','owner',208,209).
wasGeneratedBy('consent_Charlie_1','consent','consent',209).
purposes('consent_Charlie_1','address_Charlie_1',['delivery','marketing']).

wasControlledBy('sendThirdPartiesCookie','DC','owner',210,213).
used('sendThirdPartiesCookie','id_Charlie_1','user id',211).
wasGeneratedBy('thirdPartyCookie_Charlie','sendThirdPartiesCookie','cookie',212).
used('sendThirdPartiesCookie','thirdPartyCookie_Charlie','cookie sent',213).

wasControlledBy('buyItem','Charlie','owner',214,217).
used('buyItem','bankAccount_Charlie_1','bank account',215).
wasGeneratedBy('receipt_Charlie_1','buyItem','receipt',216).
used('buyItem','address_Charlie_1','delivery address',217).

wasControlledBy('updateConsent','Charlie','owner',218,220).
used('updateConsent','consent_Charlie_1','consent',219).
wasGeneratedBy('consent_Charlie_2','updateConsent','consent',220).
purposes('consent_Charlie_2','address_Charlie_1',['delivery']). % Consent reduced

% User: David (user3)
wasControlledBy('createAccount','David','owner',301,307).
wasGeneratedBy('bankAccount_David_1', 'createAccount', 'personal data', 302 ).
wasGeneratedBy('address_David_1', 'createAccount', 'personal data', 303 ).
wasGeneratedBy('phoneNumber_David_1', 'createAccount', 'personal data', 304 ).
wasGeneratedBy('mail_David_1', 'createAccount', 'personal data', 305 ).
wasGeneratedBy('name_David_1', 'createAccount', 'personal data', 306 ).
wasGeneratedBy('id_David_1', 'createAccount', 'personal data', 307 ).

wasControlledBy('consent','David','owner',308,309).
wasGeneratedBy('consent_David_1','consent','consent',309).
purposes('consent_David_1','mail_David_1',['newsletter','sendAdSMS']).

wasControlledBy('sendAdSMS','DC','owner',310,313).
wasGeneratedBy('ad_David', 'sendAdSMS', 'ad to send', 311).
used('sendAdSMS','phoneNumber_David_1', 'user phone number', 312).
used('sendAdSMS','ad_David', 'ad sms', 313).

wasControlledBy('sendTicket','David','owner',314,316).
used('sendTicket','mail_David_1','sender mail',315).
wasGeneratedBy('ticket_David_1','sendTicket','support ticket',316).

wasControlledBy('sendTicket','DC','owner',317,319).
wasGeneratedBy('ticketReply_David_1','sendTicket','ticket response',318).
used('sendTicket','mail_David_1','recipient mail',319).

wasControlledBy('askErase','David','owner',320,321).
used('askErase','phoneNumber_David_1','data to erase',321).

% User: Eve (user4)
wasControlledBy('createAccount','Eve','owner',401,407).
wasGeneratedBy('bankAccount_Eve_1', 'createAccount', 'personal data', 402 ).
wasGeneratedBy('address_Eve_1', 'createAccount', 'personal data', 403 ).
wasGeneratedBy('phoneNumber_Eve_1', 'createAccount', 'personal data', 404 ).
wasGeneratedBy('mail_Eve_1', 'createAccount', 'personal data', 405 ).
wasGeneratedBy('name_Eve_1', 'createAccount', 'personal data', 406 ).
wasGeneratedBy('id_Eve_1', 'createAccount', 'personal data', 407 ).

wasControlledBy('consent','Eve','owner',408,409).
wasGeneratedBy('consent_Eve_1','consent','consent',409).
purposes('consent_Eve_1','id_Eve_1',['sendPersonalizationCookie','sendThirdPartiesCookie']).

wasControlledBy('sendPersonalizationCookie','DC','owner',410,413).
used('sendPersonalizationCookie','id_Eve_1','user id',411).
wasGeneratedBy('personalizationCookie_Eve','sendPersonalizationCookie','cookie',412).
used('sendPersonalizationCookie','personalizationCookie_Eve','cookie sent',413).

wasControlledBy('updateData','Eve','owner',414,416).
used('updateData','address_Eve_1','old address',415).
wasGeneratedBy('address_Eve_2','updateData','new address',416).

wasControlledBy('askDataAccess','Eve','owner',417,418).
wasGeneratedBy('dataRequest_Eve_1','askDataAccess','request',418).

wasControlledBy('revokeConsent','Eve','owner',419,420).
used('revokeConsent','consent_Eve_1','consent to revoke',420).


% Global actions and purposes (if not defined within user flows)
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
purposes(_,_,['consent','delete','askErase','sendData','askDataAccess','updateConsent','accessWebPage','updateData','createAccount','login','buyItem','askRefund','refund','sendMail','sendTicket','sendAdSMS','sendAnalysisCookie','sendImprovementCookie','sendPersonalizationCookie','sendThirdPartiesCookie','marketing','analytics','delivery','newsletter']).