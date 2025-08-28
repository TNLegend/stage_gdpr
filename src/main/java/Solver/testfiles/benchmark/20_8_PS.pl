wasControlledBy('createAccount','user0','owner',1,7).
wasGeneratedBy('birthday_user0_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user0_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user0_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user0_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user0_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user0_1', 'createAccount', 'personal data', 7 ).



wasControlledBy('sendTicket','user0', 'owner', 8, 12).
used('sendTicket', 'mail_user0_1', 'extra data', 9).

used('sendTicket','mail_user0_1', 'ticket sender mail', 10).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 11).
used('sendTicket', 'ticket', 'ticket sent', 12).



wasControlledBy('sendTicket','DC', 'owner', 37791, 37794).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 37792).
used('sendTicket','mail_user0_1', 'ticket reply sent', 37793).
used('sendTicket','ticketReply', 'ticket reply sent', 37794).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 106835, 106838).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 106836).
used('sendAnalysisCookie','id_user0_1', 'user id', 106837).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 106838).

wasControlledBy('sendImprovementCookie','DC', 'owner', 110164, 110168).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 110165).
used('sendImprovementCookie','id_user0_1', 'user id', 110166).
used('sendImprovementCookie', 'id_user0_1', 'extra data', 110167).

used('sendImprovementCookie','improvement_cookie', 'cookie', 110168).

wasControlledBy('sendTicket','user0', 'owner', 110169, 110170).
used('sendTicket', 'ticketReply', 'ticket reply received', 110170).



wasControlledBy('updateData','user0', 'owner', 13, 15).
used('updateData','id_user0_1', 'data to update', 14).
wasGeneratedBy('id_user0_2', 'updateData', 'updated data', 15).

wasControlledBy('useSimulator','user0', 'owner', 16, 17).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 17).

wasControlledBy('useSimulator', 'DC', 'owner', 18, 28).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 19).
used('useSimulator', 'name_user0_1', 'simulator user', 20).
used('useSimulator', 'address_user0_1', 'simulator user physical address', 21).
used('useSimulator', 'bankAccount_user0_1', 'extra data', 22).

wasControlledBy('sendImprovementCookie','DC', 'owner', 23, 27).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 24).
used('sendImprovementCookie','id_user0_2', 'user id', 25).
used('sendImprovementCookie', 'bankAccount_user0_1', 'extra data', 26).

used('sendImprovementCookie','improvement_cookie', 'cookie', 27).


wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 28).
wasControlledBy('askDataAccess','user0','owner', 29, 35).
wasControlledBy('sendImprovementCookie','DC', 'owner', 30, 34).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 31).
used('sendImprovementCookie','id_user0_2', 'user id', 32).
used('sendImprovementCookie', 'bankAccount_user0_1', 'extra data', 33).

used('sendImprovementCookie','improvement_cookie', 'cookie', 34).


wasGeneratedBy('data_request_user0', 'askDataAccess', 'request', 35).

wasControlledBy('sendData','DC', 'owner', 57401, 57403).
used('sendData', 'data_request_user0', 'request received', 57402).
wasGeneratedBy('data_report_user0','sendData', 'data response', 57403).

wasControlledBy('sendData','user0', 'receiver', 57404, 57405).
used('sendData', 'data_report_user0', 'request response received', 57405).
wasControlledBy('payFine','DC', 'owner', 36, 38).
used('payFine', 'bankAccount_user0_1', 'bank account', 37).

wasGeneratedBy('receipt', 'payFine', 'receipt', 38).
wasControlledBy('sendMail','DC', 'owner', 39, 46).
wasGeneratedBy('message','sendMail', 'mail to send', 40).
used('sendMail','mail_user0_1', 'address to send to', 41).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 42, 45).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 43).
used('sendAnalysisCookie','id_user0_2', 'user id', 44).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 45).

used('sendMail', 'message', 'mail sent', 46).
wasControlledBy('createAccount','user1','owner',1,7).
wasGeneratedBy('birthday_user1_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user1_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user1_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user1_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user1_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user1_1', 'createAccount', 'personal data', 7 ).



wasControlledBy('sendMail','DC', 'owner', 8, 15).
wasGeneratedBy('message','sendMail', 'mail to send', 9).
used('sendMail','mail_user1_1', 'address to send to', 10).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 11, 14).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 12).
used('sendAnalysisCookie','id_user1_1', 'user id', 13).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 14).

used('sendMail', 'message', 'mail sent', 15).



wasControlledBy('updateData','user1', 'owner', 16, 18).
used('updateData','birthday_user1_1', 'data to update', 17).
wasGeneratedBy('birthday_user1_2', 'updateData', 'updated data', 18).

wasControlledBy('payFine','DC', 'owner', 19, 22).
used('payFine', 'bankAccount_user1_1', 'bank account', 20).
used('payFine', 'id_user1_1', 'extra data', 21).

wasGeneratedBy('receipt', 'payFine', 'receipt', 22).
wasControlledBy('consent','user1','owner', 23, 29).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 24, 28).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 25).
used('sendAnalysisCookie','id_user1_1', 'user id', 26).
used('sendAnalysisCookie', 'id_user1_1', 'extra data', 27).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 28).

wasGeneratedBy('consent_user1_1','consent', 'consent', 29).

purposes(_,'birthday_user1_2',['doAdminProcedure']).
purposes(_,'bankAccount_user1_1',['payFine']).
purposes(_,'address_user1_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user1_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user1_1',['useSimulator','doAdminProcedure']).
purposes('consent_user1_1','id_user1_1',['sendAnalysisCookie','sendImprovementCookie']).


wasControlledBy('updateConsent','user1', 'owner', 30, 32).
used('updateConsent', 'consent_user1_1', 'consent', 31).
wasGeneratedBy('consent_user1_2', 'updateConsent', 'consent', 32).


purposes('consent_user1_2','id_user1_1',['sendAnalysisCookie']).


wasControlledBy('doAdminProcedure','DC', 'owner', 33, 37).
used('doAdminProcedure','name_user1_1', 'user name', 34).
used('doAdminProcedure','birthday_user1_2', 'user birth day', 35).
used('doAdminProcedure','address_user1_1', 'user physical address', 36).

used('doAdminProcedure', 'mail_user1_1', 'user mail address', 37).

wasControlledBy('askDataAccess','user1','owner', 38, 39).


wasGeneratedBy('data_request_user1', 'askDataAccess', 'request', 39).
wasControlledBy('sendTicket','user1', 'owner', 40, 43).

used('sendTicket','mail_user1_1', 'ticket sender mail', 41).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 42).
used('sendTicket', 'ticket', 'ticket sent', 43).



wasControlledBy('sendTicket','DC', 'owner', 53785, 53788).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 53786).
used('sendTicket','mail_user1_1', 'ticket reply sent', 53787).
used('sendTicket','ticketReply', 'ticket reply sent', 53788).


wasControlledBy('sendTicket','user1', 'owner', 53789, 53790).
used('sendTicket', 'ticketReply', 'ticket reply received', 53790).
wasControlledBy('createAccount','user2','owner',1,7).
wasGeneratedBy('birthday_user2_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user2_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user2_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user2_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user2_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user2_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 8, 11).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 9).
used('sendAnalysisCookie','id_user2_1', 'user id', 10).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 11).


wasControlledBy('askDataAccess','user2','owner', 12, 22).
wasControlledBy('sendImprovementCookie','DC', 'owner', 13, 17).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 14).
used('sendImprovementCookie','id_user2_1', 'user id', 15).
used('sendImprovementCookie', 'mail_user2_1', 'extra data', 16).

used('sendImprovementCookie','improvement_cookie', 'cookie', 17).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 18, 21).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 19).
used('sendAnalysisCookie','id_user2_1', 'user id', 20).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 21).

wasGeneratedBy('data_request_user2', 'askDataAccess', 'request', 22).
wasControlledBy('consent','user2','owner', 23, 29).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 24, 28).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 25).
used('sendAnalysisCookie','id_user2_1', 'user id', 26).
used('sendAnalysisCookie', 'birthday_user2_1', 'extra data', 27).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 28).

wasGeneratedBy('consent_user2_1','consent', 'consent', 29).

purposes(_,'birthday_user2_1',['doAdminProcedure']).
purposes(_,'bankAccount_user2_1',['payFine']).
purposes(_,'address_user2_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user2_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user2_1',['useSimulator','doAdminProcedure']).
purposes('consent_user2_1','id_user2_1',['sendAnalysisCookie']).


wasControlledBy('updateConsent','user2', 'owner', 30, 32).
used('updateConsent', 'consent_user2_1', 'consent', 31).
wasGeneratedBy('consent_user2_2', 'updateConsent', 'consent', 32).


purposes('consent_user2_2','id_user2_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie']).





wasControlledBy('updateData','user2', 'owner', 33, 35).
used('updateData','birthday_user2_1', 'data to update', 34).
wasGeneratedBy('birthday_user2_2', 'updateData', 'updated data', 35).

