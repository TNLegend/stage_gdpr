wasControlledBy('createAccount','user0','owner',1,8).
wasGeneratedBy('birthday_user0_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user0_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user0_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user0_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user0_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user0_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user0_1', 'createAccount', 'personal data', 8 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 13).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user0_1', 'user id', 11).
used('sendAnalysisCookie', 'friends_user0_1', 'extra data', 12).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 13).


wasControlledBy('consent','user0','owner', 14, 19).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 15, 18).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 16).
used('sendAnalysisCookie','id_user0_1', 'user id', 17).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 18).

wasGeneratedBy('consent_user0_1','consent', 'consent', 19).

purposes('consent_user0_1','birthday_user0_1',['showRecommendation']).
purposes(_,'mail_user0_1',['sendMail','sendTicket']).
purposes(_,'name_user0_1',[]).
purposes('consent_user0_1','id_user0_1',['sendAnalysisCookie','joinGroup']).
purposes('consent_user0_1','wall_user0_1',['post']).
purposes('consent_user0_1','friends_user0_1',['post','showRecommendation']).
purposes(_,'username_user0_1',['post']).

wasControlledBy('sendMail','DC', 'owner', 20, 23).
wasGeneratedBy('message','sendMail', 'mail to send', 21).
used('sendMail','mail_user0_1', 'address to send to', 22).

used('sendMail', 'message', 'mail sent', 23).
wasControlledBy('askDataAccess','user0','owner', 24, 29).
wasControlledBy('sendImprovementCookie','DC', 'owner', 25, 28).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 26).
used('sendImprovementCookie','id_user0_1', 'user id', 27).

used('sendImprovementCookie','improvement_cookie', 'cookie', 28).


wasGeneratedBy('data_request_user0', 'askDataAccess', 'request', 29).

wasControlledBy('updateConsent','user0', 'owner', 30, 32).
used('updateConsent', 'consent_user0_1', 'consent', 31).
wasGeneratedBy('consent_user0_2', 'updateConsent', 'consent', 32).


purposes('consent_user0_2','birthday_user0_1',['showRecommendation']).
purposes('consent_user0_2','id_user0_1',['sendAnalysisCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user0_2','wall_user0_1',['post','showRecommendation']).
purposes('consent_user0_2','friends_user0_1',['post','showRecommendation']).





wasControlledBy('updateData','user0', 'owner', 33, 35).
used('updateData','birthday_user0_1', 'data to update', 34).
wasGeneratedBy('birthday_user0_2', 'updateData', 'updated data', 35).


wasControlledBy('updateConsent','user0', 'owner', 36, 38).
used('updateConsent', 'consent_user0_2', 'consent', 37).
wasGeneratedBy('consent_user0_3', 'updateConsent', 'consent', 38).


purposes('consent_user0_3','birthday_user0_2',[]).
purposes('consent_user0_3','id_user0_1',['sendAnalysisCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user0_3','wall_user0_1',['post']).
purposes('consent_user0_3','friends_user0_1',['post','showRecommendation']).





wasControlledBy('updateData','user0', 'owner', 39, 41).
used('updateData','mail_user0_1', 'data to update', 40).
wasGeneratedBy('mail_user0_2', 'updateData', 'updated data', 41).

wasControlledBy('post','user0', 'owner', 42, 58).
wasGeneratedBy('message', 'post', 'new post message', 43).
used('post','username_user0_1', 'username', 44).
used('post','friends_user0_1', 'user friends', 45).
used('post','wall_user0_1', 'user wall', 46).
used('post', 'birthday_user0_2', 'extra data', 47).

used('post','message', 'user message', 48).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 49, 53).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 50).
used('sendAnalysisCookie','id_user0_1', 'user id', 51).
used('sendAnalysisCookie', 'mail_user0_2', 'extra data', 52).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 53).

wasControlledBy('sendImprovementCookie','DC', 'owner', 54, 57).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 55).
used('sendImprovementCookie','id_user0_1', 'user id', 56).

used('sendImprovementCookie','improvement_cookie', 'cookie', 57).

wasGeneratedBy('newPost', 'post', 'new user post', 58).


wasControlledBy('sendTicket','user0', 'owner', 59, 62).

used('sendTicket','mail_user0_2', 'ticket sender mail', 60).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 61).
used('sendTicket', 'ticket', 'ticket sent', 62).



wasControlledBy('sendData','DC', 'owner', 87755, 87757).
used('sendData', 'data_request_user0', 'request received', 87756).
wasGeneratedBy('data_report_user0','sendData', 'data response', 87757).

wasControlledBy('sendData','user0', 'receiver', 87758, 87759).
used('sendData', 'data_report_user0', 'request response received', 87759).
wasControlledBy('joinGroup','user0','owner',63,64).
used('joinGroup','id_user0_1', 'join group', 64).


wasControlledBy('sendTicket','DC', 'owner', 121776, 121779).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 121777).
used('sendTicket','mail_user0_2', 'ticket reply sent', 121778).
used('sendTicket','ticketReply', 'ticket reply sent', 121779).

wasControlledBy('sendImprovementCookie','DC', 'owner', 88805, 88809).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 88806).
used('sendImprovementCookie','id_user0_1', 'user id', 88807).
used('sendImprovementCookie', 'id_user0_1', 'extra data', 88808).

used('sendImprovementCookie','improvement_cookie', 'cookie', 88809).

wasControlledBy('sendTicket','user0', 'owner', 88810, 88811).
used('sendTicket', 'ticketReply', 'ticket reply received', 88811).

used('revokeConsent','consent_user0_3','revokeConsent', 65).
wasControlledBy('joinGroup','user0','owner',66,67).
used('joinGroup','id_user0_1', 'join group', 67).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 68, 72).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 69).
used('sendThirdPartiesCookie','id_user0_1', 'user id', 70).
used('sendThirdPartiesCookie', 'mail_user0_2', 'extra data', 71).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 72).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 73, 76).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 74).
used('sendAnalysisCookie','id_user0_1', 'user id', 75).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 76).



wasControlledBy('updateData','user0', 'owner', 77, 79).
used('updateData','name_user0_1', 'data to update', 78).
wasGeneratedBy('name_user0_2', 'updateData', 'updated data', 79).


wasControlledBy('updateConsent','user0', 'owner', 80, 82).
used('updateConsent', 'consent_user0_3', 'consent', 81).
wasGeneratedBy('consent_user0_4', 'updateConsent', 'consent', 82).


purposes('consent_user0_4','birthday_user0_2',['showRecommendation']).
purposes('consent_user0_4','id_user0_1',['sendAnalysisCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user0_4','wall_user0_1',['post']).
purposes('consent_user0_4','friends_user0_1',['post','showRecommendation']).


wasControlledBy('post','user0', 'owner', 83, 95).
wasGeneratedBy('message', 'post', 'new post message', 84).
used('post','username_user0_1', 'username', 85).
used('post','friends_user0_1', 'user friends', 86).
used('post','wall_user0_1', 'user wall', 87).
used('post', 'mail_user0_2', 'extra data', 88).

used('post','message', 'user message', 89).

wasControlledBy('sendImprovementCookie','DC', 'owner', 90, 94).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 91).
used('sendImprovementCookie','id_user0_1', 'user id', 92).
used('sendImprovementCookie', 'birthday_user0_2', 'extra data', 93).

used('sendImprovementCookie','improvement_cookie', 'cookie', 94).

wasGeneratedBy('newPost', 'post', 'new user post', 95).

wasControlledBy('createAccount','user1','owner',1,8).
wasGeneratedBy('birthday_user1_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user1_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user1_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user1_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user1_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user1_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user1_1', 'createAccount', 'personal data', 8 ).


wasControlledBy('consent','user1','owner', 9, 15).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 10, 14).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 11).
used('sendAnalysisCookie','id_user1_1', 'user id', 12).
used('sendAnalysisCookie', 'id_user1_1', 'extra data', 13).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 14).

wasGeneratedBy('consent_user1_1','consent', 'consent', 15).

purposes('consent_user1_1','birthday_user1_1',['showRecommendation']).
purposes(_,'mail_user1_1',['sendMail','sendTicket']).
purposes(_,'name_user1_1',[]).
purposes('consent_user1_1','id_user1_1',['sendAnalysisCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user1_1','wall_user1_1',['post']).
purposes('consent_user1_1','friends_user1_1',['post','showRecommendation']).
purposes(_,'username_user1_1',['post']).


wasControlledBy('sendMail','DC', 'owner', 16, 19).
wasGeneratedBy('message','sendMail', 'mail to send', 17).
used('sendMail','mail_user1_1', 'address to send to', 18).

used('sendMail', 'message', 'mail sent', 19).



wasControlledBy('updateData','user1', 'owner', 20, 22).
used('updateData','id_user1_1', 'data to update', 21).
wasGeneratedBy('id_user1_2', 'updateData', 'updated data', 22).

wasControlledBy('post','user1', 'owner', 23, 39).
wasGeneratedBy('message', 'post', 'new post message', 24).
used('post','username_user1_1', 'username', 25).
used('post','friends_user1_1', 'user friends', 26).
used('post','wall_user1_1', 'user wall', 27).

used('post','message', 'user message', 28).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 29, 33).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 30).
used('sendAnalysisCookie','id_user1_2', 'user id', 31).
used('sendAnalysisCookie', 'username_user1_1', 'extra data', 32).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 33).

wasControlledBy('sendImprovementCookie','DC', 'owner', 34, 38).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 35).
used('sendImprovementCookie','id_user1_2', 'user id', 36).
used('sendImprovementCookie', 'username_user1_1', 'extra data', 37).

used('sendImprovementCookie','improvement_cookie', 'cookie', 38).

wasGeneratedBy('newPost', 'post', 'new user post', 39).
wasControlledBy('askDataAccess','user1','owner', 40, 41).


wasGeneratedBy('data_request_user1', 'askDataAccess', 'request', 41).

wasControlledBy('sendData','DC', 'owner', 29829, 29831).
used('sendData', 'data_request_user1', 'request received', 29830).
wasGeneratedBy('data_report_user1','sendData', 'data response', 29831).

wasControlledBy('sendData','user1', 'receiver', 29832, 29833).
used('sendData', 'data_report_user1', 'request response received', 29833).

wasControlledBy('updateConsent','user1', 'owner', 42, 44).
used('updateConsent', 'consent_user1_1', 'consent', 43).
wasGeneratedBy('consent_user1_2', 'updateConsent', 'consent', 44).


purposes('consent_user1_2','birthday_user1_1',['showRecommendation']).
purposes('consent_user1_2','id_user1_2',['sendAnalysisCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user1_2','wall_user1_1',['post','showRecommendation']).
purposes('consent_user1_2','friends_user1_1',['post','showRecommendation']).





wasControlledBy('updateData','user1', 'owner', 45, 47).
used('updateData','username_user1_1', 'data to update', 46).
wasGeneratedBy('username_user1_2', 'updateData', 'updated data', 47).


wasControlledBy('updateConsent','user1', 'owner', 48, 50).
used('updateConsent', 'consent_user1_2', 'consent', 49).
wasGeneratedBy('consent_user1_3', 'updateConsent', 'consent', 50).


purposes('consent_user1_3','birthday_user1_1',[]).
purposes('consent_user1_3','id_user1_2',['sendAnalysisCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user1_3','wall_user1_1',['post','showRecommendation']).
purposes('consent_user1_3','friends_user1_1',['post','showRecommendation']).


wasControlledBy('joinGroup','user1','owner',51,52).
used('joinGroup','id_user1_2', 'join group', 52).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 53, 56).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 54).
used('sendThirdPartiesCookie','id_user1_2', 'user id', 55).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 56).




used('revokeConsent','consent_user1_3','revokeConsent', 57).

wasControlledBy('updateConsent','user1', 'owner', 58, 60).
used('updateConsent', 'consent_user1_3', 'consent', 59).
wasGeneratedBy('consent_user1_4', 'updateConsent', 'consent', 60).


purposes('consent_user1_4','birthday_user1_1',[]).
purposes('consent_user1_4','id_user1_2',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user1_4','wall_user1_1',['post','showRecommendation']).
purposes('consent_user1_4','friends_user1_1',['post','showRecommendation']).


wasControlledBy('showRecommendation','DC', 'owner', 61, 69).
used('showRecommendation','id_user1_2', 'user id', 62).
used('showRecommendation','birthday_user1_1', 'user birth day', 63).
used('showRecommendation','friends_user1_1', 'user friends', 64).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 65, 68).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 66).
used('sendPersonalizationCookie','id_user1_2', 'user id', 67).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 68).

used('showRecommendation','wall_user1_1', 'user wall', 69).

wasControlledBy('post','user1', 'owner', 70, 84).
wasGeneratedBy('message', 'post', 'new post message', 71).
used('post','username_user1_2', 'username', 72).
used('post','friends_user1_1', 'user friends', 73).
used('post','wall_user1_1', 'user wall', 74).

used('post','message', 'user message', 75).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 76, 79).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 77).
used('sendAnalysisCookie','id_user1_2', 'user id', 78).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 79).

wasControlledBy('sendImprovementCookie','DC', 'owner', 80, 83).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 81).
used('sendImprovementCookie','id_user1_2', 'user id', 82).

used('sendImprovementCookie','improvement_cookie', 'cookie', 83).

wasGeneratedBy('newPost', 'post', 'new user post', 84).
wasControlledBy('sendTicket','user1', 'owner', 85, 88).

used('sendTicket','mail_user1_1', 'ticket sender mail', 86).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 87).
used('sendTicket', 'ticket', 'ticket sent', 88).



wasControlledBy('sendTicket','DC', 'owner', 81823, 81826).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 81824).
used('sendTicket','mail_user1_1', 'ticket reply sent', 81825).
used('sendTicket','ticketReply', 'ticket reply sent', 81826).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 45677, 45681).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 45678).
used('sendAnalysisCookie','id_user1_2', 'user id', 45679).
used('sendAnalysisCookie', 'birthday_user1_1', 'extra data', 45680).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 45681).

wasControlledBy('sendImprovementCookie','DC', 'owner', 59137, 59141).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 59138).
used('sendImprovementCookie','id_user1_2', 'user id', 59139).
used('sendImprovementCookie', 'mail_user1_1', 'extra data', 59140).

used('sendImprovementCookie','improvement_cookie', 'cookie', 59141).

wasControlledBy('sendTicket','user1', 'owner', 59142, 59143).
used('sendTicket', 'ticketReply', 'ticket reply received', 59143).
wasControlledBy('post','user1', 'owner', 89, 96).
wasGeneratedBy('message', 'post', 'new post message', 90).
used('post','username_user1_2', 'username', 91).
used('post','friends_user1_1', 'user friends', 92).
used('post','wall_user1_1', 'user wall', 93).
used('post', 'wall_user1_1', 'extra data', 94).

used('post','message', 'user message', 95).


wasGeneratedBy('newPost', 'post', 'new user post', 96).
wasControlledBy('joinGroup','user1','owner',97,98).
used('joinGroup','id_user1_2', 'join group', 98).




wasControlledBy('updateData','user1', 'owner', 99, 101).
used('updateData','username_user1_2', 'data to update', 100).
wasGeneratedBy('username_user1_3', 'updateData', 'updated data', 101).

wasControlledBy('post','user1', 'owner', 102, 114).
wasGeneratedBy('message', 'post', 'new post message', 103).
used('post','username_user1_3', 'username', 104).
used('post','friends_user1_1', 'user friends', 105).
used('post','wall_user1_1', 'user wall', 106).
used('post', 'username_user1_3', 'extra data', 107).

used('post','message', 'user message', 108).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 109, 113).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 110).
used('sendAnalysisCookie','id_user1_2', 'user id', 111).
used('sendAnalysisCookie', 'name_user1_1', 'extra data', 112).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 113).


wasGeneratedBy('newPost', 'post', 'new user post', 114).
wasControlledBy('createAccount','user2','owner',1,8).
wasGeneratedBy('birthday_user2_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user2_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user2_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user2_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user2_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user2_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user2_1', 'createAccount', 'personal data', 8 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user2_1', 'user id', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasControlledBy('consent','user2','owner', 13, 18).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 14, 17).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 15).
used('sendAnalysisCookie','id_user2_1', 'user id', 16).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 17).

wasGeneratedBy('consent_user2_1','consent', 'consent', 18).

purposes('consent_user2_1','birthday_user2_1',[]).
purposes(_,'mail_user2_1',['sendMail','sendTicket']).
purposes(_,'name_user2_1',[]).
purposes('consent_user2_1','id_user2_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user2_1','wall_user2_1',['post','showRecommendation']).
purposes('consent_user2_1','friends_user2_1',['post','showRecommendation']).
purposes(_,'username_user2_1',['post']).


wasControlledBy('askDataAccess','user2','owner', 19, 24).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 20, 23).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 21).
used('sendAnalysisCookie','id_user2_1', 'user id', 22).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 23).

wasGeneratedBy('data_request_user2', 'askDataAccess', 'request', 24).

wasControlledBy('sendData','DC', 'owner', 54668, 54670).
used('sendData', 'data_request_user2', 'request received', 54669).
wasGeneratedBy('data_report_user2','sendData', 'data response', 54670).

wasControlledBy('sendData','user2', 'receiver', 54671, 54672).
used('sendData', 'data_report_user2', 'request response received', 54672).
wasControlledBy('sendTicket','user2', 'owner', 25, 29).
used('sendTicket', 'wall_user2_1', 'extra data', 26).

used('sendTicket','mail_user2_1', 'ticket sender mail', 27).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 28).
used('sendTicket', 'ticket', 'ticket sent', 29).



wasControlledBy('sendTicket','DC', 'owner', 73046, 73049).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 73047).
used('sendTicket','mail_user2_1', 'ticket reply sent', 73048).
used('sendTicket','ticketReply', 'ticket reply sent', 73049).


wasControlledBy('sendTicket','user2', 'owner', 73050, 73051).
used('sendTicket', 'ticketReply', 'ticket reply received', 73051).

wasControlledBy('updateConsent','user2', 'owner', 30, 32).
used('updateConsent', 'consent_user2_1', 'consent', 31).
wasGeneratedBy('consent_user2_2', 'updateConsent', 'consent', 32).


purposes('consent_user2_2','birthday_user2_1',['showRecommendation']).
purposes('consent_user2_2','id_user2_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user2_2','wall_user2_1',['post']).
purposes('consent_user2_2','friends_user2_1',['post','showRecommendation']).


wasControlledBy('post','user2', 'owner', 33, 40).
wasGeneratedBy('message', 'post', 'new post message', 34).
used('post','username_user2_1', 'username', 35).
used('post','friends_user2_1', 'user friends', 36).
used('post','wall_user2_1', 'user wall', 37).
used('post', 'mail_user2_1', 'extra data', 38).

used('post','message', 'user message', 39).


wasGeneratedBy('newPost', 'post', 'new user post', 40).




