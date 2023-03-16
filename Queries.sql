-- a) Show the call id of all calls that were made between 8am and 10am on June 2018 having duration < 30
  SELECT id AS call_id
	FROM callT
	WHERE date_call BETWEEN '2018-06-01' AND '2018-06-30' AND 
                     hour_call BETWEEN '08:00:00' AND '10:00:00' AND duration < 30;
                            
-- b) Show the first and last name of customers that live in a city with population greater than 20000
SELECT first_name, last_name
	FROM customer,city
	WHERE customer.city_id = city.id AND population > 20000;

-- c) Show the customer id that have a contract in the plan with name LIKE ‘Freedom’ (use nested queries). 
SELECT DISTINCT contract.customer_id 
		FROM contract 
		WHERE contract.plan_id IN 
				(SELECT plan.id FROM plan WHERE plan_name LIKE 'Freedom' )
		ORDER BY customer_id;
                                                                                              
/*d) For each contract that ends in less than sixty days from today, show the contract id,
      the phone number, the customer’s id, his/her first name and his/her last name. */
SELECT customer.id AS customer_id,first_name,last_name,contract.id AS contract_id,phone_number
	FROM customer,contract
    WHERE customer.id = contract.customer_id  AND datediff(ending_date,curdate()) < 60;
    
-- e) For each contract id and each month of 2018, show the average duration of calls 
-- e) For each contract id and each month of 2018, show the average duration of calls 
SELECT contract_id AS contractId ,MONTH(date_call) AS month, avg(duration) AS avg_duration
	FROM callT
    WHERE YEAR(date_call) = '2018'
	GROUP BY contractId,month
    ORDER BY contractId,month;
    
-- f) Show the total duration of calls in 2018 per plan id
SELECT plan.id AS plan_id, SUM(duration) AS total_duration
	FROM callT,plan,contract
    WHERE plan.id = contract.plan_id  AND contract.id = callT.contract_id AND YEAR(date_call) = '2018'
    GROUP BY plan.id
    ORDER BY plan_id;
    
-- g) Show the top called number among TP’s customers in 2018  
 SELECT phone_number,SUM(duration) AS max_duration
	FROM callT
    WHERE YEAR(date_call) = '2018' AND phone_number IN 
                                        (SELECT phone_number
											FROM contract
                                            WHERE contract.phone_number = callT.phone_number)
	GROUP BY phone_number
    ORDER BY max_duration DESC
    LIMIT 1;
    
/*h. Show the contract ids and the months where the total duration
     of the calls was greater than the free minutes offered by the plan of the contract */ 
  SELECT contract.id AS contractId,MONTH(date_call) AS month,SUM(duration) AS sum_duration
	FROM contract,callT,plan
	WHERE callT.contract_id = contract.id AND contract.plan_id = plan.id
	GROUP BY contractId,month,minutes
    HAVING sum_duration > minutes
    ORDER BY contractId,month,minutes;
    
-- i)For each month of 2018, show the percentage change of the total duration of calls compared to the same month of 2017
SELECT month2018, ((duration2018.sum2018 - duration2017.sum2017)/duration2017.sum2017)*100 AS percentage_change
	FROM (SELECT MONTH(date_call) AS month2017,SUM(duration) AS sum2017  FROM CallT WHERE YEAR(date_call) = '2017' GROUP BY MONTH(date_call)) AS duration2017,
		 (SELECT MONTH(date_call) AS month2018,SUM(duration) AS sum2018   FROM CallT WHERE YEAR(date_call) = '2018' GROUP BY MONTH(date_call)) AS duration2018
    GROUP BY month2017,month2018
    HAVING month2017 = month2018
    ORDER BY month2017,month2018;
    
/* j)For each city id and calls made in 2018, show the average call duration
   by females and the average call duration by males (i.e. three columns) */
SELECT cityM,male_avg.male_duration AS avg_male,female_avg.female_duration AS avg_female
	FROM (SELECT city_id AS cityM,avg(duration) AS male_duration   FROM callT,customer,contract
				WHERE gender = 'm' AND customer.id = contract.customer_id AND contract.id = callT.contract_id AND YEAR(date_call) = '2018' 
                GROUP BY city_id) AS male_avg,
		 (SELECT city_id AS cityF,avg(duration) AS female_duration   FROM callT,customer,contract 
			    WHERE gender = 'f' AND customer.id = contract.customer_id AND contract.id = callT.contract_id AND YEAR(date_call) = '2018' 
                GROUP BY city_id) AS female_avg
    GROUP BY cityM,cityF
    HAVING cityM = 	cityF
    ORDER BY cityM,cityF;
    
   /* k. For each city id, show the city id, the ratio of the total duration of the calls made from customers staying in that city 
	in 2018 over the total duration of all calls made in 2018, and the ratio of the city’s population over the total population of all cities (i.e three columns) */
SELECT cityPop , Duration.sum_duration / total_duration.total AS ratio_duration , Population.population /SUM(city.population) AS ratio_population
	FROM (SELECT city_id AS cityDur,SUM(duration) AS sum_duration   FROM callT,customer,contract 
			WHERE customer.id = contract.customer_id AND contract.id = callT.contract_id AND YEAR(date_call) = '2018'  GROUP BY city_id) AS Duration,
		 (SELECT city_id AS cityPop,population   FROM callT,customer,contract,city 
			WHERE city.id = customer.city_id AND customer.id = contract.customer_id AND contract.id = callT.contract_id GROUP BY city_id) AS Population,
         (SELECT sum(duration) AS total FROM callT WHERE YEAR(date_call) = '2018') total_duration,
         city
    GROUP BY cityDur,cityPop
    HAVING cityDur = cityPop
    ORDER BY cityDur,cityPop;

                            
  
  
  
  