wasControlledBy('payFine','DC', 'owner', 36, 39).
used('payFine', 'bankAccount_user2_1', 'bank account', 37).
used('payFine', 'address_user2_1', 'extra data', 38).

wasGeneratedBy('receipt', 'payFine', 'receipt', 39).

wasControlledBy('sendTicket','user2', 'owner', 40, 44).
used('sendTicket', 'birthday_user2_2', 'extra data', 41).

used('sendTicket','mail_user2_1', 'ticket sender mail', 42).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 43).
used('sendTicket', 'ticket', 'ticket sent', 44).


wasControlledBy('sendMail','DC', 'owner', 45, 53).
wasGeneratedBy('message','sendMail', 'mail to send', 46).
used('sendMail','mail_user2_1', 'address to send to', 47).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 48, 52).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 49).
used('sendAnalysisCookie','id_user2_1', 'user id', 50).
used('sendAnalysisCookie', 'bankAccount_user2_1', 'extra data', 51).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 52).

used('sendMail', 'message', 'mail sent', 53).



wasControlledBy('updateData','user2', 'owner', 54, 56).
used('updateData','name_user2_1', 'data to update', 55).
wasGeneratedBy('name_user2_2', 'updateData', 'updated data', 56).


wasControlledBy('updateConsent','user2', 'owner', 57, 59).
used('updateConsent', 'consent_user2_2', 'consent', 58).
wasGeneratedBy('consent_user2_3', 'updateConsent', 'consent', 59).


purposes('consent_user2_3','id_user2_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie']).


wasControlledBy('doAdminProcedure','DC', 'owner', 60, 64).
used('doAdminProcedure','name_user2_2', 'user name', 61).
used('doAdminProcedure','birthday_user2_2', 'user birth day', 62).
used('doAdminProcedure','address_user2_1', 'user physical address', 63).

used('doAdminProcedure', 'mail_user2_1', 'user mail address', 64).

wasControlledBy('createAccount','user3','owner',1,7).
wasGeneratedBy('birthday_user3_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user3_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user3_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user3_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user3_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user3_1', 'createAccount', 'personal data', 7 ).


wasControlledBy('consent','user3','owner', 8, 9).

wasGeneratedBy('consent_user3_1','consent', 'consent', 9).

purposes(_,'birthday_user3_1',['doAdminProcedure']).
purposes(_,'bankAccount_user3_1',['payFine']).
purposes(_,'address_user3_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user3_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user3_1',['useSimulator','doAdminProcedure']).
purposes('consent_user3_1','id_user3_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie']).



wasControlledBy('updateConsent','user3', 'owner', 10, 12).
used('updateConsent', 'consent_user3_1', 'consent', 11).
wasGeneratedBy('consent_user3_2', 'updateConsent', 'consent', 12).


purposes('consent_user3_2','id_user3_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie']).


wasControlledBy('useSimulator','user3', 'owner', 13, 14).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 14).

wasControlledBy('useSimulator', 'DC', 'owner', 15, 30).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 16).
used('useSimulator', 'name_user3_1', 'simulator user', 17).
used('useSimulator', 'address_user3_1', 'simulator user physical address', 18).
used('useSimulator', 'birthday_user3_1', 'extra data', 19).

wasControlledBy('sendImprovementCookie','DC', 'owner', 20, 24).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 21).
used('sendImprovementCookie','id_user3_1', 'user id', 22).
used('sendImprovementCookie', 'address_user3_1', 'extra data', 23).

used('sendImprovementCookie','improvement_cookie', 'cookie', 24).

wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 25, 29).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 26).
used('sendThirdPartiesCookie','id_user3_1', 'user id', 27).
used('sendThirdPartiesCookie', 'mail_user3_1', 'extra data', 28).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 29).

wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 30).


wasControlledBy('updateConsent','user3', 'owner', 31, 33).
used('updateConsent', 'consent_user3_2', 'consent', 32).
wasGeneratedBy('consent_user3_3', 'updateConsent', 'consent', 33).


purposes('consent_user3_3','id_user3_1',['sendThirdPartiesCookie','sendImprovementCookie']).


wasControlledBy('payFine','DC', 'owner', 34, 36).
used('payFine', 'bankAccount_user3_1', 'bank account', 35).

wasGeneratedBy('receipt', 'payFine', 'receipt', 36).

wasControlledBy('sendMail','DC', 'owner', 37, 44).
wasGeneratedBy('message','sendMail', 'mail to send', 38).
used('sendMail','mail_user3_1', 'address to send to', 39).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 40, 43).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 41).
used('sendAnalysisCookie','id_user3_1', 'user id', 42).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 43).

used('sendMail', 'message', 'mail sent', 44).
wasControlledBy('askDataAccess','user3','owner', 45, 50).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 46, 49).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 47).
used('sendAnalysisCookie','id_user3_1', 'user id', 48).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 49).

wasGeneratedBy('data_request_user3', 'askDataAccess', 'request', 50).

wasControlledBy('sendData','DC', 'owner', 54354, 54356).
used('sendData', 'data_request_user3', 'request received', 54355).
wasGeneratedBy('data_report_user3','sendData', 'data response', 54356).

wasControlledBy('sendData','user3', 'receiver', 54357, 54358).
used('sendData', 'data_report_user3', 'request response received', 54358).



wasControlledBy('updateData','user3', 'owner', 51, 53).
used('updateData','id_user3_1', 'data to update', 52).
wasGeneratedBy('id_user3_2', 'updateData', 'updated data', 53).


wasControlledBy('updateConsent','user3', 'owner', 54, 56).
used('updateConsent', 'consent_user3_3', 'consent', 55).
wasGeneratedBy('consent_user3_4', 'updateConsent', 'consent', 56).


purposes('consent_user3_4','id_user3_2',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('useSimulator','user3', 'owner', 57, 58).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 58).

wasControlledBy('useSimulator', 'DC', 'owner', 59, 68).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 60).
used('useSimulator', 'name_user3_1', 'simulator user', 61).
used('useSimulator', 'address_user3_1', 'simulator user physical address', 62).

wasControlledBy('sendImprovementCookie','DC', 'owner', 63, 67).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 64).
used('sendImprovementCookie','id_user3_2', 'user id', 65).
used('sendImprovementCookie', 'mail_user3_1', 'extra data', 66).

used('sendImprovementCookie','improvement_cookie', 'cookie', 67).


wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 68).

wasControlledBy('createAccount','user4','owner',1,7).
wasGeneratedBy('birthday_user4_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user4_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user4_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user4_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user4_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user4_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 8, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 9).
used('sendAnalysisCookie','id_user4_1', 'user id', 10).
used('sendAnalysisCookie', 'id_user4_1', 'extra data', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasControlledBy('consent','user4','owner', 13, 19).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 14, 18).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 15).
used('sendAnalysisCookie','id_user4_1', 'user id', 16).
used('sendAnalysisCookie', 'bankAccount_user4_1', 'extra data', 17).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 18).

wasGeneratedBy('consent_user4_1','consent', 'consent', 19).

purposes(_,'birthday_user4_1',['doAdminProcedure']).
purposes(_,'bankAccount_user4_1',['payFine']).
purposes(_,'address_user4_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user4_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user4_1',['useSimulator','doAdminProcedure']).
purposes('consent_user4_1','id_user4_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).





wasControlledBy('updateData','user4', 'owner', 20, 22).
used('updateData','id_user4_1', 'data to update', 21).
wasGeneratedBy('id_user4_2', 'updateData', 'updated data', 22).


wasControlledBy('updateConsent','user4', 'owner', 23, 25).
used('updateConsent', 'consent_user4_1', 'consent', 24).
wasGeneratedBy('consent_user4_2', 'updateConsent', 'consent', 25).


purposes('consent_user4_2','id_user4_2',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).





wasControlledBy('updateData','user4', 'owner', 26, 28).
used('updateData','id_user4_2', 'data to update', 27).
wasGeneratedBy('id_user4_3', 'updateData', 'updated data', 28).

wasControlledBy('doAdminProcedure','DC', 'owner', 29, 33).
used('doAdminProcedure','name_user4_1', 'user name', 30).
used('doAdminProcedure','birthday_user4_1', 'user birth day', 31).
used('doAdminProcedure','address_user4_1', 'user physical address', 32).

used('doAdminProcedure', 'mail_user4_1', 'user mail address', 33).

wasControlledBy('payFine','DC', 'owner', 34, 37).
used('payFine', 'bankAccount_user4_1', 'bank account', 35).
used('payFine', 'mail_user4_1', 'extra data', 36).

wasGeneratedBy('receipt', 'payFine', 'receipt', 37).

used('revokeConsent','consent_user4_2','revokeConsent', 38).
wasControlledBy('askDataAccess','user4','owner', 39, 40).


wasGeneratedBy('data_request_user4', 'askDataAccess', 'request', 40).

wasControlledBy('sendData','DC', 'owner', 54760, 54762).
used('sendData', 'data_request_user4', 'request received', 54761).
wasGeneratedBy('data_report_user4','sendData', 'data response', 54762).

wasControlledBy('sendData','user4', 'receiver', 54763, 54764).
used('sendData', 'data_report_user4', 'request response received', 54764).
wasControlledBy('createAccount','user5','owner',1,7).
wasGeneratedBy('birthday_user5_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user5_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user5_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user5_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user5_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user5_1', 'createAccount', 'personal data', 7 ).



wasControlledBy('sendMail','DC', 'owner', 8, 15).
wasGeneratedBy('message','sendMail', 'mail to send', 9).
used('sendMail','mail_user5_1', 'address to send to', 10).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 11, 14).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 12).
used('sendAnalysisCookie','id_user5_1', 'user id', 13).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 14).