wasControlledBy('updateData','user2', 'owner', 41, 43).
used('updateData','username_user2_1', 'data to update', 42).
wasGeneratedBy('username_user2_2', 'updateData', 'updated data', 43).

wasControlledBy('joinGroup','user2','owner',44,45).
used('joinGroup','id_user2_1', 'join group', 45).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 46, 49).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 47).
used('sendAnalysisCookie','id_user2_1', 'user id', 48).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 49).

used('revokeConsent','consent_user2_2','revokeConsent', 50).
wasControlledBy('post','user2', 'owner', 51, 61).
wasGeneratedBy('message', 'post', 'new post message', 52).
used('post','username_user2_2', 'username', 53).
used('post','friends_user2_1', 'user friends', 54).
used('post','wall_user2_1', 'user wall', 55).

used('post','message', 'user message', 56).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 57, 60).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 58).
used('sendAnalysisCookie','id_user2_1', 'user id', 59).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 60).


wasGeneratedBy('newPost', 'post', 'new user post', 61).
wasControlledBy('sendMail','DC', 'owner', 62, 69).
wasGeneratedBy('message','sendMail', 'mail to send', 63).
used('sendMail','mail_user2_1', 'address to send to', 64).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 65, 68).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 66).
used('sendAnalysisCookie','id_user2_1', 'user id', 67).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 68).

used('sendMail', 'message', 'mail sent', 69).



wasControlledBy('updateData','user2', 'owner', 70, 72).
used('updateData','name_user2_1', 'data to update', 71).
wasGeneratedBy('name_user2_2', 'updateData', 'updated data', 72).

wasControlledBy('post','user2', 'owner', 73, 79).
wasGeneratedBy('message', 'post', 'new post message', 74).
used('post','username_user2_2', 'username', 75).
used('post','friends_user2_1', 'user friends', 76).
used('post','wall_user2_1', 'user wall', 77).

used('post','message', 'user message', 78).


wasGeneratedBy('newPost', 'post', 'new user post', 79).
wasControlledBy('joinGroup','user2','owner',80,81).
used('joinGroup','id_user2_1', 'join group', 81).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 82, 86).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 83).
used('sendThirdPartiesCookie','id_user2_1', 'user id', 84).
used('sendThirdPartiesCookie', 'name_user2_2', 'extra data', 85).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 86).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 87, 91).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 88).
used('sendAnalysisCookie','id_user2_1', 'user id', 89).
used('sendAnalysisCookie', 'friends_user2_1', 'extra data', 90).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 91).



wasControlledBy('updateData','user2', 'owner', 92, 94).
used('updateData','name_user2_2', 'data to update', 93).
wasGeneratedBy('name_user2_3', 'updateData', 'updated data', 94).


wasControlledBy('updateConsent','user2', 'owner', 95, 97).
used('updateConsent', 'consent_user2_2', 'consent', 96).
wasGeneratedBy('consent_user2_3', 'updateConsent', 'consent', 97).


purposes('consent_user2_3','birthday_user2_1',['showRecommendation']).
purposes('consent_user2_3','id_user2_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user2_3','wall_user2_1',['post','showRecommendation']).
purposes('consent_user2_3','friends_user2_1',['post','showRecommendation']).


wasControlledBy('post','user2', 'owner', 98, 109).
wasGeneratedBy('message', 'post', 'new post message', 99).
used('post','username_user2_2', 'username', 100).
used('post','friends_user2_1', 'user friends', 101).
used('post','wall_user2_1', 'user wall', 102).
used('post', 'username_user2_2', 'extra data', 103).

used('post','message', 'user message', 104).

wasControlledBy('sendImprovementCookie','DC', 'owner', 105, 108).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 106).
used('sendImprovementCookie','id_user2_1', 'user id', 107).

used('sendImprovementCookie','improvement_cookie', 'cookie', 108).

wasGeneratedBy('newPost', 'post', 'new user post', 109).




wasControlledBy('updateData','user2', 'owner', 110, 112).
used('updateData','name_user2_3', 'data to update', 111).
wasGeneratedBy('name_user2_4', 'updateData', 'updated data', 112).

wasControlledBy('post','user2', 'owner', 113, 123).
wasGeneratedBy('message', 'post', 'new post message', 114).
used('post','username_user2_2', 'username', 115).
used('post','friends_user2_1', 'user friends', 116).
used('post','wall_user2_1', 'user wall', 117).

used('post','message', 'user message', 118).

wasControlledBy('sendImprovementCookie','DC', 'owner', 119, 122).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 120).
used('sendImprovementCookie','id_user2_1', 'user id', 121).

used('sendImprovementCookie','improvement_cookie', 'cookie', 122).

wasGeneratedBy('newPost', 'post', 'new user post', 123).
wasControlledBy('createAccount','user3','owner',1,8).
wasGeneratedBy('birthday_user3_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user3_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user3_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user3_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user3_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user3_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user3_1', 'createAccount', 'personal data', 8 ).



wasControlledBy('consent','user3','owner', 9, 15).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 10, 14).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 11).
used('sendAnalysisCookie','id_user3_1', 'user id', 12).
used('sendAnalysisCookie', 'name_user3_1', 'extra data', 13).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 14).

wasGeneratedBy('consent_user3_1','consent', 'consent', 15).

purposes('consent_user3_1','birthday_user3_1',['showRecommendation']).
purposes(_,'mail_user3_1',['sendMail','sendTicket']).
purposes(_,'name_user3_1',[]).
purposes('consent_user3_1','id_user3_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user3_1','wall_user3_1',['post','showRecommendation']).
purposes('consent_user3_1','friends_user3_1',['post','showRecommendation']).
purposes(_,'username_user3_1',['post']).


used('revokeConsent','consent_user3_1','revokeConsent', 16).

wasControlledBy('updateConsent','user3', 'owner', 17, 19).
used('updateConsent', 'consent_user3_1', 'consent', 18).
wasGeneratedBy('consent_user3_2', 'updateConsent', 'consent', 19).


purposes('consent_user3_2','birthday_user3_1',[]).
purposes('consent_user3_2','id_user3_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user3_2','wall_user3_1',['post','showRecommendation']).
purposes('consent_user3_2','friends_user3_1',['post','showRecommendation']).


wasControlledBy('showRecommendation','DC', 'owner', 20, 32).
used('showRecommendation','id_user3_1', 'user id', 21).
used('showRecommendation','birthday_user3_1', 'user birth day', 22).
used('showRecommendation','friends_user3_1', 'user friends', 23).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 24, 27).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 25).
used('sendAnalysisCookie','id_user3_1', 'user id', 26).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 27).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 28, 31).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 29).
used('sendPersonalizationCookie','id_user3_1', 'user id', 30).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 31).

used('showRecommendation','wall_user3_1', 'user wall', 32).

wasControlledBy('sendTicket','user3', 'owner', 33, 37).
used('sendTicket', 'wall_user3_1', 'extra data', 34).

used('sendTicket','mail_user3_1', 'ticket sender mail', 35).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 36).
used('sendTicket', 'ticket', 'ticket sent', 37).


wasControlledBy('sendMail','DC', 'owner', 38, 45).
wasGeneratedBy('message','sendMail', 'mail to send', 39).
used('sendMail','mail_user3_1', 'address to send to', 40).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 41, 44).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 42).
used('sendAnalysisCookie','id_user3_1', 'user id', 43).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 44).

used('sendMail', 'message', 'mail sent', 45).

wasControlledBy('sendTicket','DC', 'owner', 53854, 53857).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 53855).
used('sendTicket','mail_user3_1', 'ticket reply sent', 53856).
used('sendTicket','ticketReply', 'ticket reply sent', 53857).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 92250, 92254).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 92251).
used('sendAnalysisCookie','id_user3_1', 'user id', 92252).
used('sendAnalysisCookie', 'id_user3_1', 'extra data', 92253).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 92254).

wasControlledBy('sendImprovementCookie','DC', 'owner', 122505, 122509).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 122506).
used('sendImprovementCookie','id_user3_1', 'user id', 122507).
used('sendImprovementCookie', 'mail_user3_1', 'extra data', 122508).

used('sendImprovementCookie','improvement_cookie', 'cookie', 122509).

wasControlledBy('sendTicket','user3', 'owner', 122510, 122511).
used('sendTicket', 'ticketReply', 'ticket reply received', 122511).
wasControlledBy('post','user3', 'owner', 46, 58).
wasGeneratedBy('message', 'post', 'new post message', 47).
used('post','username_user3_1', 'username', 48).
used('post','friends_user3_1', 'user friends', 49).
used('post','wall_user3_1', 'user wall', 50).
used('post', 'birthday_user3_1', 'extra data', 51).

used('post','message', 'user message', 52).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 53, 57).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 54).
used('sendAnalysisCookie','id_user3_1', 'user id', 55).
used('sendAnalysisCookie', 'username_user3_1', 'extra data', 56).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 57).


wasGeneratedBy('newPost', 'post', 'new user post', 58).
wasControlledBy('askDataAccess','user3','owner', 59, 65).
wasControlledBy('sendImprovementCookie','DC', 'owner', 60, 64).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 61).
used('sendImprovementCookie','id_user3_1', 'user id', 62).
used('sendImprovementCookie', 'birthday_user3_1', 'extra data', 63).

used('sendImprovementCookie','improvement_cookie', 'cookie', 64).


wasGeneratedBy('data_request_user3', 'askDataAccess', 'request', 65).

wasControlledBy('sendData','DC', 'owner', 104877, 104879).
used('sendData', 'data_request_user3', 'request received', 104878).
wasGeneratedBy('data_report_user3','sendData', 'data response', 104879).

wasControlledBy('sendData','user3', 'receiver', 104880, 104881).
used('sendData', 'data_report_user3', 'request response received', 104881).
wasControlledBy('joinGroup','user3','owner',66,67).
used('joinGroup','id_user3_1', 'join group', 67).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 68, 72).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 69).
used('sendThirdPartiesCookie','id_user3_1', 'user id', 70).
used('sendThirdPartiesCookie', 'name_user3_1', 'extra data', 71).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 72).




wasControlledBy('updateData','user3', 'owner', 73, 75).
used('updateData','id_user3_1', 'data to update', 74).
wasGeneratedBy('id_user3_2', 'updateData', 'updated data', 75).


wasControlledBy('updateConsent','user3', 'owner', 76, 78).
used('updateConsent', 'consent_user3_2', 'consent', 77).
wasGeneratedBy('consent_user3_3', 'updateConsent', 'consent', 78).


purposes('consent_user3_3','birthday_user3_1',['showRecommendation']).
purposes('consent_user3_3','id_user3_2',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user3_3','wall_user3_1',['post','showRecommendation']).
purposes('consent_user3_3','friends_user3_1',['post','showRecommendation']).





wasControlledBy('updateData','user3', 'owner', 79, 81).
used('updateData','mail_user3_1', 'data to update', 80).
wasGeneratedBy('mail_user3_2', 'updateData', 'updated data', 81).

wasControlledBy('joinGroup','user3','owner',82,83).
used('joinGroup','id_user3_2', 'join group', 83).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 84, 88).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 85).
used('sendThirdPartiesCookie','id_user3_2', 'user id', 86).
used('sendThirdPartiesCookie', 'name_user3_1', 'extra data', 87).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 88).


wasControlledBy('createAccount','user4','owner',1,8).
wasGeneratedBy('birthday_user4_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user4_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user4_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user4_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user4_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user4_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user4_1', 'createAccount', 'personal data', 8 ).


wasControlledBy('consent','user4','owner', 9, 10).

wasGeneratedBy('consent_user4_1','consent', 'consent', 10).

purposes('consent_user4_1','birthday_user4_1',['showRecommendation']).
purposes(_,'mail_user4_1',['sendMail','sendTicket']).
purposes(_,'name_user4_1',[]).
purposes('consent_user4_1','id_user4_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user4_1','wall_user4_1',['post','showRecommendation']).
purposes('consent_user4_1','friends_user4_1',['post','showRecommendation']).
purposes(_,'username_user4_1',['post']).


wasControlledBy('askDataAccess','user4','owner', 11, 22).
wasControlledBy('sendImprovementCookie','DC', 'owner', 12, 16).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 13).
used('sendImprovementCookie','id_user4_1', 'user id', 14).
used('sendImprovementCookie', 'username_user4_1', 'extra data', 15).

used('sendImprovementCookie','improvement_cookie', 'cookie', 16).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 17, 21).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 18).
used('sendAnalysisCookie','id_user4_1', 'user id', 19).
used('sendAnalysisCookie', 'name_user4_1', 'extra data', 20).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 21).

wasGeneratedBy('data_request_user4', 'askDataAccess', 'request', 22).

wasControlledBy('sendData','DC', 'owner', 70954, 70956).
used('sendData', 'data_request_user4', 'request received', 70955).
wasGeneratedBy('data_report_user4','sendData', 'data response', 70956).

wasControlledBy('sendData','user4', 'receiver', 70957, 70958).
used('sendData', 'data_report_user4', 'request response received', 70958).

used('revokeConsent','consent_user4_1','revokeConsent', 23).
wasControlledBy('sendTicket','user4', 'owner', 24, 28).
used('sendTicket', 'name_user4_1', 'extra data', 25).

used('sendTicket','mail_user4_1', 'ticket sender mail', 26).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 27).
used('sendTicket', 'ticket', 'ticket sent', 28).



wasControlledBy('updateConsent','user4', 'owner', 29, 31).
used('updateConsent', 'consent_user4_1', 'consent', 30).
wasGeneratedBy('consent_user4_2', 'updateConsent', 'consent', 31).


purposes('consent_user4_2','birthday_user4_1',['showRecommendation']).
purposes('consent_user4_2','id_user4_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user4_2','wall_user4_1',['post','showRecommendation']).
purposes('consent_user4_2','friends_user4_1',['post','showRecommendation']).


wasControlledBy('joinGroup','user4','owner',32,33).
used('joinGroup','id_user4_1', 'join group', 33).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 34, 38).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 35).
used('sendThirdPartiesCookie','id_user4_1', 'user id', 36).
used('sendThirdPartiesCookie', 'birthday_user4_1', 'extra data', 37).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 38).



wasControlledBy('sendTicket','DC', 'owner', 31181, 31184).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 31182).
used('sendTicket','mail_user4_1', 'ticket reply sent', 31183).
used('sendTicket','ticketReply', 'ticket reply sent', 31184).


wasControlledBy('sendTicket','user4', 'owner', 31185, 31186).
used('sendTicket', 'ticketReply', 'ticket reply received', 31186).
wasControlledBy('sendMail','DC', 'owner', 39, 46).
wasGeneratedBy('message','sendMail', 'mail to send', 40).
used('sendMail','mail_user4_1', 'address to send to', 41).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 42, 45).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 43).
used('sendAnalysisCookie','id_user4_1', 'user id', 44).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 45).

used('sendMail', 'message', 'mail sent', 46).



wasControlledBy('updateData','user4', 'owner', 47, 49).
used('updateData','username_user4_1', 'data to update', 48).
wasGeneratedBy('username_user4_2', 'updateData', 'updated data', 49).

wasControlledBy('showRecommendation','DC', 'owner', 50, 59).
used('showRecommendation','id_user4_1', 'user id', 51).
used('showRecommendation','birthday_user4_1', 'user birth day', 52).
used('showRecommendation','friends_user4_1', 'user friends', 53).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 54, 58).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 55).
used('sendAnalysisCookie','id_user4_1', 'user id', 56).
used('sendAnalysisCookie', 'birthday_user4_1', 'extra data', 57).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 58).


used('showRecommendation','wall_user4_1', 'user wall', 59).



wasControlledBy('updateData','user4', 'owner', 60, 62).
used('updateData','name_user4_1', 'data to update', 61).
wasGeneratedBy('name_user4_2', 'updateData', 'updated data', 62).

wasControlledBy('joinGroup','user4','owner',63,64).
used('joinGroup','id_user4_1', 'join group', 64).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 65, 68).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 66).
used('sendThirdPartiesCookie','id_user4_1', 'user id', 67).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 68).




wasControlledBy('updateData','user4', 'owner', 69, 71).
used('updateData','username_user4_2', 'data to update', 70).
wasGeneratedBy('username_user4_3', 'updateData', 'updated data', 71).

wasControlledBy('joinGroup','user4','owner',72,73).
used('joinGroup','id_user4_1', 'join group', 73).

wasControlledBy('createAccount','user5','owner',1,8).
wasGeneratedBy('birthday_user5_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user5_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user5_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user5_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user5_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user5_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user5_1', 'createAccount', 'personal data', 8 ).


wasControlledBy('consent','user5','owner', 9, 10).

wasGeneratedBy('consent_user5_1','consent', 'consent', 10).

purposes('consent_user5_1','birthday_user5_1',['showRecommendation']).
purposes(_,'mail_user5_1',['sendMail','sendTicket']).
purposes(_,'name_user5_1',[]).
purposes('consent_user5_1','id_user5_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user5_1','wall_user5_1',['post','showRecommendation']).
purposes('consent_user5_1','friends_user5_1',['post','showRecommendation']).
purposes(_,'username_user5_1',['post']).



used('revokeConsent','consent_user5_1','revokeConsent', 11).
wasControlledBy('sendTicket','user5', 'owner', 12, 15).

used('sendTicket','mail_user5_1', 'ticket sender mail', 13).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 14).
used('sendTicket', 'ticket', 'ticket sent', 15).



wasControlledBy('sendTicket','DC', 'owner', 51126, 51129).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 51127).
used('sendTicket','mail_user5_1', 'ticket reply sent', 51128).
used('sendTicket','ticketReply', 'ticket reply sent', 51129).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 39315, 39318).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 39316).
used('sendAnalysisCookie','id_user5_1', 'user id', 39317).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 39318).

wasControlledBy('sendImprovementCookie','DC', 'owner', 123201, 123204).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 123202).
used('sendImprovementCookie','id_user5_1', 'user id', 123203).

used('sendImprovementCookie','improvement_cookie', 'cookie', 123204).

wasControlledBy('sendTicket','user5', 'owner', 123205, 123206).
used('sendTicket', 'ticketReply', 'ticket reply received', 123206).

wasControlledBy('updateConsent','user5', 'owner', 16, 18).
used('updateConsent', 'consent_user5_1', 'consent', 17).
wasGeneratedBy('consent_user5_2', 'updateConsent', 'consent', 18).


purposes('consent_user5_2','birthday_user5_1',['showRecommendation']).
purposes('consent_user5_2','id_user5_1',['sendAnalysisCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user5_2','wall_user5_1',['post','showRecommendation']).
purposes('consent_user5_2','friends_user5_1',['post','showRecommendation']).


wasControlledBy('joinGroup','user5','owner',19,20).
used('joinGroup','id_user5_1', 'join group', 20).


wasControlledBy('showRecommendation','DC', 'owner', 21, 30).
used('showRecommendation','id_user5_1', 'user id', 22).
used('showRecommendation','birthday_user5_1', 'user birth day', 23).
used('showRecommendation','friends_user5_1', 'user friends', 24).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 25, 29).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 26).
used('sendPersonalizationCookie','id_user5_1', 'user id', 27).
used('sendPersonalizationCookie', 'name_user5_1', 'extra data', 28).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 29).

