/*
https://datalemur.com/questions/pizzas-topping-cost
Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.
Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.

Notes:
Do not display pizzas where a topping is repeated. For example, ‘Pepperoni,Pepperoni,Onion Pizza’.
Ingredients must be listed in alphabetical order. For example, 'Chicken,Onions,Sausage'. 'Onion,Sausage,Chicken' is not acceptable.
*/

--USING INNER JOIN WITH '<' SINCE WE SHOULD KEEP THE INGREDIENT LIST IN ALPHABETIC ORDER (!= WILL PRODUCE, "A,B", "B,A" LIST)
SELECT FIRST_ING.topping_name || ',' || SECOND_ING.topping_name ||',' || THIRD_ING.topping_name AS PIZZA,
FIRST_ING.ingredient_cost + SECOND_ING.ingredient_cost+THIRD_ING.ingredient_cost AS TOTAL_COST
FROM
(SELECT topping_name,ingredient_cost 
FROM pizza_toppings) FIRST_ING
INNER JOIN
(SELECT topping_name,ingredient_cost 
FROM pizza_toppings) SECOND_ING
ON FIRST_ING.topping_name < SECOND_ING.TOPPING_NAME
INNER JOIN 
(SELECT topping_name,ingredient_cost 
FROM pizza_toppings) THIRD_ING
ON SECOND_ING.topping_name < THIRD_ING.TOPPING_NAME
ORDER BY TOTAL_COST DESC, PIZZA ASC