used('sendMail', 'message', 'mail sent', 15).
wasControlledBy('consent','user5','owner', 16, 17).

wasGeneratedBy('consent_user5_1','consent', 'consent', 17).

purposes(_,'birthday_user5_1',['doAdminProcedure']).
purposes(_,'bankAccount_user5_1',['payFine']).
purposes(_,'address_user5_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user5_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user5_1',['useSimulator','doAdminProcedure']).
purposes('consent_user5_1','id_user5_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).

wasControlledBy('sendTicket','user5', 'owner', 18, 21).

used('sendTicket','mail_user5_1', 'ticket sender mail', 19).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 20).
used('sendTicket', 'ticket', 'ticket sent', 21).



wasControlledBy('updateConsent','user5', 'owner', 22, 24).
used('updateConsent', 'consent_user5_1', 'consent', 23).
wasGeneratedBy('consent_user5_2', 'updateConsent', 'consent', 24).


purposes('consent_user5_2','id_user5_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('payFine','DC', 'owner', 25, 27).
used('payFine', 'bankAccount_user5_1', 'bank account', 26).

wasGeneratedBy('receipt', 'payFine', 'receipt', 27).




wasControlledBy('updateData','user5', 'owner', 28, 30).
used('updateData','birthday_user5_1', 'data to update', 29).
wasGeneratedBy('birthday_user5_2', 'updateData', 'updated data', 30).

wasControlledBy('doAdminProcedure','DC', 'owner', 31, 35).
used('doAdminProcedure','name_user5_1', 'user name', 32).
used('doAdminProcedure','birthday_user5_2', 'user birth day', 33).
used('doAdminProcedure','address_user5_1', 'user physical address', 34).

used('doAdminProcedure', 'mail_user5_1', 'user mail address', 35).
wasControlledBy('doAdminProcedure','DC', 'owner', 36, 40).
used('doAdminProcedure','name_user5_1', 'user name', 37).
used('doAdminProcedure','birthday_user5_2', 'user birth day', 38).
used('doAdminProcedure','address_user5_1', 'user physical address', 39).

used('doAdminProcedure', 'mail_user5_1', 'user mail address', 40).

wasControlledBy('sendTicket','DC', 'owner', 76720, 76723).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 76721).
used('sendTicket','mail_user5_1', 'ticket reply sent', 76722).
used('sendTicket','ticketReply', 'ticket reply sent', 76723).

wasControlledBy('sendImprovementCookie','DC', 'owner', 105354, 105358).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 105355).
used('sendImprovementCookie','id_user5_1', 'user id', 105356).
used('sendImprovementCookie', 'bankAccount_user5_1', 'extra data', 105357).

used('sendImprovementCookie','improvement_cookie', 'cookie', 105358).

wasControlledBy('sendTicket','user5', 'owner', 105359, 105360).
used('sendTicket', 'ticketReply', 'ticket reply received', 105360).
wasControlledBy('createAccount','user6','owner',1,7).
wasGeneratedBy('birthday_user6_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user6_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user6_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user6_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user6_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user6_1', 'createAccount', 'personal data', 7 ).


wasControlledBy('consent','user6','owner', 8, 14).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 13).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user6_1', 'user id', 11).
used('sendAnalysisCookie', 'address_user6_1', 'extra data', 12).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 13).

wasGeneratedBy('consent_user6_1','consent', 'consent', 14).

purposes(_,'birthday_user6_1',['doAdminProcedure']).
purposes(_,'bankAccount_user6_1',['payFine']).
purposes(_,'address_user6_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user6_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user6_1',['useSimulator','doAdminProcedure']).
purposes('consent_user6_1','id_user6_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('sendTicket','user6', 'owner', 15, 19).
used('sendTicket', 'name_user6_1', 'extra data', 16).

used('sendTicket','mail_user6_1', 'ticket sender mail', 17).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 18).
used('sendTicket', 'ticket', 'ticket sent', 19).



used('revokeConsent','consent_user6_1','revokeConsent', 20).
wasControlledBy('sendMail','DC', 'owner', 21, 24).
wasGeneratedBy('message','sendMail', 'mail to send', 22).
used('sendMail','mail_user6_1', 'address to send to', 23).

used('sendMail', 'message', 'mail sent', 24).

wasControlledBy('sendTicket','DC', 'owner', 79517, 79520).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 79518).
used('sendTicket','mail_user6_1', 'ticket reply sent', 79519).
used('sendTicket','ticketReply', 'ticket reply sent', 79520).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 21720, 21724).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 21721).
used('sendAnalysisCookie','id_user6_1', 'user id', 21722).
used('sendAnalysisCookie', 'name_user6_1', 'extra data', 21723).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 21724).


wasControlledBy('sendTicket','user6', 'owner', 21725, 21726).
used('sendTicket', 'ticketReply', 'ticket reply received', 21726).
wasControlledBy('askDataAccess','user6','owner', 25, 35).
wasControlledBy('sendImprovementCookie','DC', 'owner', 26, 30).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 27).
used('sendImprovementCookie','id_user6_1', 'user id', 28).
used('sendImprovementCookie', 'name_user6_1', 'extra data', 29).

used('sendImprovementCookie','improvement_cookie', 'cookie', 30).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 31, 34).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 32).
used('sendAnalysisCookie','id_user6_1', 'user id', 33).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 34).

wasGeneratedBy('data_request_user6', 'askDataAccess', 'request', 35).
wasControlledBy('createAccount','user7','owner',1,7).
wasGeneratedBy('birthday_user7_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user7_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user7_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user7_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user7_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user7_1', 'createAccount', 'personal data', 7 ).



wasControlledBy('consent','user7','owner', 8, 9).

wasGeneratedBy('consent_user7_1','consent', 'consent', 9).

purposes(_,'birthday_user7_1',['doAdminProcedure']).
purposes(_,'bankAccount_user7_1',['payFine']).
purposes(_,'address_user7_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user7_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user7_1',['useSimulator','doAdminProcedure']).
purposes('consent_user7_1','id_user7_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


used('revokeConsent','consent_user7_1','revokeConsent', 10).
wasControlledBy('payFine','DC', 'owner', 11, 13).
used('payFine', 'bankAccount_user7_1', 'bank account', 12).

wasGeneratedBy('receipt', 'payFine', 'receipt', 13).
wasControlledBy('askDataAccess','user7','owner', 14, 15).


wasGeneratedBy('data_request_user7', 'askDataAccess', 'request', 15).



wasControlledBy('updateData','user7', 'owner', 16, 18).
used('updateData','name_user7_1', 'data to update', 17).
wasGeneratedBy('name_user7_2', 'updateData', 'updated data', 18).


wasControlledBy('updateConsent','user7', 'owner', 19, 21).
used('updateConsent', 'consent_user7_1', 'consent', 20).
wasGeneratedBy('consent_user7_2', 'updateConsent', 'consent', 21).


purposes('consent_user7_2','id_user7_1',['sendAnalysisCookie']).





wasControlledBy('updateData','user7', 'owner', 22, 24).
used('updateData','bankAccount_user7_1', 'data to update', 23).
wasGeneratedBy('bankAccount_user7_2', 'updateData', 'updated data', 24).


wasControlledBy('updateConsent','user7', 'owner', 25, 27).
used('updateConsent', 'consent_user7_2', 'consent', 26).
wasGeneratedBy('consent_user7_3', 'updateConsent', 'consent', 27).


purposes('consent_user7_3','id_user7_1',['sendThirdPartiesCookie','sendPersonalizationCookie']).


wasControlledBy('doAdminProcedure','DC', 'owner', 28, 37).
used('doAdminProcedure','name_user7_2', 'user name', 29).
used('doAdminProcedure','birthday_user7_1', 'user birth day', 30).
used('doAdminProcedure','address_user7_1', 'user physical address', 31).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 32, 36).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 33).
used('sendAnalysisCookie','id_user7_1', 'user id', 34).
used('sendAnalysisCookie', 'birthday_user7_1', 'extra data', 35).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 36).

