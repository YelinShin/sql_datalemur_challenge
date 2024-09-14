/*
https://datalemur.com/questions/repeated-payments
Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure or a retry error that causes a credit card to be charged twice.
Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.

Assumptions:
The first transaction of such payments should not be counted as a repeated payment. This means, if there are two transactions performed by a merchant with the same credit card and for the same amount within 10 minutes, there will only be 1 repeated payment.
*/

--USING INNERJOIN TO DETECT REPEATED PAYMENT
SELECT count(*) as payment_count
FROM transactions FIRST_TRANS
INNER JOIN
(SELECT *
FROM transactions) OTHER_TRANS
ON FIRST_TRANS.merchant_id = OTHER_TRANS.merchant_id
AND FIRST_TRANS.credit_card_id = OTHER_TRANS.credit_card_id
AND FIRST_TRANS.amount = OTHER_TRANS.amount
AND FIRST_TRANS.transaction_timestamp < OTHER_TRANS.transaction_timestamp
AND OTHER_TRANS.transaction_timestamp <=  FIRST_TRANS.transaction_timestamp + INTERVAL '10 minute'