used('showRecommendation','wall_user5_1', 'user wall', 30).



wasControlledBy('updateData','user5', 'owner', 31, 33).
used('updateData','username_user5_1', 'data to update', 32).
wasGeneratedBy('username_user5_2', 'updateData', 'updated data', 33).

wasControlledBy('joinGroup','user5','owner',34,35).
used('joinGroup','id_user5_1', 'join group', 35).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 36, 39).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 37).
used('sendAnalysisCookie','id_user5_1', 'user id', 38).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 39).
wasControlledBy('askDataAccess','user5','owner', 40, 45).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 41, 44).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 42).
used('sendAnalysisCookie','id_user5_1', 'user id', 43).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 44).

wasGeneratedBy('data_request_user5', 'askDataAccess', 'request', 45).

wasControlledBy('sendData','DC', 'owner', 71272, 71274).
used('sendData', 'data_request_user5', 'request received', 71273).
wasGeneratedBy('data_report_user5','sendData', 'data response', 71274).

wasControlledBy('sendData','user5', 'receiver', 71275, 71276).
used('sendData', 'data_report_user5', 'request response received', 71276).
wasControlledBy('sendMail','DC', 'owner', 46, 49).
wasGeneratedBy('message','sendMail', 'mail to send', 47).
used('sendMail','mail_user5_1', 'address to send to', 48).

used('sendMail', 'message', 'mail sent', 49).
wasControlledBy('joinGroup','user5','owner',50,51).
used('joinGroup','id_user5_1', 'join group', 51).

wasControlledBy('createAccount','user6','owner',1,8).
wasGeneratedBy('birthday_user6_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user6_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user6_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user6_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user6_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user6_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user6_1', 'createAccount', 'personal data', 8 ).



wasControlledBy('askDataAccess','user6','owner', 9, 20).
wasControlledBy('sendImprovementCookie','DC', 'owner', 10, 14).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 11).
used('sendImprovementCookie','id_user6_1', 'user id', 12).
used('sendImprovementCookie', 'birthday_user6_1', 'extra data', 13).

used('sendImprovementCookie','improvement_cookie', 'cookie', 14).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 15, 19).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 16).
used('sendAnalysisCookie','id_user6_1', 'user id', 17).
used('sendAnalysisCookie', 'friends_user6_1', 'extra data', 18).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 19).

wasGeneratedBy('data_request_user6', 'askDataAccess', 'request', 20).

wasControlledBy('sendData','DC', 'owner', 74581, 74583).
used('sendData', 'data_request_user6', 'request received', 74582).
wasGeneratedBy('data_report_user6','sendData', 'data response', 74583).

wasControlledBy('sendData','user6', 'receiver', 74584, 74585).
used('sendData', 'data_report_user6', 'request response received', 74585).



wasControlledBy('updateData','user6', 'owner', 21, 23).
used('updateData','name_user6_1', 'data to update', 22).
wasGeneratedBy('name_user6_2', 'updateData', 'updated data', 23).

wasControlledBy('showRecommendation','DC', 'owner', 24, 33).
used('showRecommendation','id_user6_1', 'user id', 25).
used('showRecommendation','birthday_user6_1', 'user birth day', 26).
used('showRecommendation','friends_user6_1', 'user friends', 27).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 28, 32).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 29).
used('sendAnalysisCookie','id_user6_1', 'user id', 30).
used('sendAnalysisCookie', 'friends_user6_1', 'extra data', 31).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 32).


used('showRecommendation','wall_user6_1', 'user wall', 33).
wasControlledBy('joinGroup','user6','owner',34,35).
used('joinGroup','id_user6_1', 'join group', 35).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 36, 40).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 37).
used('sendThirdPartiesCookie','id_user6_1', 'user id', 38).
used('sendThirdPartiesCookie', 'mail_user6_1', 'extra data', 39).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 40).

wasControlledBy('sendTicket','user6', 'owner', 41, 44).

used('sendTicket','mail_user6_1', 'ticket sender mail', 42).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 43).
used('sendTicket', 'ticket', 'ticket sent', 44).


wasControlledBy('consent','user6','owner', 45, 46).

wasGeneratedBy('consent_user6_1','consent', 'consent', 46).

purposes('consent_user6_1','birthday_user6_1',['showRecommendation']).
purposes(_,'mail_user6_1',['sendMail','sendTicket']).
purposes(_,'name_user6_2',[]).
purposes('consent_user6_1','id_user6_1',['sendAnalysisCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user6_1','wall_user6_1',['post','showRecommendation']).
purposes('consent_user6_1','friends_user6_1',['post','showRecommendation']).
purposes(_,'username_user6_1',['post']).


used('revokeConsent','consent_user6_1','revokeConsent', 47).

wasControlledBy('updateConsent','user6', 'owner', 48, 50).
used('updateConsent', 'consent_user6_1', 'consent', 49).
wasGeneratedBy('consent_user6_2', 'updateConsent', 'consent', 50).


purposes('consent_user6_2','birthday_user6_1',[]).
purposes('consent_user6_2','id_user6_1',['sendAnalysisCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user6_2','wall_user6_1',['post','showRecommendation']).
purposes('consent_user6_2','friends_user6_1',['post']).





wasControlledBy('updateData','user6', 'owner', 51, 53).
used('updateData','birthday_user6_1', 'data to update', 52).
wasGeneratedBy('birthday_user6_2', 'updateData', 'updated data', 53).

wasControlledBy('joinGroup','user6','owner',54,55).
used('joinGroup','id_user6_1', 'join group', 55).



wasControlledBy('sendTicket','DC', 'owner', 22613, 22616).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 22614).
used('sendTicket','mail_user6_1', 'ticket reply sent', 22615).
used('sendTicket','ticketReply', 'ticket reply sent', 22616).

wasControlledBy('sendImprovementCookie','DC', 'owner', 61465, 61468).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 61466).
used('sendImprovementCookie','id_user6_1', 'user id', 61467).

used('sendImprovementCookie','improvement_cookie', 'cookie', 61468).

wasControlledBy('sendTicket','user6', 'owner', 61469, 61470).
used('sendTicket', 'ticketReply', 'ticket reply received', 61470).



wasControlledBy('updateData','user6', 'owner', 56, 58).
used('updateData','username_user6_1', 'data to update', 57).
wasGeneratedBy('username_user6_2', 'updateData', 'updated data', 58).


wasControlledBy('updateConsent','user6', 'owner', 59, 61).
used('updateConsent', 'consent_user6_2', 'consent', 60).
wasGeneratedBy('consent_user6_3', 'updateConsent', 'consent', 61).


purposes('consent_user6_3','birthday_user6_2',['showRecommendation']).
purposes('consent_user6_3','id_user6_1',['sendAnalysisCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user6_3','wall_user6_1',['post','showRecommendation']).
purposes('consent_user6_3','friends_user6_1',['post']).


wasControlledBy('joinGroup','user6','owner',62,63).
used('joinGroup','id_user6_1', 'join group', 63).





wasControlledBy('updateData','user6', 'owner', 64, 66).
used('updateData','birthday_user6_2', 'data to update', 65).
wasGeneratedBy('birthday_user6_3', 'updateData', 'updated data', 66).


wasControlledBy('updateConsent','user6', 'owner', 67, 69).
used('updateConsent', 'consent_user6_3', 'consent', 68).
wasGeneratedBy('consent_user6_4', 'updateConsent', 'consent', 69).


purposes('consent_user6_4','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_4','id_user6_1',['sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user6_4','wall_user6_1',['post']).
purposes('consent_user6_4','friends_user6_1',['post']).





wasControlledBy('updateData','user6', 'owner', 70, 72).
used('updateData','mail_user6_1', 'data to update', 71).
wasGeneratedBy('mail_user6_2', 'updateData', 'updated data', 72).


wasControlledBy('updateConsent','user6', 'owner', 73, 75).
used('updateConsent', 'consent_user6_4', 'consent', 74).
wasGeneratedBy('consent_user6_5', 'updateConsent', 'consent', 75).


purposes('consent_user6_5','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_5','id_user6_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user6_5','wall_user6_1',['post']).
purposes('consent_user6_5','friends_user6_1',['post']).





wasControlledBy('updateData','user6', 'owner', 76, 78).
used('updateData','name_user6_2', 'data to update', 77).
wasGeneratedBy('name_user6_3', 'updateData', 'updated data', 78).

wasControlledBy('showRecommendation','DC', 'owner', 79, 87).
used('showRecommendation','id_user6_1', 'user id', 80).
used('showRecommendation','birthday_user6_3', 'user birth day', 81).
used('showRecommendation','friends_user6_1', 'user friends', 82).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 83, 86).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 84).
used('sendAnalysisCookie','id_user6_1', 'user id', 85).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 86).


used('showRecommendation','wall_user6_1', 'user wall', 87).



wasControlledBy('updateConsent','user6', 'owner', 88, 90).
used('updateConsent', 'consent_user6_5', 'consent', 89).
wasGeneratedBy('consent_user6_6', 'updateConsent', 'consent', 90).


purposes('consent_user6_6','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_6','id_user6_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user6_6','wall_user6_1',['post']).
purposes('consent_user6_6','friends_user6_1',['post']).


wasControlledBy('post','user6', 'owner', 91, 102).
wasGeneratedBy('message', 'post', 'new post message', 92).
used('post','username_user6_2', 'username', 93).
used('post','friends_user6_1', 'user friends', 94).
used('post','wall_user6_1', 'user wall', 95).
used('post', 'wall_user6_1', 'extra data', 96).

used('post','message', 'user message', 97).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 98, 101).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 99).
used('sendAnalysisCookie','id_user6_1', 'user id', 100).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 101).


wasGeneratedBy('newPost', 'post', 'new user post', 102).


wasControlledBy('updateConsent','user6', 'owner', 103, 105).
used('updateConsent', 'consent_user6_6', 'consent', 104).
wasGeneratedBy('consent_user6_7', 'updateConsent', 'consent', 105).


purposes('consent_user6_7','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_7','id_user6_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user6_7','wall_user6_1',['post']).
purposes('consent_user6_7','friends_user6_1',['post','showRecommendation']).


wasControlledBy('post','user6', 'owner', 106, 117).
wasGeneratedBy('message', 'post', 'new post message', 107).
used('post','username_user6_2', 'username', 108).
used('post','friends_user6_1', 'user friends', 109).
used('post','wall_user6_1', 'user wall', 110).
used('post', 'id_user6_1', 'extra data', 111).

used('post','message', 'user message', 112).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 113, 116).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 114).
used('sendAnalysisCookie','id_user6_1', 'user id', 115).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 116).


wasGeneratedBy('newPost', 'post', 'new user post', 117).


wasControlledBy('updateConsent','user6', 'owner', 118, 120).
used('updateConsent', 'consent_user6_7', 'consent', 119).
wasGeneratedBy('consent_user6_8', 'updateConsent', 'consent', 120).


purposes('consent_user6_8','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_8','id_user6_1',['sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user6_8','wall_user6_1',['post']).
purposes('consent_user6_8','friends_user6_1',['post','showRecommendation']).





wasControlledBy('updateData','user6', 'owner', 121, 123).
used('updateData','username_user6_2', 'data to update', 122).
wasGeneratedBy('username_user6_3', 'updateData', 'updated data', 123).

wasControlledBy('showRecommendation','DC', 'owner', 124, 128).
used('showRecommendation','id_user6_1', 'user id', 125).
used('showRecommendation','birthday_user6_3', 'user birth day', 126).
used('showRecommendation','friends_user6_1', 'user friends', 127).


used('showRecommendation','wall_user6_1', 'user wall', 128).




wasControlledBy('updateData','user6', 'owner', 129, 131).
used('updateData','name_user6_3', 'data to update', 130).
wasGeneratedBy('name_user6_4', 'updateData', 'updated data', 131).

wasControlledBy('joinGroup','user6','owner',132,133).
used('joinGroup','id_user6_1', 'join group', 133).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 134, 137).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 135).
used('sendThirdPartiesCookie','id_user6_1', 'user id', 136).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 137).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 138, 141).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 139).
used('sendAnalysisCookie','id_user6_1', 'user id', 140).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 141).



wasControlledBy('updateData','user6', 'owner', 142, 144).
used('updateData','name_user6_4', 'data to update', 143).
wasGeneratedBy('name_user6_5', 'updateData', 'updated data', 144).


wasControlledBy('updateConsent','user6', 'owner', 145, 147).
used('updateConsent', 'consent_user6_8', 'consent', 146).
wasGeneratedBy('consent_user6_9', 'updateConsent', 'consent', 147).


purposes('consent_user6_9','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_9','id_user6_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user6_9','wall_user6_1',['post','showRecommendation']).
purposes('consent_user6_9','friends_user6_1',['post','showRecommendation']).





wasControlledBy('updateData','user6', 'owner', 148, 150).
used('updateData','name_user6_5', 'data to update', 149).
wasGeneratedBy('name_user6_6', 'updateData', 'updated data', 150).


wasControlledBy('updateConsent','user6', 'owner', 151, 153).
used('updateConsent', 'consent_user6_9', 'consent', 152).
wasGeneratedBy('consent_user6_10', 'updateConsent', 'consent', 153).


purposes('consent_user6_10','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_10','id_user6_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user6_10','wall_user6_1',['post','showRecommendation']).
purposes('consent_user6_10','friends_user6_1',['post']).





wasControlledBy('updateData','user6', 'owner', 154, 156).
used('updateData','name_user6_6', 'data to update', 155).
wasGeneratedBy('name_user6_7', 'updateData', 'updated data', 156).


wasControlledBy('updateConsent','user6', 'owner', 157, 159).
used('updateConsent', 'consent_user6_10', 'consent', 158).
wasGeneratedBy('consent_user6_11', 'updateConsent', 'consent', 159).


purposes('consent_user6_11','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_11','id_user6_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user6_11','wall_user6_1',['post']).
purposes('consent_user6_11','friends_user6_1',['post']).





wasControlledBy('updateData','user6', 'owner', 160, 162).
used('updateData','name_user6_7', 'data to update', 161).
wasGeneratedBy('name_user6_8', 'updateData', 'updated data', 162).


wasControlledBy('updateConsent','user6', 'owner', 163, 165).
used('updateConsent', 'consent_user6_11', 'consent', 164).
wasGeneratedBy('consent_user6_12', 'updateConsent', 'consent', 165).


purposes('consent_user6_12','birthday_user6_3',['showRecommendation']).
purposes('consent_user6_12','id_user6_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user6_12','wall_user6_1',['post','showRecommendation']).
purposes('consent_user6_12','friends_user6_1',['post','showRecommendation']).


wasControlledBy('post','user6', 'owner', 166, 177).
wasGeneratedBy('message', 'post', 'new post message', 167).
used('post','username_user6_3', 'username', 168).
used('post','friends_user6_1', 'user friends', 169).
used('post','wall_user6_1', 'user wall', 170).
used('post', 'birthday_user6_3', 'extra data', 171).

used('post','message', 'user message', 172).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 173, 176).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 174).
used('sendAnalysisCookie','id_user6_1', 'user id', 175).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 176).


wasGeneratedBy('newPost', 'post', 'new user post', 177).




wasControlledBy('sendMail','DC', 'owner', 178, 181).
wasGeneratedBy('message','sendMail', 'mail to send', 179).
used('sendMail','mail_user6_2', 'address to send to', 180).

used('sendMail', 'message', 'mail sent', 181).



wasControlledBy('updateData','user6', 'owner', 182, 184).
used('updateData','wall_user6_1', 'data to update', 183).
wasGeneratedBy('wall_user6_2', 'updateData', 'updated data', 184).

wasControlledBy('post','user6', 'owner', 185, 197).
wasGeneratedBy('message', 'post', 'new post message', 186).
used('post','username_user6_3', 'username', 187).
used('post','friends_user6_1', 'user friends', 188).
used('post','wall_user6_2', 'user wall', 189).
used('post', 'birthday_user6_3', 'extra data', 190).

used('post','message', 'user message', 191).

wasControlledBy('sendImprovementCookie','DC', 'owner', 192, 196).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 193).
used('sendImprovementCookie','id_user6_1', 'user id', 194).
used('sendImprovementCookie', 'wall_user6_2', 'extra data', 195).

used('sendImprovementCookie','improvement_cookie', 'cookie', 196).

wasGeneratedBy('newPost', 'post', 'new user post', 197).
wasControlledBy('createAccount','user7','owner',1,8).
wasGeneratedBy('birthday_user7_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user7_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user7_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user7_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user7_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user7_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user7_1', 'createAccount', 'personal data', 8 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 13).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user7_1', 'user id', 11).
used('sendAnalysisCookie', 'username_user7_1', 'extra data', 12).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 13).

wasControlledBy('consent','user7','owner', 14, 15).

wasGeneratedBy('consent_user7_1','consent', 'consent', 15).

purposes('consent_user7_1','birthday_user7_1',['showRecommendation']).
purposes(_,'mail_user7_1',['sendMail','sendTicket']).
purposes(_,'name_user7_1',[]).
purposes('consent_user7_1','id_user7_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user7_1','wall_user7_1',['post','showRecommendation']).
purposes('consent_user7_1','friends_user7_1',['post','showRecommendation']).
purposes(_,'username_user7_1',['post']).


wasControlledBy('sendTicket','user7', 'owner', 16, 20).
used('sendTicket', 'mail_user7_1', 'extra data', 17).

used('sendTicket','mail_user7_1', 'ticket sender mail', 18).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 19).
used('sendTicket', 'ticket', 'ticket sent', 20).



wasControlledBy('sendTicket','DC', 'owner', 53979, 53982).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 53980).
used('sendTicket','mail_user7_1', 'ticket reply sent', 53981).
used('sendTicket','ticketReply', 'ticket reply sent', 53982).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 91886, 91890).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 91887).
used('sendAnalysisCookie','id_user7_1', 'user id', 91888).
used('sendAnalysisCookie', 'mail_user7_1', 'extra data', 91889).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 91890).


wasControlledBy('sendTicket','user7', 'owner', 91891, 91892).
used('sendTicket', 'ticketReply', 'ticket reply received', 91892).

wasControlledBy('updateConsent','user7', 'owner', 21, 23).
used('updateConsent', 'consent_user7_1', 'consent', 22).
wasGeneratedBy('consent_user7_2', 'updateConsent', 'consent', 23).


