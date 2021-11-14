/* 
You vaguely remember that the crime
was a ​ murder​ that occurred sometime on ​ Jan.15, 2018​ 
and that it took place in ​ SQL City​.
*/




-- Querying crime_scene_report...
SELECT * FROM crime_scene_report WHERE date = 20180115 AND city = "SQL City";
-- Yields...
/*
20180115|assault|Hamilton: Lee, do you yield? Burr: You shot him in the side! Yes he yields!|SQL City

20180115|assault|Report Not Found|SQL City

20180115|murder|Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave".|SQL City
*/



-- Querying person...
SELECT * FROM person WHERE name LIKE "%Annabel%" AND address_street_name = "Franklin Ave";
SELECT * FROM person WHERE address_street_name = "Northwestern Dr" ORDER BY address_number DESC LIMIT 1;
-- Yields...
/*
16371|Annabel Miller|490173|103|Franklin Ave|318771143
14887|Morty Schapiro|118009|4919|Northwestern Dr|111564949
*/



-- Querying interviews...
SELECT * FROM interview WHERE person_id = 16371;
SELECT * FROM interview WHERE person_id = 14887;
-- Yields...
/*
16371|I saw the murder happen, and I recognized the killer from my gym 
when I was working out last week on January the 9th.

14887|I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z". 
Only gold members have those bags. The man got into a car with a plate that included "H42W".
*/



-- Querying person, drivers_license, get_fit_now_member and get_fit_now_check_in...
SELECT * 
FROM person 
WHERE license_id 
IN (SELECT id 
    FROM drivers_license 
    WHERE plate_number 
    LIKE "%H42W%"
) 
AND id 
IN (SELECT person_id 
    FROM get_fit_now_member 
    WHERE membership_status = "gold" 
    AND id 
    LIKE "48Z%" 
    AND id 
    IN (SELECT membership_id 
        FROM get_fit_now_check_in 
        WHERE check_in_date = 20180109
    )
);
-- Yields...
/*
67318|Jeremy Bowers|423327|530|Washington Pl, Apt 3A|871539279
*/



-- Querying facebook_event_checkin...
SELECT * FROM facebook_event_checkin WHERE person_id IN (SELECT id FROM person WHERE name = "Jeremy Bowers");
-- Yields...
/*
67318|4719|The Funky Grooves Tour|20180115
67318|1143|SQL Symphony Concert|20171206

Not entirely sure what this table and the income table have to do with anything,
There's no relevant information in either.
*/



-- Submitting Jeremy Bowers as the suspect...
INSERT INTO solution VALUES (1, "Jeremy Bowers");

-- Querying...
SELECT value FROM solution;
-- Yields...
/*
Congrats, you found the murderer! But wait, there's more... 
If you think you're up for a challenge, 
try querying the interview transcript of the murderer 
to find the real villain behind this crime. 
If you feel especially confident in your SQL skills, 
try to complete this final step with no more than 2 queries. 
Use this same INSERT statement with your new suspect to check your answer.
*/



-- Querying interview...
SELECT * FROM interview WHERE person_id IN (SELECT id FROM person WHERE name = "Jeremy Bowers");
-- Yields...
/*
67318|I was hired by a woman with a lot of money. 
I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017.
*/


-- Querying person, income, drivers_license, facebook_event_checkin... 
SELECT * 
FROM person 
WHERE ssn 
IN (SELECT ssn 
    FROM 
    income 
    WHERE 
    annual_income >= 100000
) 
AND license_id 
IN (SELECT id 
    FROM drivers_license 
    WHERE gender = "female" 
    AND car_make = "Tesla" 
    AND car_model = "Model S" 
    AND hair_color = "red" 
    AND height 
    BETWEEN 64 AND 68
) 
AND id 
IN (SELECT person_id 
    FROM facebook_event_checkin 
    WHERE event_name = "SQL Symphony Concert" 
    AND date 
    BETWEEN 20171201 
    AND 20171231
);
-- Yields...
/*
99716|Miranda Priestly|202298|1883|Golden Ave|987756388
*/



-- Submitting Miranda Priestly as the suspect...
INSERT INTO solution VALUES (1, "Miranda Priestly");

-- Querying...
SELECT value FROM solution;
-- Yields...
/*
Congrats, you found the brains behind the murder! 
Everyone in SQL City hails you as the greatest SQL detective of all time. 
Time to break out the champagne!
*/