used('doAdminProcedure', 'mail_user7_1', 'user mail address', 37).


wasControlledBy('useSimulator','user7', 'owner', 38, 39).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 39).

wasControlledBy('useSimulator', 'DC', 'owner', 40, 54).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 41).
used('useSimulator', 'name_user7_2', 'simulator user', 42).
used('useSimulator', 'address_user7_1', 'simulator user physical address', 43).
used('useSimulator', 'address_user7_1', 'extra data', 44).

wasControlledBy('sendImprovementCookie','DC', 'owner', 45, 48).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 46).
used('sendImprovementCookie','id_user7_1', 'user id', 47).

used('sendImprovementCookie','improvement_cookie', 'cookie', 48).

wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 49, 53).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 50).
used('sendThirdPartiesCookie','id_user7_1', 'user id', 51).
used('sendThirdPartiesCookie', 'mail_user7_1', 'extra data', 52).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 53).

wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 54).
wasControlledBy('doAdminProcedure','DC', 'owner', 55, 59).
used('doAdminProcedure','name_user7_2', 'user name', 56).
used('doAdminProcedure','birthday_user7_1', 'user birth day', 57).
used('doAdminProcedure','address_user7_1', 'user physical address', 58).

used('doAdminProcedure', 'mail_user7_1', 'user mail address', 59).
wasControlledBy('sendTicket','user7', 'owner', 60, 64).
used('sendTicket', 'address_user7_1', 'extra data', 61).

used('sendTicket','mail_user7_1', 'ticket sender mail', 62).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 63).
used('sendTicket', 'ticket', 'ticket sent', 64).


wasControlledBy('createAccount','user8','owner',1,7).
wasGeneratedBy('birthday_user8_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user8_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user8_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user8_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user8_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user8_1', 'createAccount', 'personal data', 7 ).


wasControlledBy('consent','user8','owner', 8, 9).

wasGeneratedBy('consent_user8_1','consent', 'consent', 9).

purposes(_,'birthday_user8_1',['doAdminProcedure']).
purposes(_,'bankAccount_user8_1',['payFine']).
purposes(_,'address_user8_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user8_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user8_1',['useSimulator','doAdminProcedure']).
purposes('consent_user8_1','id_user8_1',['sendThirdPartiesCookie','sendPersonalizationCookie']).





wasControlledBy('updateData','user8', 'owner', 10, 12).
used('updateData','bankAccount_user8_1', 'data to update', 11).
wasGeneratedBy('bankAccount_user8_2', 'updateData', 'updated data', 12).

wasControlledBy('useSimulator','user8', 'owner', 13, 14).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 14).

wasControlledBy('useSimulator', 'DC', 'owner', 15, 20).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 16).
used('useSimulator', 'name_user8_1', 'simulator user', 17).
used('useSimulator', 'address_user8_1', 'simulator user physical address', 18).
used('useSimulator', 'address_user8_1', 'extra data', 19).



wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 20).
wasControlledBy('sendMail','DC', 'owner', 21, 24).
wasGeneratedBy('message','sendMail', 'mail to send', 22).
used('sendMail','mail_user8_1', 'address to send to', 23).

used('sendMail', 'message', 'mail sent', 24).
wasControlledBy('doAdminProcedure','DC', 'owner', 25, 29).
used('doAdminProcedure','name_user8_1', 'user name', 26).
used('doAdminProcedure','birthday_user8_1', 'user birth day', 27).
used('doAdminProcedure','address_user8_1', 'user physical address', 28).

used('doAdminProcedure', 'mail_user8_1', 'user mail address', 29).

used('revokeConsent','consent_user8_1','revokeConsent', 30).
wasControlledBy('askDataAccess','user8','owner', 31, 37).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 32, 36).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 33).
used('sendAnalysisCookie','id_user8_1', 'user id', 34).
used('sendAnalysisCookie', 'id_user8_1', 'extra data', 35).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 36).

wasGeneratedBy('data_request_user8', 'askDataAccess', 'request', 37).

wasControlledBy('sendData','DC', 'owner', 67930, 67932).
used('sendData', 'data_request_user8', 'request received', 67931).
wasGeneratedBy('data_report_user8','sendData', 'data response', 67932).

wasControlledBy('sendData','user8', 'receiver', 67933, 67934).
used('sendData', 'data_report_user8', 'request response received', 67934).
wasControlledBy('createAccount','user9','owner',1,7).
wasGeneratedBy('birthday_user9_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user9_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user9_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user9_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user9_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user9_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 8, 11).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 9).
used('sendAnalysisCookie','id_user9_1', 'user id', 10).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 11).


wasControlledBy('sendTicket','user9', 'owner', 12, 15).

used('sendTicket','mail_user9_1', 'ticket sender mail', 13).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 14).
used('sendTicket', 'ticket', 'ticket sent', 15).



wasControlledBy('sendTicket','DC', 'owner', 33471, 33474).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 33472).
used('sendTicket','mail_user9_1', 'ticket reply sent', 33473).
used('sendTicket','ticketReply', 'ticket reply sent', 33474).

wasControlledBy('sendImprovementCookie','DC', 'owner', 54348, 54352).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 54349).
used('sendImprovementCookie','id_user9_1', 'user id', 54350).
used('sendImprovementCookie', 'id_user9_1', 'extra data', 54351).

used('sendImprovementCookie','improvement_cookie', 'cookie', 54352).

wasControlledBy('sendTicket','user9', 'owner', 54353, 54354).
used('sendTicket', 'ticketReply', 'ticket reply received', 54354).



wasControlledBy('updateData','user9', 'owner', 16, 18).
used('updateData','id_user9_1', 'data to update', 17).
wasGeneratedBy('id_user9_2', 'updateData', 'updated data', 18).

wasControlledBy('consent','user9','owner', 19, 25).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 20, 24).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 21).
used('sendAnalysisCookie','id_user9_2', 'user id', 22).
used('sendAnalysisCookie', 'id_user9_2', 'extra data', 23).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 24).

wasGeneratedBy('consent_user9_1','consent', 'consent', 25).

purposes(_,'birthday_user9_1',['doAdminProcedure']).
purposes(_,'bankAccount_user9_1',['payFine']).
purposes(_,'address_user9_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user9_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user9_1',['useSimulator','doAdminProcedure']).
purposes('consent_user9_1','id_user9_2',['sendThirdPartiesCookie','sendPersonalizationCookie']).


wasControlledBy('updateConsent','user9', 'owner', 26, 28).
used('updateConsent', 'consent_user9_1', 'consent', 27).
wasGeneratedBy('consent_user9_2', 'updateConsent', 'consent', 28).


purposes('consent_user9_2','id_user9_2',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).





wasControlledBy('updateData','user9', 'owner', 29, 31).
used('updateData','birthday_user9_1', 'data to update', 30).
wasGeneratedBy('birthday_user9_2', 'updateData', 'updated data', 31).

wasControlledBy('doAdminProcedure','DC', 'owner', 32, 40).
used('doAdminProcedure','name_user9_1', 'user name', 33).
used('doAdminProcedure','birthday_user9_2', 'user birth day', 34).
used('doAdminProcedure','address_user9_1', 'user physical address', 35).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 36, 39).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 37).
used('sendAnalysisCookie','id_user9_2', 'user id', 38).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 39).

used('doAdminProcedure', 'mail_user9_1', 'user mail address', 40).




wasControlledBy('updateData','user9', 'owner', 41, 43).
used('updateData','id_user9_2', 'data to update', 42).
wasGeneratedBy('id_user9_3', 'updateData', 'updated data', 43).


wasControlledBy('updateConsent','user9', 'owner', 44, 46).
used('updateConsent', 'consent_user9_2', 'consent', 45).
wasGeneratedBy('consent_user9_3', 'updateConsent', 'consent', 46).


purposes('consent_user9_3','id_user9_3',['sendAnalysisCookie','sendImprovementCookie','sendPersonalizationCookie']).





wasControlledBy('updateData','user9', 'owner', 47, 49).
used('updateData','bankAccount_user9_1', 'data to update', 48).
wasGeneratedBy('bankAccount_user9_2', 'updateData', 'updated data', 49).

wasControlledBy('useSimulator','user9', 'owner', 50, 51).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 51).

wasControlledBy('useSimulator', 'DC', 'owner', 52, 56).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 53).
used('useSimulator', 'name_user9_1', 'simulator user', 54).
used('useSimulator', 'address_user9_1', 'simulator user physical address', 55).



wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 56).

wasControlledBy('askDataAccess','user9','owner', 57, 58).


wasGeneratedBy('data_request_user9', 'askDataAccess', 'request', 58).

wasControlledBy('sendData','DC', 'owner', 42395, 42397).
used('sendData', 'data_request_user9', 'request received', 42396).
wasGeneratedBy('data_report_user9','sendData', 'data response', 42397).