purposes('consent_user7_2','birthday_user7_1',['showRecommendation']).
purposes('consent_user7_2','id_user7_1',['sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user7_2','wall_user7_1',['post','showRecommendation']).
purposes('consent_user7_2','friends_user7_1',['post','showRecommendation']).


wasControlledBy('post','user7', 'owner', 24, 35).
wasGeneratedBy('message', 'post', 'new post message', 25).
used('post','username_user7_1', 'username', 26).
used('post','friends_user7_1', 'user friends', 27).
used('post','wall_user7_1', 'user wall', 28).
used('post', 'id_user7_1', 'extra data', 29).

used('post','message', 'user message', 30).

wasControlledBy('sendImprovementCookie','DC', 'owner', 31, 34).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 32).
used('sendImprovementCookie','id_user7_1', 'user id', 33).

used('sendImprovementCookie','improvement_cookie', 'cookie', 34).

wasGeneratedBy('newPost', 'post', 'new user post', 35).

wasControlledBy('sendMail','DC', 'owner', 36, 39).
wasGeneratedBy('message','sendMail', 'mail to send', 37).
used('sendMail','mail_user7_1', 'address to send to', 38).

used('sendMail', 'message', 'mail sent', 39).

used('revokeConsent','consent_user7_2','revokeConsent', 40).



wasControlledBy('updateData','user7', 'owner', 41, 43).
used('updateData','mail_user7_1', 'data to update', 42).
wasGeneratedBy('mail_user7_2', 'updateData', 'updated data', 43).


wasControlledBy('updateConsent','user7', 'owner', 44, 46).
used('updateConsent', 'consent_user7_2', 'consent', 45).
wasGeneratedBy('consent_user7_3', 'updateConsent', 'consent', 46).


purposes('consent_user7_3','birthday_user7_1',[]).
purposes('consent_user7_3','id_user7_1',['joinGroup','sendPersonalizationCookie']).
purposes('consent_user7_3','wall_user7_1',['post','showRecommendation']).
purposes('consent_user7_3','friends_user7_1',['post','showRecommendation']).


wasControlledBy('post','user7', 'owner', 47, 63).
wasGeneratedBy('message', 'post', 'new post message', 48).
used('post','username_user7_1', 'username', 49).
used('post','friends_user7_1', 'user friends', 50).
used('post','wall_user7_1', 'user wall', 51).

used('post','message', 'user message', 52).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 53, 57).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 54).
used('sendAnalysisCookie','id_user7_1', 'user id', 55).
used('sendAnalysisCookie', 'birthday_user7_1', 'extra data', 56).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 57).

wasControlledBy('sendImprovementCookie','DC', 'owner', 58, 62).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 59).
used('sendImprovementCookie','id_user7_1', 'user id', 60).
used('sendImprovementCookie', 'name_user7_1', 'extra data', 61).

used('sendImprovementCookie','improvement_cookie', 'cookie', 62).

wasGeneratedBy('newPost', 'post', 'new user post', 63).

wasControlledBy('post','user7', 'owner', 64, 70).
wasGeneratedBy('message', 'post', 'new post message', 65).
used('post','username_user7_1', 'username', 66).
used('post','friends_user7_1', 'user friends', 67).
used('post','wall_user7_1', 'user wall', 68).

used('post','message', 'user message', 69).


wasGeneratedBy('newPost', 'post', 'new user post', 70).
wasControlledBy('askDataAccess','user7','owner', 71, 76).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 72, 75).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 73).
used('sendAnalysisCookie','id_user7_1', 'user id', 74).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 75).

wasGeneratedBy('data_request_user7', 'askDataAccess', 'request', 76).

wasControlledBy('sendData','DC', 'owner', 23087, 23089).
used('sendData', 'data_request_user7', 'request received', 23088).
wasGeneratedBy('data_report_user7','sendData', 'data response', 23089).

wasControlledBy('sendData','user7', 'receiver', 23090, 23091).
used('sendData', 'data_report_user7', 'request response received', 23091).



wasControlledBy('updateData','user7', 'owner', 77, 79).
used('updateData','username_user7_1', 'data to update', 78).
wasGeneratedBy('username_user7_2', 'updateData', 'updated data', 79).

wasControlledBy('joinGroup','user7','owner',80,81).
used('joinGroup','id_user7_1', 'join group', 81).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 82, 85).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 83).
used('sendThirdPartiesCookie','id_user7_1', 'user id', 84).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 85).

wasControlledBy('joinGroup','user7','owner',86,87).
used('joinGroup','id_user7_1', 'join group', 87).

wasControlledBy('showRecommendation','DC', 'owner', 88, 97).
used('showRecommendation','id_user7_1', 'user id', 89).
used('showRecommendation','birthday_user7_1', 'user birth day', 90).
used('showRecommendation','friends_user7_1', 'user friends', 91).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 92, 96).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 93).
used('sendPersonalizationCookie','id_user7_1', 'user id', 94).
used('sendPersonalizationCookie', 'id_user7_1', 'extra data', 95).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 96).

used('showRecommendation','wall_user7_1', 'user wall', 97).
wasControlledBy('createAccount','user8','owner',1,8).
wasGeneratedBy('birthday_user8_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user8_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user8_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user8_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user8_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user8_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user8_1', 'createAccount', 'personal data', 8 ).






wasControlledBy('updateData','user8', 'owner', 9, 11).
used('updateData','birthday_user8_1', 'data to update', 10).
wasGeneratedBy('birthday_user8_2', 'updateData', 'updated data', 11).

wasControlledBy('joinGroup','user8','owner',12,13).
used('joinGroup','id_user8_1', 'join group', 13).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 14, 17).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 15).
used('sendAnalysisCookie','id_user8_1', 'user id', 16).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 17).
wasControlledBy('sendMail','DC', 'owner', 18, 21).
wasGeneratedBy('message','sendMail', 'mail to send', 19).
used('sendMail','mail_user8_1', 'address to send to', 20).

used('sendMail', 'message', 'mail sent', 21).
wasControlledBy('consent','user8','owner', 22, 28).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 23, 27).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 24).
used('sendAnalysisCookie','id_user8_1', 'user id', 25).
used('sendAnalysisCookie', 'mail_user8_1', 'extra data', 26).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 27).

wasGeneratedBy('consent_user8_1','consent', 'consent', 28).

purposes('consent_user8_1','birthday_user8_2',[]).
purposes(_,'mail_user8_1',['sendMail','sendTicket']).
purposes(_,'name_user8_1',[]).
purposes('consent_user8_1','id_user8_1',['joinGroup','sendPersonalizationCookie']).
purposes('consent_user8_1','wall_user8_1',['post','showRecommendation']).
purposes('consent_user8_1','friends_user8_1',['post','showRecommendation']).
purposes(_,'username_user8_1',['post']).


wasControlledBy('updateConsent','user8', 'owner', 29, 31).
used('updateConsent', 'consent_user8_1', 'consent', 30).
wasGeneratedBy('consent_user8_2', 'updateConsent', 'consent', 31).


purposes('consent_user8_2','birthday_user8_2',[]).
purposes('consent_user8_2','id_user8_1',['joinGroup','sendPersonalizationCookie']).
purposes('consent_user8_2','wall_user8_1',['post','showRecommendation']).
purposes('consent_user8_2','friends_user8_1',['post','showRecommendation']).


wasControlledBy('showRecommendation','DC', 'owner', 32, 44).
used('showRecommendation','id_user8_1', 'user id', 33).
used('showRecommendation','birthday_user8_2', 'user birth day', 34).
used('showRecommendation','friends_user8_1', 'user friends', 35).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 36, 39).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 37).
used('sendAnalysisCookie','id_user8_1', 'user id', 38).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 39).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 40, 43).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 41).
used('sendPersonalizationCookie','id_user8_1', 'user id', 42).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 43).

used('showRecommendation','wall_user8_1', 'user wall', 44).

wasControlledBy('askDataAccess','user8','owner', 45, 55).
wasControlledBy('sendImprovementCookie','DC', 'owner', 46, 49).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 47).
used('sendImprovementCookie','id_user8_1', 'user id', 48).

used('sendImprovementCookie','improvement_cookie', 'cookie', 49).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 50, 54).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 51).
used('sendAnalysisCookie','id_user8_1', 'user id', 52).
used('sendAnalysisCookie', 'username_user8_1', 'extra data', 53).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 54).

wasGeneratedBy('data_request_user8', 'askDataAccess', 'request', 55).

wasControlledBy('sendData','DC', 'owner', 103721, 103723).
used('sendData', 'data_request_user8', 'request received', 103722).
wasGeneratedBy('data_report_user8','sendData', 'data response', 103723).

wasControlledBy('sendData','user8', 'receiver', 103724, 103725).
used('sendData', 'data_report_user8', 'request response received', 103725).

used('revokeConsent','consent_user8_2','revokeConsent', 56).
wasControlledBy('sendTicket','user8', 'owner', 57, 60).

used('sendTicket','mail_user8_1', 'ticket sender mail', 58).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 59).
used('sendTicket', 'ticket', 'ticket sent', 60).



wasControlledBy('sendTicket','DC', 'owner', 89644, 89647).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 89645).
used('sendTicket','mail_user8_1', 'ticket reply sent', 89646).
used('sendTicket','ticketReply', 'ticket reply sent', 89647).

wasControlledBy('sendImprovementCookie','DC', 'owner', 35669, 35672).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 35670).
used('sendImprovementCookie','id_user8_1', 'user id', 35671).

used('sendImprovementCookie','improvement_cookie', 'cookie', 35672).

wasControlledBy('sendTicket','user8', 'owner', 35673, 35674).
used('sendTicket', 'ticketReply', 'ticket reply received', 35674).



wasControlledBy('updateData','user8', 'owner', 61, 63).
used('updateData','name_user8_1', 'data to update', 62).
wasGeneratedBy('name_user8_2', 'updateData', 'updated data', 63).

wasControlledBy('showRecommendation','DC', 'owner', 64, 72).
used('showRecommendation','id_user8_1', 'user id', 65).
used('showRecommendation','birthday_user8_2', 'user birth day', 66).
used('showRecommendation','friends_user8_1', 'user friends', 67).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 68, 71).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 69).
used('sendPersonalizationCookie','id_user8_1', 'user id', 70).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 71).

used('showRecommendation','wall_user8_1', 'user wall', 72).
wasControlledBy('post','user8', 'owner', 73, 84).
wasGeneratedBy('message', 'post', 'new post message', 74).
used('post','username_user8_1', 'username', 75).
used('post','friends_user8_1', 'user friends', 76).
used('post','wall_user8_1', 'user wall', 77).
used('post', 'mail_user8_1', 'extra data', 78).

used('post','message', 'user message', 79).

wasControlledBy('sendImprovementCookie','DC', 'owner', 80, 83).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 81).
used('sendImprovementCookie','id_user8_1', 'user id', 82).

used('sendImprovementCookie','improvement_cookie', 'cookie', 83).

wasGeneratedBy('newPost', 'post', 'new user post', 84).
wasControlledBy('createAccount','user9','owner',1,8).
wasGeneratedBy('birthday_user9_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user9_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user9_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user9_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user9_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user9_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user9_1', 'createAccount', 'personal data', 8 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 13).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user9_1', 'user id', 11).
used('sendAnalysisCookie', 'mail_user9_1', 'extra data', 12).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 13).


wasControlledBy('askDataAccess','user9','owner', 14, 20).
wasControlledBy('sendImprovementCookie','DC', 'owner', 15, 19).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 16).
used('sendImprovementCookie','id_user9_1', 'user id', 17).
used('sendImprovementCookie', 'id_user9_1', 'extra data', 18).

used('sendImprovementCookie','improvement_cookie', 'cookie', 19).


wasGeneratedBy('data_request_user9', 'askDataAccess', 'request', 20).
wasControlledBy('sendTicket','user9', 'owner', 21, 24).

used('sendTicket','mail_user9_1', 'ticket sender mail', 22).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 23).
used('sendTicket', 'ticket', 'ticket sent', 24).



wasControlledBy('sendTicket','DC', 'owner', 98866, 98869).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 98867).
used('sendTicket','mail_user9_1', 'ticket reply sent', 98868).
used('sendTicket','ticketReply', 'ticket reply sent', 98869).


wasControlledBy('sendTicket','user9', 'owner', 98870, 98871).
used('sendTicket', 'ticketReply', 'ticket reply received', 98871).
wasControlledBy('consent','user9','owner', 25, 31).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 26, 30).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 27).
used('sendAnalysisCookie','id_user9_1', 'user id', 28).
used('sendAnalysisCookie', 'mail_user9_1', 'extra data', 29).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 30).

wasGeneratedBy('consent_user9_1','consent', 'consent', 31).

purposes('consent_user9_1','birthday_user9_1',[]).
purposes(_,'mail_user9_1',['sendMail','sendTicket']).
purposes(_,'name_user9_1',[]).
purposes('consent_user9_1','id_user9_1',['joinGroup','sendPersonalizationCookie']).
purposes('consent_user9_1','wall_user9_1',['post','showRecommendation']).
purposes('consent_user9_1','friends_user9_1',['post','showRecommendation']).
purposes(_,'username_user9_1',['post']).




wasControlledBy('updateData','user9', 'owner', 32, 34).
used('updateData','username_user9_1', 'data to update', 33).
wasGeneratedBy('username_user9_2', 'updateData', 'updated data', 34).


wasControlledBy('updateConsent','user9', 'owner', 35, 37).
used('updateConsent', 'consent_user9_1', 'consent', 36).
wasGeneratedBy('consent_user9_2', 'updateConsent', 'consent', 37).


purposes('consent_user9_2','birthday_user9_1',[]).
purposes('consent_user9_2','id_user9_1',['joinGroup']).
purposes('consent_user9_2','wall_user9_1',['post','showRecommendation']).
purposes('consent_user9_2','friends_user9_1',['post']).





wasControlledBy('updateData','user9', 'owner', 38, 40).
used('updateData','name_user9_1', 'data to update', 39).
wasGeneratedBy('name_user9_2', 'updateData', 'updated data', 40).


wasControlledBy('updateConsent','user9', 'owner', 41, 43).
used('updateConsent', 'consent_user9_2', 'consent', 42).
wasGeneratedBy('consent_user9_3', 'updateConsent', 'consent', 43).


purposes('consent_user9_3','birthday_user9_1',['showRecommendation']).
purposes('consent_user9_3','id_user9_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user9_3','wall_user9_1',['post','showRecommendation']).
purposes('consent_user9_3','friends_user9_1',['post']).


wasControlledBy('showRecommendation','DC', 'owner', 44, 58).
used('showRecommendation','id_user9_1', 'user id', 45).
used('showRecommendation','birthday_user9_1', 'user birth day', 46).
used('showRecommendation','friends_user9_1', 'user friends', 47).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 48, 52).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 49).
used('sendAnalysisCookie','id_user9_1', 'user id', 50).
used('sendAnalysisCookie', 'birthday_user9_1', 'extra data', 51).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 52).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 53, 57).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 54).
used('sendPersonalizationCookie','id_user9_1', 'user id', 55).
used('sendPersonalizationCookie', 'username_user9_2', 'extra data', 56).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 57).

used('showRecommendation','wall_user9_1', 'user wall', 58).



wasControlledBy('sendData','DC', 'owner', 65152, 65154).
used('sendData', 'data_request_user9', 'request received', 65153).
wasGeneratedBy('data_report_user9','sendData', 'data response', 65154).

wasControlledBy('sendData','user9', 'receiver', 65155, 65156).
used('sendData', 'data_report_user9', 'request response received', 65156).
wasControlledBy('sendMail','DC', 'owner', 59, 67).
wasGeneratedBy('message','sendMail', 'mail to send', 60).
used('sendMail','mail_user9_1', 'address to send to', 61).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 62, 66).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 63).
used('sendAnalysisCookie','id_user9_1', 'user id', 64).
used('sendAnalysisCookie', 'id_user9_1', 'extra data', 65).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 66).

used('sendMail', 'message', 'mail sent', 67).

used('revokeConsent','consent_user9_3','revokeConsent', 68).

wasControlledBy('updateConsent','user9', 'owner', 69, 71).
used('updateConsent', 'consent_user9_3', 'consent', 70).
wasGeneratedBy('consent_user9_4', 'updateConsent', 'consent', 71).


purposes('consent_user9_4','birthday_user9_1',['showRecommendation']).
purposes('consent_user9_4','id_user9_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user9_4','wall_user9_1',['post','showRecommendation']).
purposes('consent_user9_4','friends_user9_1',['post','showRecommendation']).





wasControlledBy('updateData','user9', 'owner', 72, 74).
used('updateData','username_user9_2', 'data to update', 73).
wasGeneratedBy('username_user9_3', 'updateData', 'updated data', 74).

wasControlledBy('joinGroup','user9','owner',75,76).
used('joinGroup','id_user9_1', 'join group', 76).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 77, 80).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 78).
used('sendThirdPartiesCookie','id_user9_1', 'user id', 79).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 80).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 81, 85).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 82).
used('sendAnalysisCookie','id_user9_1', 'user id', 83).
used('sendAnalysisCookie', 'wall_user9_1', 'extra data', 84).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 85).

wasControlledBy('showRecommendation','DC', 'owner', 86, 95).
used('showRecommendation','id_user9_1', 'user id', 87).
used('showRecommendation','birthday_user9_1', 'user birth day', 88).
used('showRecommendation','friends_user9_1', 'user friends', 89).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 90, 94).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 91).
used('sendPersonalizationCookie','id_user9_1', 'user id', 92).
used('sendPersonalizationCookie', 'name_user9_2', 'extra data', 93).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 94).

used('showRecommendation','wall_user9_1', 'user wall', 95).
wasControlledBy('createAccount','user10','owner',1,8).
wasGeneratedBy('birthday_user10_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user10_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user10_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user10_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user10_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user10_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user10_1', 'createAccount', 'personal data', 8 ).


wasControlledBy('consent','user10','owner', 9, 10).

wasGeneratedBy('consent_user10_1','consent', 'consent', 10).

purposes('consent_user10_1','birthday_user10_1',['showRecommendation']).
purposes(_,'mail_user10_1',['sendMail','sendTicket']).
purposes(_,'name_user10_1',[]).
purposes('consent_user10_1','id_user10_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user10_1','wall_user10_1',['post','showRecommendation']).
purposes('consent_user10_1','friends_user10_1',['post','showRecommendation']).
purposes(_,'username_user10_1',['post']).


wasControlledBy('sendTicket','user10', 'owner', 11, 15).
used('sendTicket', 'name_user10_1', 'extra data', 12).

used('sendTicket','mail_user10_1', 'ticket sender mail', 13).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 14).
used('sendTicket', 'ticket', 'ticket sent', 15).



wasControlledBy('sendTicket','DC', 'owner', 48809, 48812).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 48810).
used('sendTicket','mail_user10_1', 'ticket reply sent', 48811).
used('sendTicket','ticketReply', 'ticket reply sent', 48812).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 73281, 73285).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 73282).
used('sendAnalysisCookie','id_user10_1', 'user id', 73283).
used('sendAnalysisCookie', 'birthday_user10_1', 'extra data', 73284).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 73285).


