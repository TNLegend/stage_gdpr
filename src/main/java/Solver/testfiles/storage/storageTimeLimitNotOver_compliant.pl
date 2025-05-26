wasControlledBy('createAccount','David','owner',1,7).
wasGeneratedBy('mail_David_1', 'createAccount', 'personal data', 4 ).

wasControlledBy('consent','David', 'owner', 8, 9).
wasGeneratedBy('consent_David_1', 'consent', 'consent', 9).

purposes(_,'mail_David_1',['sendMail','sendTicket']).


wasControlledBy('sendTicket','David', 'owner', 499997, 499999).
used('sendTicket', 'mail_David_1', 'ticket sender mail', 499998).
wasGeneratedBy('ticket', 'sendTicket', 'ticket to send', 499998).
used('sendTicket', 'ticket', 'ticket sent', 499999).


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