wasControlledBy('sendData','user9', 'receiver', 42398, 42399).
used('sendData', 'data_report_user9', 'request response received', 42399).
wasControlledBy('useSimulator','user9', 'owner', 59, 60).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 60).

wasControlledBy('useSimulator', 'DC', 'owner', 61, 65).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 62).
used('useSimulator', 'name_user9_1', 'simulator user', 63).
used('useSimulator', 'address_user9_1', 'simulator user physical address', 64).



wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 65).
wasControlledBy('doAdminProcedure','DC', 'owner', 66, 70).
used('doAdminProcedure','name_user9_1', 'user name', 67).
used('doAdminProcedure','birthday_user9_2', 'user birth day', 68).
used('doAdminProcedure','address_user9_1', 'user physical address', 69).

used('doAdminProcedure', 'mail_user9_1', 'user mail address', 70).
wasControlledBy('sendMail','DC', 'owner', 71, 79).
wasGeneratedBy('message','sendMail', 'mail to send', 72).
used('sendMail','mail_user9_1', 'address to send to', 73).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 74, 78).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 75).
used('sendAnalysisCookie','id_user9_3', 'user id', 76).
used('sendAnalysisCookie', 'id_user9_3', 'extra data', 77).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 78).

used('sendMail', 'message', 'mail sent', 79).
wasControlledBy('createAccount','user10','owner',1,7).
wasGeneratedBy('birthday_user10_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user10_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user10_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user10_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user10_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user10_1', 'createAccount', 'personal data', 7 ).


wasControlledBy('consent','user10','owner', 8, 14).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 13).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user10_1', 'user id', 11).
used('sendAnalysisCookie', 'name_user10_1', 'extra data', 12).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 13).

wasGeneratedBy('consent_user10_1','consent', 'consent', 14).

purposes(_,'birthday_user10_1',['doAdminProcedure']).
purposes(_,'bankAccount_user10_1',['payFine']).
purposes(_,'address_user10_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user10_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user10_1',['useSimulator','doAdminProcedure']).
purposes('consent_user10_1','id_user10_1',['sendAnalysisCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('sendTicket','user10', 'owner', 15, 18).

used('sendTicket','mail_user10_1', 'ticket sender mail', 16).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 17).
used('sendTicket', 'ticket', 'ticket sent', 18).



wasControlledBy('sendTicket','DC', 'owner', 126329, 126332).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 126330).
used('sendTicket','mail_user10_1', 'ticket reply sent', 126331).
used('sendTicket','ticketReply', 'ticket reply sent', 126332).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 97646, 97649).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 97647).
used('sendAnalysisCookie','id_user10_1', 'user id', 97648).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 97649).


wasControlledBy('sendTicket','user10', 'owner', 97650, 97651).
used('sendTicket', 'ticketReply', 'ticket reply received', 97651).



wasControlledBy('updateData','user10', 'owner', 19, 21).
used('updateData','birthday_user10_1', 'data to update', 20).
wasGeneratedBy('birthday_user10_2', 'updateData', 'updated data', 21).


wasControlledBy('updateConsent','user10', 'owner', 22, 24).
used('updateConsent', 'consent_user10_1', 'consent', 23).
wasGeneratedBy('consent_user10_2', 'updateConsent', 'consent', 24).


purposes('consent_user10_2','id_user10_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('doAdminProcedure','DC', 'owner', 25, 29).
used('doAdminProcedure','name_user10_1', 'user name', 26).
used('doAdminProcedure','birthday_user10_2', 'user birth day', 27).
used('doAdminProcedure','address_user10_1', 'user physical address', 28).

used('doAdminProcedure', 'mail_user10_1', 'user mail address', 29).

wasControlledBy('askDataAccess','user10','owner', 30, 36).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 31, 35).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 32).
used('sendAnalysisCookie','id_user10_1', 'user id', 33).
used('sendAnalysisCookie', 'address_user10_1', 'extra data', 34).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 35).

wasGeneratedBy('data_request_user10', 'askDataAccess', 'request', 36).

wasControlledBy('sendData','DC', 'owner', 43351, 43353).
used('sendData', 'data_request_user10', 'request received', 43352).
wasGeneratedBy('data_report_user10','sendData', 'data response', 43353).

wasControlledBy('sendData','user10', 'receiver', 43354, 43355).
used('sendData', 'data_report_user10', 'request response received', 43355).
wasControlledBy('sendMail','DC', 'owner', 37, 44).
wasGeneratedBy('message','sendMail', 'mail to send', 38).
used('sendMail','mail_user10_1', 'address to send to', 39).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 40, 43).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 41).
used('sendAnalysisCookie','id_user10_1', 'user id', 42).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 43).

used('sendMail', 'message', 'mail sent', 44).
wasControlledBy('createAccount','user11','owner',1,7).
wasGeneratedBy('birthday_user11_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user11_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user11_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user11_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user11_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user11_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 8, 11).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 9).
used('sendAnalysisCookie','id_user11_1', 'user id', 10).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 11).


wasControlledBy('askDataAccess','user11','owner', 12, 13).


wasGeneratedBy('data_request_user11', 'askDataAccess', 'request', 13).

wasControlledBy('sendData','DC', 'owner', 28740, 28742).
used('sendData', 'data_request_user11', 'request received', 28741).
wasGeneratedBy('data_report_user11','sendData', 'data response', 28742).

wasControlledBy('sendData','user11', 'receiver', 28743, 28744).
used('sendData', 'data_report_user11', 'request response received', 28744).
wasControlledBy('payFine','DC', 'owner', 14, 17).
used('payFine', 'bankAccount_user11_1', 'bank account', 15).
used('payFine', 'birthday_user11_1', 'extra data', 16).

wasGeneratedBy('receipt', 'payFine', 'receipt', 17).
wasControlledBy('sendTicket','user11', 'owner', 18, 22).
used('sendTicket', 'bankAccount_user11_1', 'extra data', 19).

used('sendTicket','mail_user11_1', 'ticket sender mail', 20).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 21).
used('sendTicket', 'ticket', 'ticket sent', 22).



wasControlledBy('sendTicket','DC', 'owner', 96036, 96039).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 96037).
used('sendTicket','mail_user11_1', 'ticket reply sent', 96038).
used('sendTicket','ticketReply', 'ticket reply sent', 96039).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 117348, 117352).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 117349).
used('sendAnalysisCookie','id_user11_1', 'user id', 117350).
used('sendAnalysisCookie', 'birthday_user11_1', 'extra data', 117351).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 117352).

wasControlledBy('sendImprovementCookie','DC', 'owner', 121702, 121706).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 121703).
used('sendImprovementCookie','id_user11_1', 'user id', 121704).
used('sendImprovementCookie', 'mail_user11_1', 'extra data', 121705).

used('sendImprovementCookie','improvement_cookie', 'cookie', 121706).

wasControlledBy('sendTicket','user11', 'owner', 121707, 121708).
used('sendTicket', 'ticketReply', 'ticket reply received', 121708).
wasControlledBy('payFine','DC', 'owner', 23, 26).
used('payFine', 'bankAccount_user11_1', 'bank account', 24).
used('payFine', 'mail_user11_1', 'extra data', 25).

wasGeneratedBy('receipt', 'payFine', 'receipt', 26).



wasControlledBy('updateData','user11', 'owner', 27, 29).
used('updateData','name_user11_1', 'data to update', 28).
wasGeneratedBy('name_user11_2', 'updateData', 'updated data', 29).

wasControlledBy('payFine','DC', 'owner', 30, 33).
used('payFine', 'bankAccount_user11_1', 'bank account', 31).
used('payFine', 'id_user11_1', 'extra data', 32).

wasGeneratedBy('receipt', 'payFine', 'receipt', 33).
wasControlledBy('doAdminProcedure','DC', 'owner', 34, 43).
used('doAdminProcedure','name_user11_2', 'user name', 35).
used('doAdminProcedure','birthday_user11_1', 'user birth day', 36).
used('doAdminProcedure','address_user11_1', 'user physical address', 37).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 38, 42).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 39).
used('sendAnalysisCookie','id_user11_1', 'user id', 40).
used('sendAnalysisCookie', 'address_user11_1', 'extra data', 41).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 42).

used('doAdminProcedure', 'mail_user11_1', 'user mail address', 43).
wasControlledBy('consent','user11','owner', 44, 45).

wasGeneratedBy('consent_user11_1','consent', 'consent', 45).