wasControlledBy('sendTicket','user10', 'owner', 73286, 73287).
used('sendTicket', 'ticketReply', 'ticket reply received', 73287).



wasControlledBy('updateData','user10', 'owner', 16, 18).
used('updateData','username_user10_1', 'data to update', 17).
wasGeneratedBy('username_user10_2', 'updateData', 'updated data', 18).

wasControlledBy('post','user10', 'owner', 19, 30).
wasGeneratedBy('message', 'post', 'new post message', 20).
used('post','username_user10_2', 'username', 21).
used('post','friends_user10_1', 'user friends', 22).
used('post','wall_user10_1', 'user wall', 23).
used('post', 'birthday_user10_1', 'extra data', 24).

used('post','message', 'user message', 25).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 26, 29).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 27).
used('sendAnalysisCookie','id_user10_1', 'user id', 28).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 29).


wasGeneratedBy('newPost', 'post', 'new user post', 30).

wasControlledBy('updateConsent','user10', 'owner', 31, 33).
used('updateConsent', 'consent_user10_1', 'consent', 32).
wasGeneratedBy('consent_user10_2', 'updateConsent', 'consent', 33).


purposes('consent_user10_2','birthday_user10_1',['showRecommendation']).
purposes('consent_user10_2','id_user10_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user10_2','wall_user10_1',['post','showRecommendation']).
purposes('consent_user10_2','friends_user10_1',['post','showRecommendation']).


wasControlledBy('joinGroup','user10','owner',34,35).
used('joinGroup','id_user10_1', 'join group', 35).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 36, 40).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 37).
used('sendAnalysisCookie','id_user10_1', 'user id', 38).
used('sendAnalysisCookie', 'wall_user10_1', 'extra data', 39).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 40).

wasControlledBy('joinGroup','user10','owner',41,42).
used('joinGroup','id_user10_1', 'join group', 42).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 43, 47).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 44).
used('sendThirdPartiesCookie','id_user10_1', 'user id', 45).
used('sendThirdPartiesCookie', 'wall_user10_1', 'extra data', 46).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 47).

wasControlledBy('sendMail','DC', 'owner', 48, 55).
wasGeneratedBy('message','sendMail', 'mail to send', 49).
used('sendMail','mail_user10_1', 'address to send to', 50).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 51, 54).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 52).
used('sendAnalysisCookie','id_user10_1', 'user id', 53).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 54).

used('sendMail', 'message', 'mail sent', 55).
wasControlledBy('askDataAccess','user10','owner', 56, 57).


wasGeneratedBy('data_request_user10', 'askDataAccess', 'request', 57).

wasControlledBy('sendData','DC', 'owner', 51992, 51994).
used('sendData', 'data_request_user10', 'request received', 51993).
wasGeneratedBy('data_report_user10','sendData', 'data response', 51994).

wasControlledBy('sendData','user10', 'receiver', 51995, 51996).
used('sendData', 'data_report_user10', 'request response received', 51996).
wasControlledBy('post','user10', 'owner', 58, 65).
wasGeneratedBy('message', 'post', 'new post message', 59).
used('post','username_user10_2', 'username', 60).
used('post','friends_user10_1', 'user friends', 61).
used('post','wall_user10_1', 'user wall', 62).
used('post', 'username_user10_2', 'extra data', 63).

used('post','message', 'user message', 64).


wasGeneratedBy('newPost', 'post', 'new user post', 65).

used('revokeConsent','consent_user10_2','revokeConsent', 66).
wasControlledBy('showRecommendation','DC', 'owner', 67, 71).
used('showRecommendation','id_user10_1', 'user id', 68).
used('showRecommendation','birthday_user10_1', 'user birth day', 69).
used('showRecommendation','friends_user10_1', 'user friends', 70).


used('showRecommendation','wall_user10_1', 'user wall', 71).

wasControlledBy('updateConsent','user10', 'owner', 72, 74).
used('updateConsent', 'consent_user10_2', 'consent', 73).
wasGeneratedBy('consent_user10_3', 'updateConsent', 'consent', 74).


purposes('consent_user10_3','birthday_user10_1',['showRecommendation']).
purposes('consent_user10_3','id_user10_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user10_3','wall_user10_1',['post','showRecommendation']).
purposes('consent_user10_3','friends_user10_1',['post']).


wasControlledBy('joinGroup','user10','owner',75,76).
used('joinGroup','id_user10_1', 'join group', 76).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 77, 81).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 78).
used('sendThirdPartiesCookie','id_user10_1', 'user id', 79).
used('sendThirdPartiesCookie', 'friends_user10_1', 'extra data', 80).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 81).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 82, 85).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 83).
used('sendAnalysisCookie','id_user10_1', 'user id', 84).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 85).

wasControlledBy('joinGroup','user10','owner',86,87).
used('joinGroup','id_user10_1', 'join group', 87).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 88, 91).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 89).
used('sendThirdPartiesCookie','id_user10_1', 'user id', 90).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 91).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 92, 95).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 93).
used('sendAnalysisCookie','id_user10_1', 'user id', 94).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 95).
wasControlledBy('createAccount','user11','owner',1,8).
wasGeneratedBy('birthday_user11_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user11_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user11_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user11_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user11_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user11_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user11_1', 'createAccount', 'personal data', 8 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user11_1', 'user id', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasControlledBy('consent','user11','owner', 13, 14).

wasGeneratedBy('consent_user11_1','consent', 'consent', 14).

purposes('consent_user11_1','birthday_user11_1',['showRecommendation']).
purposes(_,'mail_user11_1',['sendMail','sendTicket']).
purposes(_,'name_user11_1',[]).
purposes('consent_user11_1','id_user11_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user11_1','wall_user11_1',['post','showRecommendation']).
purposes('consent_user11_1','friends_user11_1',['post']).
purposes(_,'username_user11_1',['post']).





wasControlledBy('updateData','user11', 'owner', 15, 17).
used('updateData','name_user11_1', 'data to update', 16).
wasGeneratedBy('name_user11_2', 'updateData', 'updated data', 17).

wasControlledBy('joinGroup','user11','owner',18,19).
used('joinGroup','id_user11_1', 'join group', 19).


used('revokeConsent','consent_user11_1','revokeConsent', 20).
wasControlledBy('joinGroup','user11','owner',21,22).
used('joinGroup','id_user11_1', 'join group', 22).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 23, 26).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 24).
used('sendThirdPartiesCookie','id_user11_1', 'user id', 25).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 26).

wasControlledBy('sendTicket','user11', 'owner', 27, 31).
used('sendTicket', 'friends_user11_1', 'extra data', 28).

used('sendTicket','mail_user11_1', 'ticket sender mail', 29).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 30).
used('sendTicket', 'ticket', 'ticket sent', 31).



wasControlledBy('sendTicket','DC', 'owner', 42309, 42312).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 42310).
used('sendTicket','mail_user11_1', 'ticket reply sent', 42311).
used('sendTicket','ticketReply', 'ticket reply sent', 42312).

wasControlledBy('sendImprovementCookie','DC', 'owner', 124000, 124004).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 124001).
used('sendImprovementCookie','id_user11_1', 'user id', 124002).
used('sendImprovementCookie', 'name_user11_2', 'extra data', 124003).

used('sendImprovementCookie','improvement_cookie', 'cookie', 124004).

wasControlledBy('sendTicket','user11', 'owner', 124005, 124006).
used('sendTicket', 'ticketReply', 'ticket reply received', 124006).
wasControlledBy('askDataAccess','user11','owner', 32, 38).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 33, 37).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 34).
used('sendAnalysisCookie','id_user11_1', 'user id', 35).
used('sendAnalysisCookie', 'mail_user11_1', 'extra data', 36).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 37).

wasGeneratedBy('data_request_user11', 'askDataAccess', 'request', 38).

wasControlledBy('updateConsent','user11', 'owner', 39, 41).
used('updateConsent', 'consent_user11_1', 'consent', 40).
wasGeneratedBy('consent_user11_2', 'updateConsent', 'consent', 41).


purposes('consent_user11_2','birthday_user11_1',['showRecommendation']).
purposes('consent_user11_2','id_user11_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user11_2','wall_user11_1',['post']).
purposes('consent_user11_2','friends_user11_1',['post','showRecommendation']).


wasControlledBy('joinGroup','user11','owner',42,43).
used('joinGroup','id_user11_1', 'join group', 43).



wasControlledBy('sendData','DC', 'owner', 105269, 105271).
used('sendData', 'data_request_user11', 'request received', 105270).
wasGeneratedBy('data_report_user11','sendData', 'data response', 105271).

wasControlledBy('sendData','user11', 'receiver', 105272, 105273).
used('sendData', 'data_report_user11', 'request response received', 105273).
wasControlledBy('sendMail','DC', 'owner', 44, 47).
wasGeneratedBy('message','sendMail', 'mail to send', 45).
used('sendMail','mail_user11_1', 'address to send to', 46).

used('sendMail', 'message', 'mail sent', 47).
wasControlledBy('createAccount','user12','owner',1,8).
wasGeneratedBy('birthday_user12_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user12_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user12_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user12_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user12_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user12_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user12_1', 'createAccount', 'personal data', 8 ).






wasControlledBy('updateData','user12', 'owner', 9, 11).
used('updateData','username_user12_1', 'data to update', 10).
wasGeneratedBy('username_user12_2', 'updateData', 'updated data', 11).

wasControlledBy('joinGroup','user12','owner',12,13).
used('joinGroup','id_user12_1', 'join group', 13).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 14, 17).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 15).
used('sendThirdPartiesCookie','id_user12_1', 'user id', 16).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 17).

wasControlledBy('consent','user12','owner', 18, 24).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 19, 23).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 20).
used('sendAnalysisCookie','id_user12_1', 'user id', 21).
used('sendAnalysisCookie', 'wall_user12_1', 'extra data', 22).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 23).

wasGeneratedBy('consent_user12_1','consent', 'consent', 24).

purposes('consent_user12_1','birthday_user12_1',['showRecommendation']).
purposes(_,'mail_user12_1',['sendMail','sendTicket']).
purposes(_,'name_user12_1',[]).
purposes('consent_user12_1','id_user12_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user12_1','wall_user12_1',['post']).
purposes('consent_user12_1','friends_user12_1',['post','showRecommendation']).
purposes(_,'username_user12_2',['post']).


wasControlledBy('updateConsent','user12', 'owner', 25, 27).
used('updateConsent', 'consent_user12_1', 'consent', 26).
wasGeneratedBy('consent_user12_2', 'updateConsent', 'consent', 27).


purposes('consent_user12_2','birthday_user12_1',['showRecommendation']).
purposes('consent_user12_2','id_user12_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user12_2','wall_user12_1',['post','showRecommendation']).
purposes('consent_user12_2','friends_user12_1',['post','showRecommendation']).





wasControlledBy('updateData','user12', 'owner', 28, 30).
used('updateData','name_user12_1', 'data to update', 29).
wasGeneratedBy('name_user12_2', 'updateData', 'updated data', 30).

wasControlledBy('post','user12', 'owner', 31, 38).
wasGeneratedBy('message', 'post', 'new post message', 32).
used('post','username_user12_2', 'username', 33).
used('post','friends_user12_1', 'user friends', 34).
used('post','wall_user12_1', 'user wall', 35).
used('post', 'wall_user12_1', 'extra data', 36).

used('post','message', 'user message', 37).


wasGeneratedBy('newPost', 'post', 'new user post', 38).

wasControlledBy('sendTicket','user12', 'owner', 39, 43).
used('sendTicket', 'birthday_user12_1', 'extra data', 40).

used('sendTicket','mail_user12_1', 'ticket sender mail', 41).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 42).
used('sendTicket', 'ticket', 'ticket sent', 43).


wasControlledBy('sendMail','DC', 'owner', 44, 51).
wasGeneratedBy('message','sendMail', 'mail to send', 45).
used('sendMail','mail_user12_1', 'address to send to', 46).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 47, 50).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 48).
used('sendAnalysisCookie','id_user12_1', 'user id', 49).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 50).

used('sendMail', 'message', 'mail sent', 51).

used('revokeConsent','consent_user12_2','revokeConsent', 52).
wasControlledBy('askDataAccess','user12','owner', 53, 59).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 54, 58).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 55).
used('sendAnalysisCookie','id_user12_1', 'user id', 56).
used('sendAnalysisCookie', 'friends_user12_1', 'extra data', 57).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 58).

wasGeneratedBy('data_request_user12', 'askDataAccess', 'request', 59).

wasControlledBy('sendTicket','DC', 'owner', 65931, 65934).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 65932).
used('sendTicket','mail_user12_1', 'ticket reply sent', 65933).
used('sendTicket','ticketReply', 'ticket reply sent', 65934).


wasControlledBy('sendTicket','user12', 'owner', 65935, 65936).
used('sendTicket', 'ticketReply', 'ticket reply received', 65936).
wasControlledBy('joinGroup','user12','owner',60,61).
used('joinGroup','id_user12_1', 'join group', 61).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 62, 66).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 63).
used('sendThirdPartiesCookie','id_user12_1', 'user id', 64).
used('sendThirdPartiesCookie', 'name_user12_2', 'extra data', 65).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 66).


wasControlledBy('sendData','DC', 'owner', 98814, 98816).
used('sendData', 'data_request_user12', 'request received', 98815).
wasGeneratedBy('data_report_user12','sendData', 'data response', 98816).

wasControlledBy('sendData','user12', 'receiver', 98817, 98818).
used('sendData', 'data_report_user12', 'request response received', 98818).
wasControlledBy('createAccount','user13','owner',1,8).
wasGeneratedBy('birthday_user13_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user13_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user13_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user13_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user13_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user13_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user13_1', 'createAccount', 'personal data', 8 ).


wasControlledBy('consent','user13','owner', 9, 10).

wasGeneratedBy('consent_user13_1','consent', 'consent', 10).

purposes('consent_user13_1','birthday_user13_1',['showRecommendation']).
purposes(_,'mail_user13_1',['sendMail','sendTicket']).
purposes(_,'name_user13_1',[]).
purposes('consent_user13_1','id_user13_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user13_1','wall_user13_1',['post','showRecommendation']).
purposes('consent_user13_1','friends_user13_1',['post','showRecommendation']).
purposes(_,'username_user13_1',['post']).





wasControlledBy('updateData','user13', 'owner', 11, 13).
used('updateData','username_user13_1', 'data to update', 12).
wasGeneratedBy('username_user13_2', 'updateData', 'updated data', 13).

wasControlledBy('showRecommendation','DC', 'owner', 14, 28).
used('showRecommendation','id_user13_1', 'user id', 15).
used('showRecommendation','birthday_user13_1', 'user birth day', 16).
used('showRecommendation','friends_user13_1', 'user friends', 17).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 18, 22).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 19).
used('sendAnalysisCookie','id_user13_1', 'user id', 20).
used('sendAnalysisCookie', 'username_user13_2', 'extra data', 21).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 22).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 23, 27).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 24).
used('sendPersonalizationCookie','id_user13_1', 'user id', 25).
used('sendPersonalizationCookie', 'id_user13_1', 'extra data', 26).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 27).

used('showRecommendation','wall_user13_1', 'user wall', 28).
wasControlledBy('sendTicket','user13', 'owner', 29, 32).

used('sendTicket','mail_user13_1', 'ticket sender mail', 30).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 31).
used('sendTicket', 'ticket', 'ticket sent', 32).



wasControlledBy('sendTicket','DC', 'owner', 62723, 62726).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 62724).
used('sendTicket','mail_user13_1', 'ticket reply sent', 62725).
used('sendTicket','ticketReply', 'ticket reply sent', 62726).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 129073, 129076).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 129074).
used('sendAnalysisCookie','id_user13_1', 'user id', 129075).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 129076).

wasControlledBy('sendImprovementCookie','DC', 'owner', 82764, 82767).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 82765).
used('sendImprovementCookie','id_user13_1', 'user id', 82766).

used('sendImprovementCookie','improvement_cookie', 'cookie', 82767).

wasControlledBy('sendTicket','user13', 'owner', 82768, 82769).
used('sendTicket', 'ticketReply', 'ticket reply received', 82769).

used('revokeConsent','consent_user13_1','revokeConsent', 33).

wasControlledBy('updateConsent','user13', 'owner', 34, 36).
used('updateConsent', 'consent_user13_1', 'consent', 35).
wasGeneratedBy('consent_user13_2', 'updateConsent', 'consent', 36).


purposes('consent_user13_2','birthday_user13_1',['showRecommendation']).
purposes('consent_user13_2','id_user13_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user13_2','wall_user13_1',['post','showRecommendation']).
purposes('consent_user13_2','friends_user13_1',['post','showRecommendation']).





wasControlledBy('updateData','user13', 'owner', 37, 39).
used('updateData','name_user13_1', 'data to update', 38).
wasGeneratedBy('name_user13_2', 'updateData', 'updated data', 39).

wasControlledBy('showRecommendation','DC', 'owner', 40, 44).
used('showRecommendation','id_user13_1', 'user id', 41).
used('showRecommendation','birthday_user13_1', 'user birth day', 42).
used('showRecommendation','friends_user13_1', 'user friends', 43).


used('showRecommendation','wall_user13_1', 'user wall', 44).

wasControlledBy('askDataAccess','user13','owner', 45, 56).
wasControlledBy('sendImprovementCookie','DC', 'owner', 46, 50).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 47).
used('sendImprovementCookie','id_user13_1', 'user id', 48).
used('sendImprovementCookie', 'birthday_user13_1', 'extra data', 49).

used('sendImprovementCookie','improvement_cookie', 'cookie', 50).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 51, 55).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 52).
used('sendAnalysisCookie','id_user13_1', 'user id', 53).
used('sendAnalysisCookie', 'id_user13_1', 'extra data', 54).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 55).

wasGeneratedBy('data_request_user13', 'askDataAccess', 'request', 56).

wasControlledBy('sendData','DC', 'owner', 25167, 25169).
used('sendData', 'data_request_user13', 'request received', 25168).
wasGeneratedBy('data_report_user13','sendData', 'data response', 25169).

wasControlledBy('sendData','user13', 'receiver', 25170, 25171).
used('sendData', 'data_report_user13', 'request response received', 25171).
wasControlledBy('sendMail','DC', 'owner', 57, 60).
wasGeneratedBy('message','sendMail', 'mail to send', 58).
used('sendMail','mail_user13_1', 'address to send to', 59).

