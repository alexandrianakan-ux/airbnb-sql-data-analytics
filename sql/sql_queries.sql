-- 1o ερωτημα--
SELECT COUNT(*) AS number_of_properties 
FROM listings;

-- 2o ερωτημα--
SELECT COUNT(*) AS number_of_reviews 
FROM reviews;

-- 3o ερωτημα--
SELECT COUNT(*) AS number_of_bookings 
FROM calendar WHERE available=0 ;

-- 4o ερωτημα--
SELECT COUNT(DISTINCT host_id) AS number_of_hosts 
FROM listings;

-- 5o ερωτημα--
SELECT DISTINCT neighbourhood_cleansed 
FROM listings;

-- 6o ερωτημα--
SELECT neighbourhood_cleansed, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM listings) AS percentage
FROM listings 
GROUP BY neighbourhood_cleansed;

-- 7o ερωτημα--
SELECT host_is_superhost, COUNT(*) AS total_listings
FROM listings
WHERE host_is_superhost IS NOT NULL
GROUP BY host_is_superhost
ORDER BY total_listings DESC;

-- 8o ερωτημα--
SELECT host_id, host_name,
     COUNT(*) AS number_of_houses_of_each_one 
FROM listings 
GROUP BY host_id, host_name ;

-- 9o ερωτημα--
SELECT * 
FROM listings 
WHERE neighbourhood_cleansed LIKE 'Π%';

-- 10o ερωτημα--
SELECT * 
FROM listings 
WHERE price BETWEEN 0 AND 100;

-- 11o ερωτημα--
SELECT l.* 
FROM listings l
WHERE NOT EXISTS (
    SELECT 1 
    FROM reviews r 
    WHERE r.listing_id = l.id);

-- 12o ερωτημα--
SELECT COUNT(DISTINCT host_id) AS number_of_hosts_that_have_profile_pic 
FROM listings 
WHERE host_has_profile_pic = 1 ;

-- 13o ερωτημα--
SELECT neighbourhood_cleansed, AVG(price) AS avg_price 
FROM listings 
GROUP BY neighbourhood_cleansed;

-- 14o ερωτημα--
SELECT TOP(1) property_type, AVG(price) AS avg_price 
FROM listings 
GROUP BY property_type 
ORDER BY avg_price DESC;

-- 15o ερωτημα--
SELECT neighbourhood_cleansed, AVG(price) AS avg_price 
FROM listings 
GROUP BY neighbourhood_cleansed 
HAVING AVG(price)>200;

-- 16ο ερωτημα--
SELECT l.property_type, COUNT(*) AS total_number_of_bookings
FROM listings l
INNER JOIN calendar c ON l.id = c.listing_id
WHERE c.available = 0 
GROUP BY l.property_type;

-- 17ο ερωτημα--
SELECT TOP 1 l.room_type, COUNT(r.id) AS total_number_of_reviews
FROM listings l
INNER JOIN reviews r ON l.id = r.listing_id 
GROUP BY l.room_type
ORDER BY total_number_of_reviews DESC;

-- 18ο ερωτημα--
SELECT l.name, l.host_name, l.price, 
    COUNT(r.id) AS total_number_of_reviews,
    (SELECT COUNT(*) FROM calendar c WHERE c.listing_id = l.id AND c.available = 0) AS total_bookings
FROM listings l
LEFT JOIN reviews r ON l.id = r.listing_id
GROUP BY l.id, l.name, l.host_name, l.price;
    