purposes(_,'birthday_user11_1',['doAdminProcedure']).
purposes(_,'bankAccount_user11_1',['payFine']).
purposes(_,'address_user11_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user11_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user11_2',['useSimulator','doAdminProcedure']).
purposes('consent_user11_1','id_user11_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


used('revokeConsent','consent_user11_1','revokeConsent', 46).
wasControlledBy('createAccount','user12','owner',1,7).
wasGeneratedBy('birthday_user12_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user12_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user12_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user12_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user12_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user12_1', 'createAccount', 'personal data', 7 ).


wasControlledBy('consent','user12','owner', 8, 13).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user12_1', 'user id', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasGeneratedBy('consent_user12_1','consent', 'consent', 13).

purposes(_,'birthday_user12_1',['doAdminProcedure']).
purposes(_,'bankAccount_user12_1',['payFine']).
purposes(_,'address_user12_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user12_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user12_1',['useSimulator','doAdminProcedure']).
purposes('consent_user12_1','id_user12_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('askDataAccess','user12','owner', 14, 20).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 15, 19).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 16).
used('sendAnalysisCookie','id_user12_1', 'user id', 17).
used('sendAnalysisCookie', 'birthday_user12_1', 'extra data', 18).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 19).

wasGeneratedBy('data_request_user12', 'askDataAccess', 'request', 20).
wasControlledBy('sendTicket','user12', 'owner', 21, 25).
used('sendTicket', 'birthday_user12_1', 'extra data', 22).

used('sendTicket','mail_user12_1', 'ticket sender mail', 23).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 24).
used('sendTicket', 'ticket', 'ticket sent', 25).



wasControlledBy('sendTicket','DC', 'owner', 84328, 84331).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 84329).
used('sendTicket','mail_user12_1', 'ticket reply sent', 84330).
used('sendTicket','ticketReply', 'ticket reply sent', 84331).


wasControlledBy('sendTicket','user12', 'owner', 84332, 84333).
used('sendTicket', 'ticketReply', 'ticket reply received', 84333).



wasControlledBy('updateData','user12', 'owner', 26, 28).
used('updateData','bankAccount_user12_1', 'data to update', 27).
wasGeneratedBy('bankAccount_user12_2', 'updateData', 'updated data', 28).

wasControlledBy('payFine','DC', 'owner', 29, 32).
used('payFine', 'bankAccount_user12_2', 'bank account', 30).
used('payFine', 'mail_user12_1', 'extra data', 31).

wasGeneratedBy('receipt', 'payFine', 'receipt', 32).

wasControlledBy('sendData','DC', 'owner', 125656, 125658).
used('sendData', 'data_request_user12', 'request received', 125657).
wasGeneratedBy('data_report_user12','sendData', 'data response', 125658).

wasControlledBy('sendData','user12', 'receiver', 125659, 125660).
used('sendData', 'data_report_user12', 'request response received', 125660).
wasControlledBy('sendMail','DC', 'owner', 33, 36).
wasGeneratedBy('message','sendMail', 'mail to send', 34).
used('sendMail','mail_user12_1', 'address to send to', 35).

used('sendMail', 'message', 'mail sent', 36).

wasControlledBy('updateConsent','user12', 'owner', 37, 39).
used('updateConsent', 'consent_user12_1', 'consent', 38).
wasGeneratedBy('consent_user12_2', 'updateConsent', 'consent', 39).


purposes('consent_user12_2','id_user12_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendPersonalizationCookie']).


wasControlledBy('payFine','DC', 'owner', 40, 42).
used('payFine', 'bankAccount_user12_2', 'bank account', 41).

wasGeneratedBy('receipt', 'payFine', 'receipt', 42).

wasControlledBy('createAccount','user13','owner',1,7).
wasGeneratedBy('birthday_user13_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user13_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user13_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user13_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user13_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user13_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 8, 11).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 9).
used('sendAnalysisCookie','id_user13_1', 'user id', 10).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 11).

wasControlledBy('consent','user13','owner', 12, 13).

wasGeneratedBy('consent_user13_1','consent', 'consent', 13).

purposes(_,'birthday_user13_1',['doAdminProcedure']).
purposes(_,'bankAccount_user13_1',['payFine']).
purposes(_,'address_user13_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user13_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user13_1',['useSimulator','doAdminProcedure']).
purposes('consent_user13_1','id_user13_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendPersonalizationCookie']).


wasControlledBy('askDataAccess','user13','owner', 14, 24).
wasControlledBy('sendImprovementCookie','DC', 'owner', 15, 19).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 16).
used('sendImprovementCookie','id_user13_1', 'user id', 17).
used('sendImprovementCookie', 'mail_user13_1', 'extra data', 18).

used('sendImprovementCookie','improvement_cookie', 'cookie', 19).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 20, 23).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 21).
used('sendAnalysisCookie','id_user13_1', 'user id', 22).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 23).

wasGeneratedBy('data_request_user13', 'askDataAccess', 'request', 24).

wasControlledBy('sendData','DC', 'owner', 60771, 60773).
used('sendData', 'data_request_user13', 'request received', 60772).
wasGeneratedBy('data_report_user13','sendData', 'data response', 60773).

wasControlledBy('sendData','user13', 'receiver', 60774, 60775).
used('sendData', 'data_report_user13', 'request response received', 60775).
wasControlledBy('sendTicket','user13', 'owner', 25, 28).

used('sendTicket','mail_user13_1', 'ticket sender mail', 26).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 27).
used('sendTicket', 'ticket', 'ticket sent', 28).


wasControlledBy('payFine','DC', 'owner', 29, 32).
used('payFine', 'bankAccount_user13_1', 'bank account', 30).
used('payFine', 'mail_user13_1', 'extra data', 31).

wasGeneratedBy('receipt', 'payFine', 'receipt', 32).

used('revokeConsent','consent_user13_1','revokeConsent', 33).

wasControlledBy('updateConsent','user13', 'owner', 34, 36).
used('updateConsent', 'consent_user13_1', 'consent', 35).
wasGeneratedBy('consent_user13_2', 'updateConsent', 'consent', 36).


purposes('consent_user13_2','id_user13_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendPersonalizationCookie']).


wasControlledBy('doAdminProcedure','DC', 'owner', 37, 41).
used('doAdminProcedure','name_user13_1', 'user name', 38).
used('doAdminProcedure','birthday_user13_1', 'user birth day', 39).
used('doAdminProcedure','address_user13_1', 'user physical address', 40).

used('doAdminProcedure', 'mail_user13_1', 'user mail address', 41).

wasControlledBy('createAccount','user14','owner',1,7).
wasGeneratedBy('birthday_user14_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user14_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user14_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user14_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user14_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user14_1', 'createAccount', 'personal data', 7 ).


wasControlledBy('consent','user14','owner', 8, 13).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user14_1', 'user id', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasGeneratedBy('consent_user14_1','consent', 'consent', 13).

purposes(_,'birthday_user14_1',['doAdminProcedure']).
purposes(_,'bankAccount_user14_1',['payFine']).
purposes(_,'address_user14_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user14_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user14_1',['useSimulator','doAdminProcedure']).
purposes('consent_user14_1','id_user14_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendPersonalizationCookie']).


wasControlledBy('askDataAccess','user14','owner', 14, 15).


wasGeneratedBy('data_request_user14', 'askDataAccess', 'request', 15).

wasControlledBy('sendData','DC', 'owner', 64386, 64388).
used('sendData', 'data_request_user14', 'request received', 64387).
wasGeneratedBy('data_report_user14','sendData', 'data response', 64388).

wasControlledBy('sendData','user14', 'receiver', 64389, 64390).
used('sendData', 'data_report_user14', 'request response received', 64390).
wasControlledBy('sendTicket','user14', 'owner', 16, 20).
used('sendTicket', 'birthday_user14_1', 'extra data', 17).

used('sendTicket','mail_user14_1', 'ticket sender mail', 18).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 19).
used('sendTicket', 'ticket', 'ticket sent', 20).



used('revokeConsent','consent_user14_1','revokeConsent', 21).
wasControlledBy('payFine','DC', 'owner', 22, 24).
used('payFine', 'bankAccount_user14_1', 'bank account', 23).

wasGeneratedBy('receipt', 'payFine', 'receipt', 24).

wasControlledBy('sendTicket','DC', 'owner', 48212, 48215).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 48213).
used('sendTicket','mail_user14_1', 'ticket reply sent', 48214).
used('sendTicket','ticketReply', 'ticket reply sent', 48215).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 119941, 119944).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 119942).
used('sendAnalysisCookie','id_user14_1', 'user id', 119943).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 119944).


wasControlledBy('sendTicket','user14', 'owner', 119945, 119946).
used('sendTicket', 'ticketReply', 'ticket reply received', 119946).
wasControlledBy('doAdminProcedure','DC', 'owner', 25, 29).
used('doAdminProcedure','name_user14_1', 'user name', 26).
used('doAdminProcedure','birthday_user14_1', 'user birth day', 27).
used('doAdminProcedure','address_user14_1', 'user physical address', 28).

used('doAdminProcedure', 'mail_user14_1', 'user mail address', 29).
wasControlledBy('sendMail','DC', 'owner', 30, 33).
wasGeneratedBy('message','sendMail', 'mail to send', 31).
used('sendMail','mail_user14_1', 'address to send to', 32).

used('sendMail', 'message', 'mail sent', 33).
wasControlledBy('useSimulator','user14', 'owner', 34, 35).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 35).