used('sendMail', 'message', 'mail sent', 60).
wasControlledBy('showRecommendation','DC', 'owner', 61, 75).
used('showRecommendation','id_user13_1', 'user id', 62).
used('showRecommendation','birthday_user13_1', 'user birth day', 63).
used('showRecommendation','friends_user13_1', 'user friends', 64).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 65, 69).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 66).
used('sendAnalysisCookie','id_user13_1', 'user id', 67).
used('sendAnalysisCookie', 'friends_user13_1', 'extra data', 68).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 69).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 70, 74).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 71).
used('sendPersonalizationCookie','id_user13_1', 'user id', 72).
used('sendPersonalizationCookie', 'id_user13_1', 'extra data', 73).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 74).

used('showRecommendation','wall_user13_1', 'user wall', 75).



wasControlledBy('updateData','user13', 'owner', 76, 78).
used('updateData','username_user13_2', 'data to update', 77).
wasGeneratedBy('username_user13_3', 'updateData', 'updated data', 78).

wasControlledBy('showRecommendation','DC', 'owner', 79, 88).
used('showRecommendation','id_user13_1', 'user id', 80).
used('showRecommendation','birthday_user13_1', 'user birth day', 81).
used('showRecommendation','friends_user13_1', 'user friends', 82).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 83, 87).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 84).
used('sendAnalysisCookie','id_user13_1', 'user id', 85).
used('sendAnalysisCookie', 'mail_user13_1', 'extra data', 86).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 87).


used('showRecommendation','wall_user13_1', 'user wall', 88).



wasControlledBy('updateData','user13', 'owner', 89, 91).
used('updateData','name_user13_2', 'data to update', 90).
wasGeneratedBy('name_user13_3', 'updateData', 'updated data', 91).


wasControlledBy('updateConsent','user13', 'owner', 92, 94).
used('updateConsent', 'consent_user13_2', 'consent', 93).
wasGeneratedBy('consent_user13_3', 'updateConsent', 'consent', 94).


purposes('consent_user13_3','birthday_user13_1',['showRecommendation']).
purposes('consent_user13_3','id_user13_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user13_3','wall_user13_1',['post','showRecommendation']).
purposes('consent_user13_3','friends_user13_1',['post']).





wasControlledBy('updateData','user13', 'owner', 95, 97).
used('updateData','name_user13_3', 'data to update', 96).
wasGeneratedBy('name_user13_4', 'updateData', 'updated data', 97).

wasControlledBy('joinGroup','user13','owner',98,99).
used('joinGroup','id_user13_1', 'join group', 99).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 100, 104).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 101).
used('sendThirdPartiesCookie','id_user13_1', 'user id', 102).
used('sendThirdPartiesCookie', 'wall_user13_1', 'extra data', 103).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 104).





wasControlledBy('updateData','user13', 'owner', 105, 107).
used('updateData','name_user13_4', 'data to update', 106).
wasGeneratedBy('name_user13_5', 'updateData', 'updated data', 107).


wasControlledBy('updateConsent','user13', 'owner', 108, 110).
used('updateConsent', 'consent_user13_3', 'consent', 109).
wasGeneratedBy('consent_user13_4', 'updateConsent', 'consent', 110).


purposes('consent_user13_4','birthday_user13_1',['showRecommendation']).
purposes('consent_user13_4','id_user13_1',['sendAnalysisCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user13_4','wall_user13_1',['post','showRecommendation']).
purposes('consent_user13_4','friends_user13_1',['post','showRecommendation']).


wasControlledBy('showRecommendation','DC', 'owner', 111, 120).
used('showRecommendation','id_user13_1', 'user id', 112).
used('showRecommendation','birthday_user13_1', 'user birth day', 113).
used('showRecommendation','friends_user13_1', 'user friends', 114).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 115, 119).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 116).
used('sendPersonalizationCookie','id_user13_1', 'user id', 117).
used('sendPersonalizationCookie', 'friends_user13_1', 'extra data', 118).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 119).

used('showRecommendation','wall_user13_1', 'user wall', 120).

wasControlledBy('createAccount','user14','owner',1,8).
wasGeneratedBy('birthday_user14_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user14_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user14_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user14_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user14_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user14_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user14_1', 'createAccount', 'personal data', 8 ).






wasControlledBy('updateData','user14', 'owner', 9, 11).
used('updateData','name_user14_1', 'data to update', 10).
wasGeneratedBy('name_user14_2', 'updateData', 'updated data', 11).

wasControlledBy('joinGroup','user14','owner',12,13).
used('joinGroup','id_user14_1', 'join group', 13).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 14, 17).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 15).
used('sendThirdPartiesCookie','id_user14_1', 'user id', 16).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 17).

wasControlledBy('askDataAccess','user14','owner', 18, 24).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 19, 23).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 20).
used('sendAnalysisCookie','id_user14_1', 'user id', 21).
used('sendAnalysisCookie', 'birthday_user14_1', 'extra data', 22).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 23).

wasGeneratedBy('data_request_user14', 'askDataAccess', 'request', 24).
wasControlledBy('consent','user14','owner', 25, 30).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 26, 29).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 27).
used('sendAnalysisCookie','id_user14_1', 'user id', 28).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 29).

wasGeneratedBy('consent_user14_1','consent', 'consent', 30).

purposes('consent_user14_1','birthday_user14_1',['showRecommendation']).
purposes(_,'mail_user14_1',['sendMail','sendTicket']).
purposes(_,'name_user14_2',[]).
purposes('consent_user14_1','id_user14_1',['sendAnalysisCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user14_1','wall_user14_1',['post','showRecommendation']).
purposes('consent_user14_1','friends_user14_1',['post','showRecommendation']).
purposes(_,'username_user14_1',['post']).


wasControlledBy('updateConsent','user14', 'owner', 31, 33).
used('updateConsent', 'consent_user14_1', 'consent', 32).
wasGeneratedBy('consent_user14_2', 'updateConsent', 'consent', 33).


purposes('consent_user14_2','birthday_user14_1',[]).
purposes('consent_user14_2','id_user14_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user14_2','wall_user14_1',['post','showRecommendation']).
purposes('consent_user14_2','friends_user14_1',['post']).


wasControlledBy('post','user14', 'owner', 34, 50).
wasGeneratedBy('message', 'post', 'new post message', 35).
used('post','username_user14_1', 'username', 36).
used('post','friends_user14_1', 'user friends', 37).
used('post','wall_user14_1', 'user wall', 38).

used('post','message', 'user message', 39).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 40, 44).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 41).
used('sendAnalysisCookie','id_user14_1', 'user id', 42).
used('sendAnalysisCookie', 'mail_user14_1', 'extra data', 43).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 44).

wasControlledBy('sendImprovementCookie','DC', 'owner', 45, 49).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 46).
used('sendImprovementCookie','id_user14_1', 'user id', 47).
used('sendImprovementCookie', 'wall_user14_1', 'extra data', 48).

used('sendImprovementCookie','improvement_cookie', 'cookie', 49).

wasGeneratedBy('newPost', 'post', 'new user post', 50).

wasControlledBy('sendMail','DC', 'owner', 51, 58).
wasGeneratedBy('message','sendMail', 'mail to send', 52).
used('sendMail','mail_user14_1', 'address to send to', 53).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 54, 57).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 55).
used('sendAnalysisCookie','id_user14_1', 'user id', 56).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 57).

used('sendMail', 'message', 'mail sent', 58).

wasControlledBy('sendData','DC', 'owner', 56384, 56386).
used('sendData', 'data_request_user14', 'request received', 56385).
wasGeneratedBy('data_report_user14','sendData', 'data response', 56386).

wasControlledBy('sendData','user14', 'receiver', 56387, 56388).
used('sendData', 'data_report_user14', 'request response received', 56388).
wasControlledBy('joinGroup','user14','owner',59,60).
used('joinGroup','id_user14_1', 'join group', 60).


used('revokeConsent','consent_user14_2','revokeConsent', 61).
wasControlledBy('sendTicket','user14', 'owner', 62, 65).

used('sendTicket','mail_user14_1', 'ticket sender mail', 63).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 64).
used('sendTicket', 'ticket', 'ticket sent', 65).



wasControlledBy('sendTicket','DC', 'owner', 106465, 106468).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 106466).
used('sendTicket','mail_user14_1', 'ticket reply sent', 106467).
used('sendTicket','ticketReply', 'ticket reply sent', 106468).

wasControlledBy('sendImprovementCookie','DC', 'owner', 115213, 115217).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 115214).
used('sendImprovementCookie','id_user14_1', 'user id', 115215).
used('sendImprovementCookie', 'wall_user14_1', 'extra data', 115216).

used('sendImprovementCookie','improvement_cookie', 'cookie', 115217).

wasControlledBy('sendTicket','user14', 'owner', 115218, 115219).
used('sendTicket', 'ticketReply', 'ticket reply received', 115219).
wasControlledBy('showRecommendation','DC', 'owner', 66, 74).
used('showRecommendation','id_user14_1', 'user id', 67).
used('showRecommendation','birthday_user14_1', 'user birth day', 68).
used('showRecommendation','friends_user14_1', 'user friends', 69).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 70, 73).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 71).
used('sendAnalysisCookie','id_user14_1', 'user id', 72).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 73).


used('showRecommendation','wall_user14_1', 'user wall', 74).
wasControlledBy('showRecommendation','DC', 'owner', 75, 88).
used('showRecommendation','id_user14_1', 'user id', 76).
used('showRecommendation','birthday_user14_1', 'user birth day', 77).
used('showRecommendation','friends_user14_1', 'user friends', 78).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 79, 82).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 80).
used('sendAnalysisCookie','id_user14_1', 'user id', 81).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 82).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 83, 87).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 84).
used('sendPersonalizationCookie','id_user14_1', 'user id', 85).
used('sendPersonalizationCookie', 'wall_user14_1', 'extra data', 86).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 87).

used('showRecommendation','wall_user14_1', 'user wall', 88).

wasControlledBy('updateConsent','user14', 'owner', 89, 91).
used('updateConsent', 'consent_user14_2', 'consent', 90).
wasGeneratedBy('consent_user14_3', 'updateConsent', 'consent', 91).


purposes('consent_user14_3','birthday_user14_1',[]).
purposes('consent_user14_3','id_user14_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user14_3','wall_user14_1',['post','showRecommendation']).
purposes('consent_user14_3','friends_user14_1',['post','showRecommendation']).





wasControlledBy('updateData','user14', 'owner', 92, 94).
used('updateData','name_user14_2', 'data to update', 93).
wasGeneratedBy('name_user14_3', 'updateData', 'updated data', 94).


wasControlledBy('updateConsent','user14', 'owner', 95, 97).
used('updateConsent', 'consent_user14_3', 'consent', 96).
wasGeneratedBy('consent_user14_4', 'updateConsent', 'consent', 97).


purposes('consent_user14_4','birthday_user14_1',['showRecommendation']).
purposes('consent_user14_4','id_user14_1',['sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user14_4','wall_user14_1',['post','showRecommendation']).
purposes('consent_user14_4','friends_user14_1',['post','showRecommendation']).





wasControlledBy('updateData','user14', 'owner', 98, 100).
used('updateData','name_user14_3', 'data to update', 99).
wasGeneratedBy('name_user14_4', 'updateData', 'updated data', 100).

wasControlledBy('post','user14', 'owner', 101, 113).
wasGeneratedBy('message', 'post', 'new post message', 102).
used('post','username_user14_1', 'username', 103).
used('post','friends_user14_1', 'user friends', 104).
used('post','wall_user14_1', 'user wall', 105).
used('post', 'birthday_user14_1', 'extra data', 106).

used('post','message', 'user message', 107).

wasControlledBy('sendImprovementCookie','DC', 'owner', 108, 112).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 109).
used('sendImprovementCookie','id_user14_1', 'user id', 110).
used('sendImprovementCookie', 'mail_user14_1', 'extra data', 111).

used('sendImprovementCookie','improvement_cookie', 'cookie', 112).

wasGeneratedBy('newPost', 'post', 'new user post', 113).


wasControlledBy('post','user14', 'owner', 114, 130).
wasGeneratedBy('message', 'post', 'new post message', 115).
used('post','username_user14_1', 'username', 116).
used('post','friends_user14_1', 'user friends', 117).
used('post','wall_user14_1', 'user wall', 118).
used('post', 'mail_user14_1', 'extra data', 119).

used('post','message', 'user message', 120).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 121, 125).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 122).
used('sendAnalysisCookie','id_user14_1', 'user id', 123).
used('sendAnalysisCookie', 'mail_user14_1', 'extra data', 124).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 125).

wasControlledBy('sendImprovementCookie','DC', 'owner', 126, 129).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 127).
used('sendImprovementCookie','id_user14_1', 'user id', 128).

used('sendImprovementCookie','improvement_cookie', 'cookie', 129).

wasGeneratedBy('newPost', 'post', 'new user post', 130).



wasControlledBy('updateData','user14', 'owner', 131, 133).
used('updateData','wall_user14_1', 'data to update', 132).
wasGeneratedBy('wall_user14_2', 'updateData', 'updated data', 133).

wasControlledBy('post','user14', 'owner', 134, 148).
wasGeneratedBy('message', 'post', 'new post message', 135).
used('post','username_user14_1', 'username', 136).
used('post','friends_user14_1', 'user friends', 137).
used('post','wall_user14_2', 'user wall', 138).

used('post','message', 'user message', 139).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 140, 143).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 141).
used('sendAnalysisCookie','id_user14_1', 'user id', 142).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 143).

wasControlledBy('sendImprovementCookie','DC', 'owner', 144, 147).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 145).
used('sendImprovementCookie','id_user14_1', 'user id', 146).

used('sendImprovementCookie','improvement_cookie', 'cookie', 147).

wasGeneratedBy('newPost', 'post', 'new user post', 148).
wasControlledBy('createAccount','user15','owner',1,8).
wasGeneratedBy('birthday_user15_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user15_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user15_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user15_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user15_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user15_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user15_1', 'createAccount', 'personal data', 8 ).



wasControlledBy('consent','user15','owner', 9, 14).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 10, 13).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 11).
used('sendAnalysisCookie','id_user15_1', 'user id', 12).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 13).

wasGeneratedBy('consent_user15_1','consent', 'consent', 14).

purposes('consent_user15_1','birthday_user15_1',['showRecommendation']).
purposes(_,'mail_user15_1',['sendMail','sendTicket']).
purposes(_,'name_user15_1',[]).
purposes('consent_user15_1','id_user15_1',['sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user15_1','wall_user15_1',['post','showRecommendation']).
purposes('consent_user15_1','friends_user15_1',['post','showRecommendation']).
purposes(_,'username_user15_1',['post']).


used('revokeConsent','consent_user15_1','revokeConsent', 15).
wasControlledBy('showRecommendation','DC', 'owner', 16, 24).
used('showRecommendation','id_user15_1', 'user id', 17).
used('showRecommendation','birthday_user15_1', 'user birth day', 18).
used('showRecommendation','friends_user15_1', 'user friends', 19).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 20, 23).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 21).
used('sendPersonalizationCookie','id_user15_1', 'user id', 22).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 23).

used('showRecommendation','wall_user15_1', 'user wall', 24).



wasControlledBy('updateData','user15', 'owner', 25, 27).
used('updateData','username_user15_1', 'data to update', 26).
wasGeneratedBy('username_user15_2', 'updateData', 'updated data', 27).


wasControlledBy('updateConsent','user15', 'owner', 28, 30).
used('updateConsent', 'consent_user15_1', 'consent', 29).
wasGeneratedBy('consent_user15_2', 'updateConsent', 'consent', 30).


purposes('consent_user15_2','birthday_user15_1',[]).
purposes('consent_user15_2','id_user15_1',['sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user15_2','wall_user15_1',['post','showRecommendation']).
purposes('consent_user15_2','friends_user15_1',['post','showRecommendation']).





wasControlledBy('updateData','user15', 'owner', 31, 33).
used('updateData','name_user15_1', 'data to update', 32).
wasGeneratedBy('name_user15_2', 'updateData', 'updated data', 33).


wasControlledBy('updateConsent','user15', 'owner', 34, 36).
used('updateConsent', 'consent_user15_2', 'consent', 35).
wasGeneratedBy('consent_user15_3', 'updateConsent', 'consent', 36).


purposes('consent_user15_3','birthday_user15_1',[]).
purposes('consent_user15_3','id_user15_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user15_3','wall_user15_1',['post','showRecommendation']).
purposes('consent_user15_3','friends_user15_1',['post','showRecommendation']).


wasControlledBy('post','user15', 'owner', 37, 44).
wasGeneratedBy('message', 'post', 'new post message', 38).
used('post','username_user15_2', 'username', 39).
used('post','friends_user15_1', 'user friends', 40).
used('post','wall_user15_1', 'user wall', 41).
used('post', 'name_user15_2', 'extra data', 42).

used('post','message', 'user message', 43).


wasGeneratedBy('newPost', 'post', 'new user post', 44).


wasControlledBy('sendMail','DC', 'owner', 45, 48).
wasGeneratedBy('message','sendMail', 'mail to send', 46).
used('sendMail','mail_user15_1', 'address to send to', 47).

used('sendMail', 'message', 'mail sent', 48).
wasControlledBy('sendTicket','user15', 'owner', 49, 53).
used('sendTicket', 'wall_user15_1', 'extra data', 50).

used('sendTicket','mail_user15_1', 'ticket sender mail', 51).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 52).
used('sendTicket', 'ticket', 'ticket sent', 53).



wasControlledBy('sendTicket','DC', 'owner', 87019, 87022).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 87020).
used('sendTicket','mail_user15_1', 'ticket reply sent', 87021).
used('sendTicket','ticketReply', 'ticket reply sent', 87022).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 36592, 36595).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 36593).
used('sendAnalysisCookie','id_user15_1', 'user id', 36594).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 36595).


wasControlledBy('sendTicket','user15', 'owner', 36596, 36597).
used('sendTicket', 'ticketReply', 'ticket reply received', 36597).
wasControlledBy('askDataAccess','user15','owner', 54, 55).


wasGeneratedBy('data_request_user15', 'askDataAccess', 'request', 55).

wasControlledBy('sendData','DC', 'owner', 73792, 73794).
used('sendData', 'data_request_user15', 'request received', 73793).
wasGeneratedBy('data_report_user15','sendData', 'data response', 73794).

wasControlledBy('sendData','user15', 'receiver', 73795, 73796).
used('sendData', 'data_report_user15', 'request response received', 73796).
wasControlledBy('showRecommendation','DC', 'owner', 56, 65).
used('showRecommendation','id_user15_1', 'user id', 57).
used('showRecommendation','birthday_user15_1', 'user birth day', 58).
used('showRecommendation','friends_user15_1', 'user friends', 59).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 60, 64).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 61).
used('sendPersonalizationCookie','id_user15_1', 'user id', 62).
used('sendPersonalizationCookie', 'friends_user15_1', 'extra data', 63).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 64).

