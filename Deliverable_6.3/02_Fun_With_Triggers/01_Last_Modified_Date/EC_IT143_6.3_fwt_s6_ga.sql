USE [EC_IT143_DA];
GO

-- The last-modified-date solution is complete, so restart the method with a new question.
-- Next question: How can I keep track of who last modified a record?

SELECT
    'How can I keep track of who last modified a record?' AS next_question,
    SUSER_NAME() AS current_server_user;
GO