wasControlledBy('useSimulator', 'DC', 'owner', 36, 41).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 37).
used('useSimulator', 'name_user14_1', 'simulator user', 38).
used('useSimulator', 'address_user14_1', 'simulator user physical address', 39).
used('useSimulator', 'name_user14_1', 'extra data', 40).



wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 41).
wasControlledBy('createAccount','user15','owner',1,7).
wasGeneratedBy('birthday_user15_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user15_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user15_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user15_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user15_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user15_1', 'createAccount', 'personal data', 7 ).



wasControlledBy('askDataAccess','user15','owner', 8, 9).


wasGeneratedBy('data_request_user15', 'askDataAccess', 'request', 9).
wasControlledBy('consent','user15','owner', 10, 15).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 11, 14).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 12).
used('sendAnalysisCookie','id_user15_1', 'user id', 13).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 14).

wasGeneratedBy('consent_user15_1','consent', 'consent', 15).

purposes(_,'birthday_user15_1',['doAdminProcedure']).
purposes(_,'bankAccount_user15_1',['payFine']).
purposes(_,'address_user15_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user15_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user15_1',['useSimulator','doAdminProcedure']).
purposes('consent_user15_1','id_user15_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendPersonalizationCookie']).


wasControlledBy('updateConsent','user15', 'owner', 16, 18).
used('updateConsent', 'consent_user15_1', 'consent', 17).
wasGeneratedBy('consent_user15_2', 'updateConsent', 'consent', 18).


purposes('consent_user15_2','id_user15_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendPersonalizationCookie']).





wasControlledBy('updateData','user15', 'owner', 19, 21).
used('updateData','address_user15_1', 'data to update', 20).
wasGeneratedBy('address_user15_2', 'updateData', 'updated data', 21).


wasControlledBy('updateConsent','user15', 'owner', 22, 24).
used('updateConsent', 'consent_user15_2', 'consent', 23).
wasGeneratedBy('consent_user15_3', 'updateConsent', 'consent', 24).


purposes('consent_user15_3','id_user15_1',['sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('doAdminProcedure','DC', 'owner', 25, 29).
used('doAdminProcedure','name_user15_1', 'user name', 26).
used('doAdminProcedure','birthday_user15_1', 'user birth day', 27).
used('doAdminProcedure','address_user15_2', 'user physical address', 28).

used('doAdminProcedure', 'mail_user15_1', 'user mail address', 29).


wasControlledBy('sendMail','DC', 'owner', 30, 38).
wasGeneratedBy('message','sendMail', 'mail to send', 31).
used('sendMail','mail_user15_1', 'address to send to', 32).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 33, 37).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 34).
used('sendAnalysisCookie','id_user15_1', 'user id', 35).
used('sendAnalysisCookie', 'id_user15_1', 'extra data', 36).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 37).

used('sendMail', 'message', 'mail sent', 38).

wasControlledBy('sendData','DC', 'owner', 64837, 64839).
used('sendData', 'data_request_user15', 'request received', 64838).
wasGeneratedBy('data_report_user15','sendData', 'data response', 64839).

wasControlledBy('sendData','user15', 'receiver', 64840, 64841).
used('sendData', 'data_report_user15', 'request response received', 64841).
wasControlledBy('sendTicket','user15', 'owner', 39, 43).
used('sendTicket', 'mail_user15_1', 'extra data', 40).

used('sendTicket','mail_user15_1', 'ticket sender mail', 41).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 42).
used('sendTicket', 'ticket', 'ticket sent', 43).


wasControlledBy('createAccount','user16','owner',1,7).
wasGeneratedBy('birthday_user16_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user16_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user16_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user16_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user16_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user16_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 8, 11).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 9).
used('sendAnalysisCookie','id_user16_1', 'user id', 10).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 11).


wasControlledBy('consent','user16','owner', 12, 13).

wasGeneratedBy('consent_user16_1','consent', 'consent', 13).

purposes(_,'birthday_user16_1',['doAdminProcedure']).
purposes(_,'bankAccount_user16_1',['payFine']).
purposes(_,'address_user16_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user16_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user16_1',['useSimulator','doAdminProcedure']).
purposes('consent_user16_1','id_user16_1',['sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


used('revokeConsent','consent_user16_1','revokeConsent', 14).
wasControlledBy('sendTicket','user16', 'owner', 15, 19).
used('sendTicket', 'id_user16_1', 'extra data', 16).

used('sendTicket','mail_user16_1', 'ticket sender mail', 17).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 18).
used('sendTicket', 'ticket', 'ticket sent', 19).



wasControlledBy('sendTicket','DC', 'owner', 68114, 68117).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 68115).
used('sendTicket','mail_user16_1', 'ticket reply sent', 68116).
used('sendTicket','ticketReply', 'ticket reply sent', 68117).


wasControlledBy('sendTicket','user16', 'owner', 68118, 68119).
used('sendTicket', 'ticketReply', 'ticket reply received', 68119).
wasControlledBy('askDataAccess','user16','owner', 20, 25).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 21, 24).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 22).
used('sendAnalysisCookie','id_user16_1', 'user id', 23).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 24).

wasGeneratedBy('data_request_user16', 'askDataAccess', 'request', 25).

wasControlledBy('sendData','DC', 'owner', 97287, 97289).
used('sendData', 'data_request_user16', 'request received', 97288).
wasGeneratedBy('data_report_user16','sendData', 'data response', 97289).

wasControlledBy('sendData','user16', 'receiver', 97290, 97291).
used('sendData', 'data_report_user16', 'request response received', 97291).



wasControlledBy('updateData','user16', 'owner', 26, 28).
used('updateData','id_user16_1', 'data to update', 27).
wasGeneratedBy('id_user16_2', 'updateData', 'updated data', 28).

wasControlledBy('payFine','DC', 'owner', 29, 31).
used('payFine', 'bankAccount_user16_1', 'bank account', 30).

wasGeneratedBy('receipt', 'payFine', 'receipt', 31).
wasControlledBy('createAccount','user17','owner',1,7).
wasGeneratedBy('birthday_user17_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user17_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user17_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user17_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user17_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user17_1', 'createAccount', 'personal data', 7 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 8, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 9).
used('sendAnalysisCookie','id_user17_1', 'user id', 10).
used('sendAnalysisCookie', 'name_user17_1', 'extra data', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasControlledBy('consent','user17','owner', 13, 14).

wasGeneratedBy('consent_user17_1','consent', 'consent', 14).

purposes(_,'birthday_user17_1',['doAdminProcedure']).
purposes(_,'bankAccount_user17_1',['payFine']).
purposes(_,'address_user17_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user17_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user17_1',['useSimulator','doAdminProcedure']).
purposes('consent_user17_1','id_user17_1',['sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).



wasControlledBy('updateConsent','user17', 'owner', 15, 17).
used('updateConsent', 'consent_user17_1', 'consent', 16).
wasGeneratedBy('consent_user17_2', 'updateConsent', 'consent', 17).


purposes('consent_user17_2','id_user17_1',['sendThirdPartiesCookie','sendImprovementCookie']).


wasControlledBy('useSimulator','user17', 'owner', 18, 19).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 19).

wasControlledBy('useSimulator', 'DC', 'owner', 20, 30).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 21).
used('useSimulator', 'name_user17_1', 'simulator user', 22).
used('useSimulator', 'address_user17_1', 'simulator user physical address', 23).
used('useSimulator', 'birthday_user17_1', 'extra data', 24).


wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 25, 29).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 26).
used('sendThirdPartiesCookie','id_user17_1', 'user id', 27).
used('sendThirdPartiesCookie', 'birthday_user17_1', 'extra data', 28).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 29).

wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 30).

wasControlledBy('askDataAccess','user17','owner', 31, 32).


wasGeneratedBy('data_request_user17', 'askDataAccess', 'request', 32).

wasControlledBy('sendData','DC', 'owner', 67645, 67647).
used('sendData', 'data_request_user17', 'request received', 67646).
wasGeneratedBy('data_report_user17','sendData', 'data response', 67647).

wasControlledBy('sendData','user17', 'receiver', 67648, 67649).
used('sendData', 'data_report_user17', 'request response received', 67649).

used('revokeConsent','consent_user17_2','revokeConsent', 33).
wasControlledBy('sendTicket','user17', 'owner', 34, 37).

used('sendTicket','mail_user17_1', 'ticket sender mail', 35).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 36).
used('sendTicket', 'ticket', 'ticket sent', 37).



wasControlledBy('sendTicket','DC', 'owner', 101505, 101508).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 101506).
used('sendTicket','mail_user17_1', 'ticket reply sent', 101507).
used('sendTicket','ticketReply', 'ticket reply sent', 101508).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 41156, 41160).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 41157).
used('sendAnalysisCookie','id_user17_1', 'user id', 41158).
used('sendAnalysisCookie', 'name_user17_1', 'extra data', 41159).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 41160).