used('showRecommendation','wall_user15_1', 'user wall', 65).
wasControlledBy('showRecommendation','DC', 'owner', 66, 75).
used('showRecommendation','id_user15_1', 'user id', 67).
used('showRecommendation','birthday_user15_1', 'user birth day', 68).
used('showRecommendation','friends_user15_1', 'user friends', 69).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 70, 74).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 71).
used('sendAnalysisCookie','id_user15_1', 'user id', 72).
used('sendAnalysisCookie', 'id_user15_1', 'extra data', 73).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 74).


used('showRecommendation','wall_user15_1', 'user wall', 75).
wasControlledBy('showRecommendation','DC', 'owner', 76, 84).
used('showRecommendation','id_user15_1', 'user id', 77).
used('showRecommendation','birthday_user15_1', 'user birth day', 78).
used('showRecommendation','friends_user15_1', 'user friends', 79).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 80, 83).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 81).
used('sendPersonalizationCookie','id_user15_1', 'user id', 82).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 83).

used('showRecommendation','wall_user15_1', 'user wall', 84).

wasControlledBy('updateConsent','user15', 'owner', 85, 87).
used('updateConsent', 'consent_user15_3', 'consent', 86).
wasGeneratedBy('consent_user15_4', 'updateConsent', 'consent', 87).


purposes('consent_user15_4','birthday_user15_1',[]).
purposes('consent_user15_4','id_user15_1',['sendAnalysisCookie','sendThirdPartiesCookie','sendImprovementCookie','joinGroup']).
purposes('consent_user15_4','wall_user15_1',['post','showRecommendation']).
purposes('consent_user15_4','friends_user15_1',['post','showRecommendation']).





wasControlledBy('updateData','user15', 'owner', 88, 90).
used('updateData','username_user15_2', 'data to update', 89).
wasGeneratedBy('username_user15_3', 'updateData', 'updated data', 90).

wasControlledBy('joinGroup','user15','owner',91,92).
used('joinGroup','id_user15_1', 'join group', 92).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 93, 96).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 94).
used('sendAnalysisCookie','id_user15_1', 'user id', 95).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 96).

wasControlledBy('showRecommendation','DC', 'owner', 97, 105).
used('showRecommendation','id_user15_1', 'user id', 98).
used('showRecommendation','birthday_user15_1', 'user birth day', 99).
used('showRecommendation','friends_user15_1', 'user friends', 100).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 101, 104).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 102).
used('sendPersonalizationCookie','id_user15_1', 'user id', 103).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 104).

used('showRecommendation','wall_user15_1', 'user wall', 105).

wasControlledBy('updateConsent','user15', 'owner', 106, 108).
used('updateConsent', 'consent_user15_4', 'consent', 107).
wasGeneratedBy('consent_user15_5', 'updateConsent', 'consent', 108).


purposes('consent_user15_5','birthday_user15_1',[]).
purposes('consent_user15_5','id_user15_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user15_5','wall_user15_1',['post']).
purposes('consent_user15_5','friends_user15_1',['post','showRecommendation']).


wasControlledBy('post','user15', 'owner', 109, 121).
wasGeneratedBy('message', 'post', 'new post message', 110).
used('post','username_user15_3', 'username', 111).
used('post','friends_user15_1', 'user friends', 112).
used('post','wall_user15_1', 'user wall', 113).
used('post', 'friends_user15_1', 'extra data', 114).

used('post','message', 'user message', 115).

wasControlledBy('sendImprovementCookie','DC', 'owner', 116, 120).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 117).
used('sendImprovementCookie','id_user15_1', 'user id', 118).
used('sendImprovementCookie', 'username_user15_3', 'extra data', 119).

used('sendImprovementCookie','improvement_cookie', 'cookie', 120).

wasGeneratedBy('newPost', 'post', 'new user post', 121).

wasControlledBy('createAccount','user16','owner',1,8).
wasGeneratedBy('birthday_user16_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user16_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user16_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user16_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user16_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user16_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user16_1', 'createAccount', 'personal data', 8 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 13).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user16_1', 'user id', 11).
used('sendAnalysisCookie', 'wall_user16_1', 'extra data', 12).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 13).

wasControlledBy('consent','user16','owner', 14, 19).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 15, 18).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 16).
used('sendAnalysisCookie','id_user16_1', 'user id', 17).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 18).

wasGeneratedBy('consent_user16_1','consent', 'consent', 19).

purposes('consent_user16_1','birthday_user16_1',[]).
purposes(_,'mail_user16_1',['sendMail','sendTicket']).
purposes(_,'name_user16_1',[]).
purposes('consent_user16_1','id_user16_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user16_1','wall_user16_1',['post']).
purposes('consent_user16_1','friends_user16_1',['post','showRecommendation']).
purposes(_,'username_user16_1',['post']).


wasControlledBy('askDataAccess','user16','owner', 20, 26).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 21, 25).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 22).
used('sendAnalysisCookie','id_user16_1', 'user id', 23).
used('sendAnalysisCookie', 'wall_user16_1', 'extra data', 24).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 25).

wasGeneratedBy('data_request_user16', 'askDataAccess', 'request', 26).



wasControlledBy('updateData','user16', 'owner', 27, 29).
used('updateData','mail_user16_1', 'data to update', 28).
wasGeneratedBy('mail_user16_2', 'updateData', 'updated data', 29).

wasControlledBy('joinGroup','user16','owner',30,31).
used('joinGroup','id_user16_1', 'join group', 31).


wasControlledBy('sendData','DC', 'owner', 85490, 85492).
used('sendData', 'data_request_user16', 'request received', 85491).
wasGeneratedBy('data_report_user16','sendData', 'data response', 85492).

wasControlledBy('sendData','user16', 'receiver', 85493, 85494).
used('sendData', 'data_report_user16', 'request response received', 85494).
wasControlledBy('sendMail','DC', 'owner', 32, 35).
wasGeneratedBy('message','sendMail', 'mail to send', 33).
used('sendMail','mail_user16_2', 'address to send to', 34).

used('sendMail', 'message', 'mail sent', 35).
wasControlledBy('sendTicket','user16', 'owner', 36, 39).

used('sendTicket','mail_user16_2', 'ticket sender mail', 37).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 38).
used('sendTicket', 'ticket', 'ticket sent', 39).



wasControlledBy('sendTicket','DC', 'owner', 77695, 77698).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 77696).
used('sendTicket','mail_user16_2', 'ticket reply sent', 77697).
used('sendTicket','ticketReply', 'ticket reply sent', 77698).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 48815, 48819).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 48816).
used('sendAnalysisCookie','id_user16_1', 'user id', 48817).
used('sendAnalysisCookie', 'id_user16_1', 'extra data', 48818).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 48819).

wasControlledBy('sendImprovementCookie','DC', 'owner', 128894, 128897).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 128895).
used('sendImprovementCookie','id_user16_1', 'user id', 128896).

used('sendImprovementCookie','improvement_cookie', 'cookie', 128897).

wasControlledBy('sendTicket','user16', 'owner', 128898, 128899).
used('sendTicket', 'ticketReply', 'ticket reply received', 128899).

wasControlledBy('updateConsent','user16', 'owner', 40, 42).
used('updateConsent', 'consent_user16_1', 'consent', 41).
wasGeneratedBy('consent_user16_2', 'updateConsent', 'consent', 42).


purposes('consent_user16_2','birthday_user16_1',['showRecommendation']).
purposes('consent_user16_2','id_user16_1',['sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user16_2','wall_user16_1',['post']).
purposes('consent_user16_2','friends_user16_1',['post','showRecommendation']).


wasControlledBy('joinGroup','user16','owner',43,44).
used('joinGroup','id_user16_1', 'join group', 44).


wasControlledBy('joinGroup','user16','owner',45,46).
used('joinGroup','id_user16_1', 'join group', 46).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 47, 50).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 48).
used('sendThirdPartiesCookie','id_user16_1', 'user id', 49).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 50).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 51, 55).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 52).
used('sendAnalysisCookie','id_user16_1', 'user id', 53).
used('sendAnalysisCookie', 'name_user16_1', 'extra data', 54).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 55).

used('revokeConsent','consent_user16_2','revokeConsent', 56).
wasControlledBy('post','user16', 'owner', 57, 68).
wasGeneratedBy('message', 'post', 'new post message', 58).
used('post','username_user16_1', 'username', 59).
used('post','friends_user16_1', 'user friends', 60).
used('post','wall_user16_1', 'user wall', 61).
used('post', 'birthday_user16_1', 'extra data', 62).

used('post','message', 'user message', 63).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 64, 67).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 65).
used('sendAnalysisCookie','id_user16_1', 'user id', 66).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 67).


wasGeneratedBy('newPost', 'post', 'new user post', 68).

wasControlledBy('updateConsent','user16', 'owner', 69, 71).
used('updateConsent', 'consent_user16_2', 'consent', 70).
wasGeneratedBy('consent_user16_3', 'updateConsent', 'consent', 71).


purposes('consent_user16_3','birthday_user16_1',['showRecommendation']).
purposes('consent_user16_3','id_user16_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user16_3','wall_user16_1',['post','showRecommendation']).
purposes('consent_user16_3','friends_user16_1',['post']).





wasControlledBy('updateData','user16', 'owner', 72, 74).
used('updateData','name_user16_1', 'data to update', 73).
wasGeneratedBy('name_user16_2', 'updateData', 'updated data', 74).

wasControlledBy('showRecommendation','DC', 'owner', 75, 79).
used('showRecommendation','id_user16_1', 'user id', 76).
used('showRecommendation','birthday_user16_1', 'user birth day', 77).
used('showRecommendation','friends_user16_1', 'user friends', 78).


used('showRecommendation','wall_user16_1', 'user wall', 79).

wasControlledBy('showRecommendation','DC', 'owner', 80, 88).
used('showRecommendation','id_user16_1', 'user id', 81).
used('showRecommendation','birthday_user16_1', 'user birth day', 82).
used('showRecommendation','friends_user16_1', 'user friends', 83).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 84, 87).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 85).
used('sendPersonalizationCookie','id_user16_1', 'user id', 86).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 87).

used('showRecommendation','wall_user16_1', 'user wall', 88).
wasControlledBy('createAccount','user17','owner',1,8).
wasGeneratedBy('birthday_user17_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user17_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user17_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user17_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user17_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user17_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user17_1', 'createAccount', 'personal data', 8 ).



wasControlledBy('sendMail','DC', 'owner', 9, 16).
wasGeneratedBy('message','sendMail', 'mail to send', 10).
used('sendMail','mail_user17_1', 'address to send to', 11).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 12, 15).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 13).
used('sendAnalysisCookie','id_user17_1', 'user id', 14).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 15).

used('sendMail', 'message', 'mail sent', 16).
wasControlledBy('consent','user17','owner', 17, 23).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 18, 22).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 19).
used('sendAnalysisCookie','id_user17_1', 'user id', 20).
used('sendAnalysisCookie', 'mail_user17_1', 'extra data', 21).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 22).

wasGeneratedBy('consent_user17_1','consent', 'consent', 23).

purposes('consent_user17_1','birthday_user17_1',['showRecommendation']).
purposes(_,'mail_user17_1',['sendMail','sendTicket']).
purposes(_,'name_user17_1',[]).
purposes('consent_user17_1','id_user17_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user17_1','wall_user17_1',['post','showRecommendation']).
purposes('consent_user17_1','friends_user17_1',['post']).
purposes(_,'username_user17_1',['post']).


wasControlledBy('updateConsent','user17', 'owner', 24, 26).
used('updateConsent', 'consent_user17_1', 'consent', 25).
wasGeneratedBy('consent_user17_2', 'updateConsent', 'consent', 26).


purposes('consent_user17_2','birthday_user17_1',[]).
purposes('consent_user17_2','id_user17_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user17_2','wall_user17_1',['post']).
purposes('consent_user17_2','friends_user17_1',['post','showRecommendation']).





wasControlledBy('updateData','user17', 'owner', 27, 29).
used('updateData','name_user17_1', 'data to update', 28).
wasGeneratedBy('name_user17_2', 'updateData', 'updated data', 29).

wasControlledBy('showRecommendation','DC', 'owner', 30, 38).
used('showRecommendation','id_user17_1', 'user id', 31).
used('showRecommendation','birthday_user17_1', 'user birth day', 32).
used('showRecommendation','friends_user17_1', 'user friends', 33).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 34, 37).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 35).
used('sendPersonalizationCookie','id_user17_1', 'user id', 36).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 37).

used('showRecommendation','wall_user17_1', 'user wall', 38).

wasControlledBy('askDataAccess','user17','owner', 39, 44).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 40, 43).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 41).
used('sendAnalysisCookie','id_user17_1', 'user id', 42).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 43).

wasGeneratedBy('data_request_user17', 'askDataAccess', 'request', 44).
wasControlledBy('joinGroup','user17','owner',45,46).
used('joinGroup','id_user17_1', 'join group', 46).

wasControlledBy('sendTicket','user17', 'owner', 47, 50).

used('sendTicket','mail_user17_1', 'ticket sender mail', 48).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 49).
used('sendTicket', 'ticket', 'ticket sent', 50).


wasControlledBy('joinGroup','user17','owner',51,52).
used('joinGroup','id_user17_1', 'join group', 52).


wasControlledBy('sendTicket','DC', 'owner', 28898, 28901).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 28899).
used('sendTicket','mail_user17_1', 'ticket reply sent', 28900).
used('sendTicket','ticketReply', 'ticket reply sent', 28901).


wasControlledBy('sendTicket','user17', 'owner', 28902, 28903).
used('sendTicket', 'ticketReply', 'ticket reply received', 28903).



wasControlledBy('updateData','user17', 'owner', 53, 55).
used('updateData','username_user17_1', 'data to update', 54).
wasGeneratedBy('username_user17_2', 'updateData', 'updated data', 55).


wasControlledBy('updateConsent','user17', 'owner', 56, 58).
used('updateConsent', 'consent_user17_2', 'consent', 57).
wasGeneratedBy('consent_user17_3', 'updateConsent', 'consent', 58).


purposes('consent_user17_3','birthday_user17_1',[]).
purposes('consent_user17_3','id_user17_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user17_3','wall_user17_1',['post','showRecommendation']).
purposes('consent_user17_3','friends_user17_1',['post','showRecommendation']).





wasControlledBy('updateData','user17', 'owner', 59, 61).
used('updateData','name_user17_2', 'data to update', 60).
wasGeneratedBy('name_user17_3', 'updateData', 'updated data', 61).


wasControlledBy('updateConsent','user17', 'owner', 62, 64).
used('updateConsent', 'consent_user17_3', 'consent', 63).
wasGeneratedBy('consent_user17_4', 'updateConsent', 'consent', 64).


purposes('consent_user17_4','birthday_user17_1',['showRecommendation']).
purposes('consent_user17_4','id_user17_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user17_4','wall_user17_1',['post','showRecommendation']).
purposes('consent_user17_4','friends_user17_1',['post','showRecommendation']).


wasControlledBy('post','user17', 'owner', 65, 72).
wasGeneratedBy('message', 'post', 'new post message', 66).
used('post','username_user17_2', 'username', 67).
used('post','friends_user17_1', 'user friends', 68).
used('post','wall_user17_1', 'user wall', 69).
used('post', 'wall_user17_1', 'extra data', 70).

used('post','message', 'user message', 71).


wasGeneratedBy('newPost', 'post', 'new user post', 72).



used('revokeConsent','consent_user17_4','revokeConsent', 73).

wasControlledBy('sendData','DC', 'owner', 99787, 99789).
used('sendData', 'data_request_user17', 'request received', 99788).
wasGeneratedBy('data_report_user17','sendData', 'data response', 99789).

wasControlledBy('sendData','user17', 'receiver', 99790, 99791).
used('sendData', 'data_report_user17', 'request response received', 99791).
wasControlledBy('joinGroup','user17','owner',74,75).
used('joinGroup','id_user17_1', 'join group', 75).

wasControlledBy('joinGroup','user17','owner',76,77).
used('joinGroup','id_user17_1', 'join group', 77).

wasControlledBy('joinGroup','user17','owner',78,79).
used('joinGroup','id_user17_1', 'join group', 79).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 80, 84).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 81).
used('sendThirdPartiesCookie','id_user17_1', 'user id', 82).
used('sendThirdPartiesCookie', 'friends_user17_1', 'extra data', 83).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 84).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 85, 89).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 86).
used('sendAnalysisCookie','id_user17_1', 'user id', 87).
used('sendAnalysisCookie', 'name_user17_3', 'extra data', 88).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 89).
wasControlledBy('post','user17', 'owner', 90, 102).
wasGeneratedBy('message', 'post', 'new post message', 91).
used('post','username_user17_2', 'username', 92).
used('post','friends_user17_1', 'user friends', 93).
used('post','wall_user17_1', 'user wall', 94).
used('post', 'id_user17_1', 'extra data', 95).

used('post','message', 'user message', 96).

wasControlledBy('sendImprovementCookie','DC', 'owner', 97, 101).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 98).
used('sendImprovementCookie','id_user17_1', 'user id', 99).
used('sendImprovementCookie', 'id_user17_1', 'extra data', 100).

used('sendImprovementCookie','improvement_cookie', 'cookie', 101).

wasGeneratedBy('newPost', 'post', 'new user post', 102).
wasControlledBy('createAccount','user18','owner',1,8).
wasGeneratedBy('birthday_user18_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user18_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user18_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user18_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user18_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user18_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user18_1', 'createAccount', 'personal data', 8 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 13).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user18_1', 'user id', 11).
used('sendAnalysisCookie', 'friends_user18_1', 'extra data', 12).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 13).


wasControlledBy('sendTicket','user18', 'owner', 14, 18).
used('sendTicket', 'name_user18_1', 'extra data', 15).

used('sendTicket','mail_user18_1', 'ticket sender mail', 16).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 17).
used('sendTicket', 'ticket', 'ticket sent', 18).


wasControlledBy('sendMail','DC', 'owner', 19, 27).
wasGeneratedBy('message','sendMail', 'mail to send', 20).
used('sendMail','mail_user18_1', 'address to send to', 21).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 22, 26).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 23).
used('sendAnalysisCookie','id_user18_1', 'user id', 24).
used('sendAnalysisCookie', 'birthday_user18_1', 'extra data', 25).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 26).

used('sendMail', 'message', 'mail sent', 27).
wasControlledBy('consent','user18','owner', 28, 33).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 29, 32).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 30).
used('sendAnalysisCookie','id_user18_1', 'user id', 31).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 32).

wasGeneratedBy('consent_user18_1','consent', 'consent', 33).

purposes('consent_user18_1','birthday_user18_1',['showRecommendation']).
purposes(_,'mail_user18_1',['sendMail','sendTicket']).
purposes(_,'name_user18_1',[]).
purposes('consent_user18_1','id_user18_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user18_1','wall_user18_1',['post','showRecommendation']).
purposes('consent_user18_1','friends_user18_1',['post','showRecommendation']).
purposes(_,'username_user18_1',['post']).


