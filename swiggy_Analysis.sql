create database swiggy_analysis;
use swiggy_analysis;

-- 1.List all restaurants available in each city.
select distinct city,restaurant from swiggy
order by city,restaurant;

-- 2.Find the top 10 highest-rated restaurants.
select city,restaurant,avg_ratings from swiggy
order by avg_ratings desc,restaurant ASC limit 10;

-- 3.Count the number of restaurants in every city.
select city,count(distinct restaurant) as number_of_restaurants from swiggy
group by city
order by count(*) desc;

-- 4.Find the average price of restaurants in each city.
select city,avg(price) as average_price from swiggy
group by city;

-- 5.List restaurants having ratings greater than 4.5.
select city,restaurant,avg_ratings from swiggy
where avg_ratings>4.5;

-- 6.Find the most expensive restaurants.
select city,restaurant,price from swiggy
where price in (select max(price) from swiggy);


-- 7.Count restaurants by Food Type.
select food_type,count(restaurant) as total_restaurants from swiggy
group by food_type 
order by total_restaurants desc;


-- 8.Find the highest-rated restaurant in every city.
SELECT
    s.city,
    s.restaurant,
    s.avg_ratings
FROM swiggy s
JOIN
(SELECT city,MAX(avg_ratings) AS highest_rating FROM swiggy GROUP BY city) t
ON s.city = t.city
AND s.avg_ratings = t.highest_rating
ORDER BY s.city;

-- 9.Find the average delivery time in every city.
select city,Avg(delivery_time) as average_delivery_time from swiggy
group by city
order by average_delivery_time;


-- 10.Find the top 5 most expensive restaurants in every city.
with restaurant_rank as
(
select city,restaurant,price,row_number()
over(partition by city order by price desc) as rnk
from swiggy
)
select city,restaurant,price from restaurant_rank
where rnk <=5
order by city,rnk;


-- 11.Compare average ratings of each food type.
select avg(avg_ratings) as average_rating,food_type from swiggy
group by food_type
order by average_rating desc;


-- 12.Find restaurants with above-average ratings.
SELECT
    restaurant,
    avg_ratings
FROM swiggy
WHERE avg_ratings >
(SELECT AVG(avg_ratings) FROM swiggy)
ORDER BY avg_ratings DESC;

-- 13.Count restaurants available in every area.
select area,count(restaurant) as count_restaurants from swiggy
group by area;


-- 14.Find cities having more than 100 restaurants.
select city,count(restaurant) as restaurant_counts from swiggy
group by city
having count(restaurant) > 100
order by restaurant_counts desc;

-- 15.Find restaurants whose delivery time is below the city average.
select s.city,s.restaurant,s.delivery_time from swiggy s
join
(select city,avg(delivery_time) as average_delivery_time from swiggy group by city) t
on s.city = t.city
where s.delivery_time < t.average_delivery_time
order by s.city,s.delivery_time;


-- 16.Find the food type having the highest average rating.
select food_type,avg(avg_ratings) as highest_average_rating from swiggy
group by food_type
order by highest_average_rating desc
limit 1;


-- 17.Rank restaurants within every city based on rating.
select * from swiggy;
select city,restaurant,Avg_ratings,dense_rank() over(partition by city order by Avg_ratings desc) as Restaurant_rank from swiggy
order by city,Restaurant_rank,restaurant;


-- 18.Rank restaurants based on shortest delivery time.
select restaurant,delivery_time,dense_rank() over(order by delivery_time asc) as restaurant_rank from swiggy
order by restaurant_rank,delivery_time;


-- 19.Find the top 3 restaurants in every city based on ratings.
select * from (select city,restaurant,avg_ratings,row_number() over(partition by city order by avg_ratings desc) as restaurant_rank from swiggy) t
where restaurant_rank <=3
order by city,restaurant_rank;


-- 20.Find restaurants whose price is higher than the average price of their city.
select s.city,s.restaurant,s.price,t.average_price from swiggy s
join 
(select city,avg(price) as average_price from swiggy group by city)t
on s.city = t.city
and s.price > t.average_price
order by s.city,s.price desc;


-- 21.Find the city having the highest average restaurant rating.
select city,avg(avg_ratings) as avg_ratings from swiggy
group by city
order by avg_ratings desc limit 1;


-- 22.Find restaurants having both high ratings and low delivery time.
select restaurant,avg_ratings,delivery_time from swiggy
where avg_ratings > (select avg(avg_ratings) from swiggy)
and delivery_time < (select avg(delivery_time) from swiggy)
order by delivery_time asc ,avg_ratings desc;


-- 23.Prepare a city-wise dashboard showing:
-- Total Restaurants
-- Average Price
-- Average Rating
-- Average Delivery Time

select city,count(restaurant) as ToTal_restaurants,avg(price) as Average_price,
avg(avg_ratings) as Average_ratings,avg(delivery_time) as Average_delivery_time from swiggy
group by city;


-- 24.Rank food types by popularity using total ratings.
SELECT
    food_type,
    total_ratings,
    DENSE_RANK() OVER (ORDER BY total_ratings DESC) AS food_rank
FROM swiggy;









