wasControlledBy('sendImprovementCookie','DC', 'owner', 66605, 66608).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 66606).
used('sendImprovementCookie','id_user17_1', 'user id', 66607).

used('sendImprovementCookie','improvement_cookie', 'cookie', 66608).

wasControlledBy('sendTicket','user17', 'owner', 66609, 66610).
used('sendTicket', 'ticketReply', 'ticket reply received', 66610).
wasControlledBy('createAccount','user18','owner',1,7).
wasGeneratedBy('birthday_user18_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user18_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user18_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user18_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user18_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user18_1', 'createAccount', 'personal data', 7 ).



wasControlledBy('askDataAccess','user18','owner', 8, 9).


wasGeneratedBy('data_request_user18', 'askDataAccess', 'request', 9).
wasControlledBy('payFine','DC', 'owner', 10, 13).
used('payFine', 'bankAccount_user18_1', 'bank account', 11).
used('payFine', 'id_user18_1', 'extra data', 12).

wasGeneratedBy('receipt', 'payFine', 'receipt', 13).
wasControlledBy('consent','user18','owner', 14, 15).

wasGeneratedBy('consent_user18_1','consent', 'consent', 15).

purposes(_,'birthday_user18_1',['doAdminProcedure']).
purposes(_,'bankAccount_user18_1',['payFine']).
purposes(_,'address_user18_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user18_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user18_1',['useSimulator','doAdminProcedure']).
purposes('consent_user18_1','id_user18_1',['sendThirdPartiesCookie','sendImprovementCookie']).


wasControlledBy('updateConsent','user18', 'owner', 16, 18).
used('updateConsent', 'consent_user18_1', 'consent', 17).
wasGeneratedBy('consent_user18_2', 'updateConsent', 'consent', 18).


purposes('consent_user18_2','id_user18_1',['sendImprovementCookie']).


wasControlledBy('useSimulator','user18', 'owner', 19, 20).
wasGeneratedBy('askUseSimulator', 'useSimulator', 'ask a simulation', 20).

wasControlledBy('useSimulator', 'DC', 'owner', 21, 34).
used('useSimulator', 'askUseSimulator', 'user asked a simulation', 22).
used('useSimulator', 'name_user18_1', 'simulator user', 23).
used('useSimulator', 'address_user18_1', 'simulator user physical address', 24).
used('useSimulator', 'birthday_user18_1', 'extra data', 25).

wasControlledBy('sendImprovementCookie','DC', 'owner', 26, 29).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 27).
used('sendImprovementCookie','id_user18_1', 'user id', 28).

used('sendImprovementCookie','improvement_cookie', 'cookie', 29).

wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 30, 33).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 31).
used('sendThirdPartiesCookie','id_user18_1', 'user id', 32).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 33).

wasGeneratedBy('simulatorResults', 'useSimulator', 'simulator results', 34).


wasControlledBy('sendData','DC', 'owner', 44638, 44640).
used('sendData', 'data_request_user18', 'request received', 44639).
wasGeneratedBy('data_report_user18','sendData', 'data response', 44640).

wasControlledBy('sendData','user18', 'receiver', 44641, 44642).
used('sendData', 'data_report_user18', 'request response received', 44642).



wasControlledBy('updateData','user18', 'owner', 35, 37).
used('updateData','id_user18_1', 'data to update', 36).
wasGeneratedBy('id_user18_2', 'updateData', 'updated data', 37).


wasControlledBy('updateConsent','user18', 'owner', 38, 40).
used('updateConsent', 'consent_user18_2', 'consent', 39).
wasGeneratedBy('consent_user18_3', 'updateConsent', 'consent', 40).


purposes('consent_user18_3','id_user18_2',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('payFine','DC', 'owner', 41, 44).
used('payFine', 'bankAccount_user18_1', 'bank account', 42).
used('payFine', 'mail_user18_1', 'extra data', 43).

wasGeneratedBy('receipt', 'payFine', 'receipt', 44).

wasControlledBy('sendTicket','user18', 'owner', 45, 48).

used('sendTicket','mail_user18_1', 'ticket sender mail', 46).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 47).
used('sendTicket', 'ticket', 'ticket sent', 48).



wasControlledBy('sendTicket','DC', 'owner', 49484, 49487).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 49485).
used('sendTicket','mail_user18_1', 'ticket reply sent', 49486).
used('sendTicket','ticketReply', 'ticket reply sent', 49487).

wasControlledBy('sendImprovementCookie','DC', 'owner', 111242, 111245).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 111243).
used('sendImprovementCookie','id_user18_2', 'user id', 111244).

used('sendImprovementCookie','improvement_cookie', 'cookie', 111245).

wasControlledBy('sendTicket','user18', 'owner', 111246, 111247).
used('sendTicket', 'ticketReply', 'ticket reply received', 111247).
wasControlledBy('createAccount','user19','owner',1,7).
wasGeneratedBy('birthday_user19_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('bankAccount_user19_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('address_user19_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('mail_user19_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('name_user19_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('id_user19_1', 'createAccount', 'personal data', 7 ).



wasControlledBy('consent','user19','owner', 8, 13).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user19_1', 'user id', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasGeneratedBy('consent_user19_1','consent', 'consent', 13).

purposes(_,'birthday_user19_1',['doAdminProcedure']).
purposes(_,'bankAccount_user19_1',['payFine']).
purposes(_,'address_user19_1',['useSimulator','doAdminProcedure']).
purposes(_,'mail_user19_1',['sendMail','doAdminProcedure','sendTicket']).
purposes(_,'name_user19_1',['useSimulator','doAdminProcedure']).
purposes('consent_user19_1','id_user19_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


used('revokeConsent','consent_user19_1','revokeConsent', 14).
wasControlledBy('sendTicket','user19', 'owner', 15, 18).

used('sendTicket','mail_user19_1', 'ticket sender mail', 16).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 17).
used('sendTicket', 'ticket', 'ticket sent', 18).


wasControlledBy('sendMail','DC', 'owner', 19, 22).
wasGeneratedBy('message','sendMail', 'mail to send', 20).
used('sendMail','mail_user19_1', 'address to send to', 21).

used('sendMail', 'message', 'mail sent', 22).

wasControlledBy('updateConsent','user19', 'owner', 23, 25).
used('updateConsent', 'consent_user19_1', 'consent', 24).
wasGeneratedBy('consent_user19_2', 'updateConsent', 'consent', 25).


purposes('consent_user19_2','id_user19_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','sendPersonalizationCookie']).


wasControlledBy('doAdminProcedure','DC', 'owner', 26, 30).
used('doAdminProcedure','name_user19_1', 'user name', 27).
used('doAdminProcedure','birthday_user19_1', 'user birth day', 28).
used('doAdminProcedure','address_user19_1', 'user physical address', 29).

used('doAdminProcedure', 'mail_user19_1', 'user mail address', 30).


wasControlledBy('sendTicket','DC', 'owner', 60771, 60774).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 60772).
used('sendTicket','mail_user19_1', 'ticket reply sent', 60773).
used('sendTicket','ticketReply', 'ticket reply sent', 60774).

wasControlledBy('sendImprovementCookie','DC', 'owner', 78931, 78934).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 78932).
used('sendImprovementCookie','id_user19_1', 'user id', 78933).

used('sendImprovementCookie','improvement_cookie', 'cookie', 78934).

wasControlledBy('sendTicket','user19', 'owner', 78935, 78936).
used('sendTicket', 'ticketReply', 'ticket reply received', 78936).
purposes(_,_,['consent','delete','askErase','sendData','askDataAccess','updateConsent','accessWebPage','updateData','createAccount','login']).
wasControlledBy('askErase','user19', 'owner', 31, 37).
used('askErase','birthday_user19_1', 'to erase data', 32).
used('askErase','bankAccount_user19_1', 'to erase data', 33).
used('askErase','address_user19_1', 'to erase data', 34).
used('askErase','mail_user19_1', 'to erase data', 35).
used('askErase','name_user19_1', 'to erase data', 36).
used('askErase','id_user19_1', 'to erase data', 37).



action('sendData', 'sendData').
action('useSimulator', 'useSimulator').
action('sendThirdPartiesCookie', 'sendThirdPartiesCookie').
action('updateData', 'updateData').
action('sendAdSMS', 'sendAdSMS').
action('sendMail', 'sendMail').
action('sendImprovementCookie', 'sendImprovementCookie').
action('payFine', 'payFine').
action('doAdminProcedure', 'doAdminProcedure').
action('createAccount', 'createAccount').
action('consent', 'consent').
action('login', 'login').
action('delete', 'delete').
action('askDataAccess', 'askDataAccess').
action('sendTicket', 'sendTicket').
action('sendPersonalizationCookie', 'sendPersonalizationCookie').
action('sendAnalysisCookie', 'sendAnalysisCookie').
action('providePolicy', 'providePolicy').
action('askErase', 'askErase').
action('updateConsent', 'updateConsent').