wasControlledBy('updateConsent','user18', 'owner', 34, 36).
used('updateConsent', 'consent_user18_1', 'consent', 35).
wasGeneratedBy('consent_user18_2', 'updateConsent', 'consent', 36).


purposes('consent_user18_2','birthday_user18_1',[]).
purposes('consent_user18_2','id_user18_1',['sendThirdPartiesCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user18_2','wall_user18_1',['post','showRecommendation']).
purposes('consent_user18_2','friends_user18_1',['post','showRecommendation']).


wasControlledBy('showRecommendation','DC', 'owner', 37, 41).
used('showRecommendation','id_user18_1', 'user id', 38).
used('showRecommendation','birthday_user18_1', 'user birth day', 39).
used('showRecommendation','friends_user18_1', 'user friends', 40).


used('showRecommendation','wall_user18_1', 'user wall', 41).

wasControlledBy('askDataAccess','user18','owner', 42, 52).
wasControlledBy('sendImprovementCookie','DC', 'owner', 43, 46).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 44).
used('sendImprovementCookie','id_user18_1', 'user id', 45).

used('sendImprovementCookie','improvement_cookie', 'cookie', 46).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 47, 51).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 48).
used('sendAnalysisCookie','id_user18_1', 'user id', 49).
used('sendAnalysisCookie', 'id_user18_1', 'extra data', 50).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 51).

wasGeneratedBy('data_request_user18', 'askDataAccess', 'request', 52).

wasControlledBy('sendData','DC', 'owner', 112039, 112041).
used('sendData', 'data_request_user18', 'request received', 112040).
wasGeneratedBy('data_report_user18','sendData', 'data response', 112041).

wasControlledBy('sendData','user18', 'receiver', 112042, 112043).
used('sendData', 'data_report_user18', 'request response received', 112043).



wasControlledBy('updateData','user18', 'owner', 53, 55).
used('updateData','mail_user18_1', 'data to update', 54).
wasGeneratedBy('mail_user18_2', 'updateData', 'updated data', 55).


wasControlledBy('updateConsent','user18', 'owner', 56, 58).
used('updateConsent', 'consent_user18_2', 'consent', 57).
wasGeneratedBy('consent_user18_3', 'updateConsent', 'consent', 58).


purposes('consent_user18_3','birthday_user18_1',[]).
purposes('consent_user18_3','id_user18_1',['joinGroup','sendPersonalizationCookie']).
purposes('consent_user18_3','wall_user18_1',['post','showRecommendation']).
purposes('consent_user18_3','friends_user18_1',['post','showRecommendation']).


wasControlledBy('showRecommendation','DC', 'owner', 59, 63).
used('showRecommendation','id_user18_1', 'user id', 60).
used('showRecommendation','birthday_user18_1', 'user birth day', 61).
used('showRecommendation','friends_user18_1', 'user friends', 62).


used('showRecommendation','wall_user18_1', 'user wall', 63).


used('revokeConsent','consent_user18_3','revokeConsent', 64).
wasControlledBy('post','user18', 'owner', 65, 76).
wasGeneratedBy('message', 'post', 'new post message', 66).
used('post','username_user18_1', 'username', 67).
used('post','friends_user18_1', 'user friends', 68).
used('post','wall_user18_1', 'user wall', 69).

used('post','message', 'user message', 70).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 71, 75).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 72).
used('sendAnalysisCookie','id_user18_1', 'user id', 73).
used('sendAnalysisCookie', 'birthday_user18_1', 'extra data', 74).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 75).


wasGeneratedBy('newPost', 'post', 'new user post', 76).

wasControlledBy('sendTicket','DC', 'owner', 74197, 74200).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 74198).
used('sendTicket','mail_user18_2', 'ticket reply sent', 74199).
used('sendTicket','ticketReply', 'ticket reply sent', 74200).


wasControlledBy('sendTicket','user18', 'owner', 74201, 74202).
used('sendTicket', 'ticketReply', 'ticket reply received', 74202).
wasControlledBy('showRecommendation','DC', 'owner', 77, 81).
used('showRecommendation','id_user18_1', 'user id', 78).
used('showRecommendation','birthday_user18_1', 'user birth day', 79).
used('showRecommendation','friends_user18_1', 'user friends', 80).


used('showRecommendation','wall_user18_1', 'user wall', 81).
wasControlledBy('joinGroup','user18','owner',82,83).
used('joinGroup','id_user18_1', 'join group', 83).

wasControlledBy('joinGroup','user18','owner',84,85).
used('joinGroup','id_user18_1', 'join group', 85).

wasControlledBy('showRecommendation','DC', 'owner', 86, 98).
used('showRecommendation','id_user18_1', 'user id', 87).
used('showRecommendation','birthday_user18_1', 'user birth day', 88).
used('showRecommendation','friends_user18_1', 'user friends', 89).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 90, 93).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 91).
used('sendAnalysisCookie','id_user18_1', 'user id', 92).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 93).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 94, 97).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 95).
used('sendPersonalizationCookie','id_user18_1', 'user id', 96).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 97).

used('showRecommendation','wall_user18_1', 'user wall', 98).
wasControlledBy('createAccount','user19','owner',1,8).
wasGeneratedBy('birthday_user19_1', 'createAccount', 'personal data', 2 ).
wasGeneratedBy('mail_user19_1', 'createAccount', 'personal data', 3 ).
wasGeneratedBy('name_user19_1', 'createAccount', 'personal data', 4 ).
wasGeneratedBy('id_user19_1', 'createAccount', 'personal data', 5 ).
wasGeneratedBy('wall_user19_1', 'createAccount', 'personal data', 6 ).
wasGeneratedBy('friends_user19_1', 'createAccount', 'personal data', 7 ).
wasGeneratedBy('username_user19_1', 'createAccount', 'personal data', 8 ).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 9, 12).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 10).
used('sendAnalysisCookie','id_user19_1', 'user id', 11).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 12).

wasControlledBy('consent','user19','owner', 13, 14).

wasGeneratedBy('consent_user19_1','consent', 'consent', 14).

purposes('consent_user19_1','birthday_user19_1',[]).
purposes(_,'mail_user19_1',['sendMail','sendTicket']).
purposes(_,'name_user19_1',[]).
purposes('consent_user19_1','id_user19_1',['joinGroup','sendPersonalizationCookie']).
purposes('consent_user19_1','wall_user19_1',['post','showRecommendation']).
purposes('consent_user19_1','friends_user19_1',['post','showRecommendation']).
purposes(_,'username_user19_1',['post']).


wasControlledBy('sendMail','DC', 'owner', 15, 22).
wasGeneratedBy('message','sendMail', 'mail to send', 16).
used('sendMail','mail_user19_1', 'address to send to', 17).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 18, 21).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 19).
used('sendAnalysisCookie','id_user19_1', 'user id', 20).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 21).

used('sendMail', 'message', 'mail sent', 22).



wasControlledBy('updateData','user19', 'owner', 23, 25).
used('updateData','username_user19_1', 'data to update', 24).
wasGeneratedBy('username_user19_2', 'updateData', 'updated data', 25).

wasControlledBy('showRecommendation','DC', 'owner', 26, 39).
used('showRecommendation','id_user19_1', 'user id', 27).
used('showRecommendation','birthday_user19_1', 'user birth day', 28).
used('showRecommendation','friends_user19_1', 'user friends', 29).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 30, 34).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 31).
used('sendAnalysisCookie','id_user19_1', 'user id', 32).
used('sendAnalysisCookie', 'wall_user19_1', 'extra data', 33).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 34).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 35, 38).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 36).
used('sendPersonalizationCookie','id_user19_1', 'user id', 37).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 38).

used('showRecommendation','wall_user19_1', 'user wall', 39).
wasControlledBy('askDataAccess','user19','owner', 40, 50).
wasControlledBy('sendImprovementCookie','DC', 'owner', 41, 45).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 42).
used('sendImprovementCookie','id_user19_1', 'user id', 43).
used('sendImprovementCookie', 'username_user19_2', 'extra data', 44).

used('sendImprovementCookie','improvement_cookie', 'cookie', 45).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 46, 49).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 47).
used('sendAnalysisCookie','id_user19_1', 'user id', 48).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 49).

wasGeneratedBy('data_request_user19', 'askDataAccess', 'request', 50).

wasControlledBy('sendData','DC', 'owner', 23622, 23624).
used('sendData', 'data_request_user19', 'request received', 23623).
wasGeneratedBy('data_report_user19','sendData', 'data response', 23624).

wasControlledBy('sendData','user19', 'receiver', 23625, 23626).
used('sendData', 'data_report_user19', 'request response received', 23626).
wasControlledBy('sendTicket','user19', 'owner', 51, 54).

used('sendTicket','mail_user19_1', 'ticket sender mail', 52).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 53).
used('sendTicket', 'ticket', 'ticket sent', 54).


wasControlledBy('post','user19', 'owner', 55, 61).
wasGeneratedBy('message', 'post', 'new post message', 56).
used('post','username_user19_2', 'username', 57).
used('post','friends_user19_1', 'user friends', 58).
used('post','wall_user19_1', 'user wall', 59).

used('post','message', 'user message', 60).


wasGeneratedBy('newPost', 'post', 'new user post', 61).

used('revokeConsent','consent_user19_1','revokeConsent', 62).

wasControlledBy('updateConsent','user19', 'owner', 63, 65).
used('updateConsent', 'consent_user19_1', 'consent', 64).
wasGeneratedBy('consent_user19_2', 'updateConsent', 'consent', 65).


purposes('consent_user19_2','birthday_user19_1',[]).
purposes('consent_user19_2','id_user19_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user19_2','wall_user19_1',['post','showRecommendation']).
purposes('consent_user19_2','friends_user19_1',['post','showRecommendation']).


wasControlledBy('showRecommendation','DC', 'owner', 66, 79).
used('showRecommendation','id_user19_1', 'user id', 67).
used('showRecommendation','birthday_user19_1', 'user birth day', 68).
used('showRecommendation','friends_user19_1', 'user friends', 69).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 70, 74).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 71).
used('sendAnalysisCookie','id_user19_1', 'user id', 72).
used('sendAnalysisCookie', 'name_user19_1', 'extra data', 73).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 74).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 75, 78).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 76).
used('sendPersonalizationCookie','id_user19_1', 'user id', 77).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 78).

used('showRecommendation','wall_user19_1', 'user wall', 79).


wasControlledBy('sendTicket','DC', 'owner', 99688, 99691).
wasGeneratedBy('ticketReply','sendTicket', 'ticket reply', 99689).
used('sendTicket','mail_user19_1', 'ticket reply sent', 99690).
used('sendTicket','ticketReply', 'ticket reply sent', 99691).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 48804, 48808).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 48805).
used('sendAnalysisCookie','id_user19_1', 'user id', 48806).
used('sendAnalysisCookie', 'username_user19_2', 'extra data', 48807).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 48808).

wasControlledBy('sendImprovementCookie','DC', 'owner', 66604, 66608).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 66605).
used('sendImprovementCookie','id_user19_1', 'user id', 66606).
used('sendImprovementCookie', 'name_user19_1', 'extra data', 66607).

used('sendImprovementCookie','improvement_cookie', 'cookie', 66608).

wasControlledBy('sendTicket','user19', 'owner', 66609, 66610).
used('sendTicket', 'ticketReply', 'ticket reply received', 66610).

wasControlledBy('updateConsent','user19', 'owner', 80, 82).
used('updateConsent', 'consent_user19_2', 'consent', 81).
wasGeneratedBy('consent_user19_3', 'updateConsent', 'consent', 82).


purposes('consent_user19_3','birthday_user19_1',[]).
purposes('consent_user19_3','id_user19_1',['sendAnalysisCookie','joinGroup']).
purposes('consent_user19_3','wall_user19_1',['post','showRecommendation']).
purposes('consent_user19_3','friends_user19_1',['post','showRecommendation']).


wasControlledBy('joinGroup','user19','owner',83,84).
used('joinGroup','id_user19_1', 'join group', 84).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 85, 88).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 86).
used('sendThirdPartiesCookie','id_user19_1', 'user id', 87).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 88).


wasControlledBy('post','user19', 'owner', 89, 96).
wasGeneratedBy('message', 'post', 'new post message', 90).
used('post','username_user19_2', 'username', 91).
used('post','friends_user19_1', 'user friends', 92).
used('post','wall_user19_1', 'user wall', 93).
used('post', 'friends_user19_1', 'extra data', 94).

used('post','message', 'user message', 95).


wasGeneratedBy('newPost', 'post', 'new user post', 96).
wasControlledBy('joinGroup','user19','owner',97,98).
used('joinGroup','id_user19_1', 'join group', 98).

wasControlledBy('joinGroup','user19','owner',99,100).
used('joinGroup','id_user19_1', 'join group', 100).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 101, 104).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 102).
used('sendAnalysisCookie','id_user19_1', 'user id', 103).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 104).

wasControlledBy('updateConsent','user19', 'owner', 105, 107).
used('updateConsent', 'consent_user19_3', 'consent', 106).
wasGeneratedBy('consent_user19_4', 'updateConsent', 'consent', 107).


purposes('consent_user19_4','birthday_user19_1',[]).
purposes('consent_user19_4','id_user19_1',['sendAnalysisCookie','sendImprovementCookie','joinGroup','sendPersonalizationCookie']).
purposes('consent_user19_4','wall_user19_1',['post','showRecommendation']).
purposes('consent_user19_4','friends_user19_1',['post','showRecommendation']).





wasControlledBy('updateData','user19', 'owner', 108, 110).
used('updateData','username_user19_2', 'data to update', 109).
wasGeneratedBy('username_user19_3', 'updateData', 'updated data', 110).

wasControlledBy('post','user19', 'owner', 111, 123).
wasGeneratedBy('message', 'post', 'new post message', 112).
used('post','username_user19_3', 'username', 113).
used('post','friends_user19_1', 'user friends', 114).
used('post','wall_user19_1', 'user wall', 115).
used('post', 'birthday_user19_1', 'extra data', 116).

used('post','message', 'user message', 117).

wasControlledBy('sendImprovementCookie','DC', 'owner', 118, 122).
wasGeneratedBy('improvement_cookie', 'sendImprovementCookie', 'cookie to send', 119).
used('sendImprovementCookie','id_user19_1', 'user id', 120).
used('sendImprovementCookie', 'mail_user19_1', 'extra data', 121).

used('sendImprovementCookie','improvement_cookie', 'cookie', 122).

wasGeneratedBy('newPost', 'post', 'new user post', 123).

wasControlledBy('showRecommendation','DC', 'owner', 124, 137).
used('showRecommendation','id_user19_1', 'user id', 125).
used('showRecommendation','birthday_user19_1', 'user birth day', 126).
used('showRecommendation','friends_user19_1', 'user friends', 127).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 128, 131).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 129).
used('sendAnalysisCookie','id_user19_1', 'user id', 130).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 131).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 132, 136).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 133).
used('sendPersonalizationCookie','id_user19_1', 'user id', 134).
used('sendPersonalizationCookie', 'friends_user19_1', 'extra data', 135).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 136).

used('showRecommendation','wall_user19_1', 'user wall', 137).
wasControlledBy('joinGroup','user19','owner',138,139).
used('joinGroup','id_user19_1', 'join group', 139).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 140, 143).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 141).
used('sendThirdPartiesCookie','id_user19_1', 'user id', 142).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 143).

wasControlledBy('sendAnalysisCookie','DC', 'owner', 144, 147).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 145).
used('sendAnalysisCookie','id_user19_1', 'user id', 146).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 147).
wasControlledBy('joinGroup','user19','owner',148,149).
used('joinGroup','id_user19_1', 'join group', 149).
wasControlledBy('sendThirdPartiesCookie','DC', 'owner', 150, 154).
wasGeneratedBy('marketing_cookie', 'sendThirdPartiesCookie', 'cookie to send', 151).
used('sendThirdPartiesCookie','id_user19_1', 'user id', 152).
used('sendThirdPartiesCookie', 'wall_user19_1', 'extra data', 153).

used('sendThirdPartiesCookie','marketing_cookie', 'cookie', 154).


wasControlledBy('updateConsent','user19', 'owner', 155, 157).
used('updateConsent', 'consent_user19_4', 'consent', 156).
wasGeneratedBy('consent_user19_5', 'updateConsent', 'consent', 157).


purposes('consent_user19_5','birthday_user19_1',[]).
purposes('consent_user19_5','id_user19_1',['sendAnalysisCookie','sendThirdPartiesCookie','joinGroup']).
purposes('consent_user19_5','wall_user19_1',['post','showRecommendation']).
purposes('consent_user19_5','friends_user19_1',['post','showRecommendation']).





wasControlledBy('updateData','user19', 'owner', 158, 160).
used('updateData','username_user19_3', 'data to update', 159).
wasGeneratedBy('username_user19_4', 'updateData', 'updated data', 160).

wasControlledBy('showRecommendation','DC', 'owner', 161, 173).
used('showRecommendation','id_user19_1', 'user id', 162).
used('showRecommendation','birthday_user19_1', 'user birth day', 163).
used('showRecommendation','friends_user19_1', 'user friends', 164).
wasControlledBy('sendAnalysisCookie','DC', 'owner', 165, 168).
wasGeneratedBy('analysis_cookie', 'sendAnalysisCookie', 'cookie to send', 166).
used('sendAnalysisCookie','id_user19_1', 'user id', 167).

used('sendAnalysisCookie','analysis_cookie', 'cookie', 168).

wasControlledBy('sendPersonalizationCookie','DC', 'owner', 169, 172).
wasGeneratedBy('personalization_cookie', 'sendPersonalizationCookie', 'cookie to send', 170).
used('sendPersonalizationCookie','id_user19_1', 'user id', 171).

used('sendPersonalizationCookie','personalization_cookie', 'cookie', 172).

used('showRecommendation','wall_user19_1', 'user wall', 173).

purposes(_,_,['consent','delete','askErase','sendData','askDataAccess','updateConsent','accessWebPage','updateData','createAccount','login']).

action('sendData', 'sendData').
action('sendThirdPartiesCookie', 'sendThirdPartiesCookie').
action('updateData', 'updateData').
action('sendAdSMS', 'sendAdSMS').
action('sendMail', 'sendMail').
action('sendImprovementCookie', 'sendImprovementCookie').
action('showRecommendation', 'showRecommendation').
action('createAccount', 'createAccount').
action('consent', 'consent').
action('login', 'login').
action('joinGroup', 'joinGroup').
action('delete', 'delete').
action('askDataAccess', 'askDataAccess').
action('sendTicket', 'sendTicket').
action('sendPersonalizationCookie', 'sendPersonalizationCookie').
action('sendAnalysisCookie', 'sendAnalysisCookie').
action('providePolicy', 'providePolicy').
action('post', 'post').
action('askErase', 'askErase').
action('updateConsent', 'updateConsent').
