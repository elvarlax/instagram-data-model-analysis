-- Practice Questions

-- JOINS

-- Which users have liked post_id 2?

SELECT u.name
FROM likes l
INNER JOIN users u ON l.user_id = u.user_id
WHERE l.post_id = 2;

-- Which posts have no comments?

SELECT *
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE c.comment_id IS NULL;

-- Which posts were created by users who have no followers?

SELECT *
FROM posts p
LEFT JOIN users u ON p.user_id = u.user_id
LEFT JOIN followers f ON u.user_id = f.user_id
WHERE f.user_id IS NULL;

-- Aggregation

-- How many likes does each post have?

SELECT
    p.post_id,
    p.caption,
    COUNT(l.like_id) AS total_likes
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id, p.caption
ORDER BY total_likes DESC;

-- What is the average number of likes per post?

SELECT
    p.post_id,
    p.caption,
    AVG(l.like_id) AS avg_likes_per_post
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id, p.caption
ORDER BY avg_likes_per_post DESC;

-- Which user has the most followers?

SELECT
    user_id,
    COUNT(*) AS total_followers
FROM followers
GROUP BY user_id
ORDER BY total_followers DESC
LIMIT 1;

-- Window Function

-- Rank the users by the number of posts they have created

SELECT
    user_id,
    COUNT(post_id) AS total_posts,
    RANK() OVER (ORDER BY COUNT(post_id) DESC) AS user_rank
FROM posts
GROUP BY user_id;

-- Rank the posts based on the number of likes

SELECT
    p.post_id,
    COUNT(l.like_id) AS total_likes,
    RANK() OVER (ORDER BY COUNT(l.like_id) DESC) AS post_rank
FROM posts p
INNER JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY total_likes DESC;

-- Find the cumulative number of likes for each post

SELECT
    p.post_id,
    SUM(COUNT(l.like_id)) OVER (ORDER BY p.post_id) AS cumulative_likes
FROM posts p
INNER JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY cumulative_likes DESC;

-- Common Table Expression (CTE)

-- Find all the comments and their users using a CTE

WITH all_comments_and_users AS (
    SELECT *
    FROM comments c
    INNER JOIN users u ON c.user_id = u.user_id
)
SELECT *
FROM all_comments_and_users;

-- Find all the followers and their follower users using a CTE

WITH all_followers_and_follower_users AS (
    SELECT *
    FROM followers f
    INNER JOIN users u ON f.follower_user_id = u.user_id
)
SELECT *
FROM all_followers_and_follower_users;

-- Find all the posts and their comments using a CTE

WITH all_posts_and_comments AS (
    SELECT *
    FROM posts p
    INNER JOIN comments c ON p.post_id = c.post_id
)
SELECT *
FROM all_posts_and_comments;

-- Case Statement

-- Categorize the posts based on the number of likes

SELECT
    post_id,
    COUNT(like_id) AS total_likes,
    CASE
        WHEN COUNT(like_id) >= 10 THEN 'High Liked'
        WHEN COUNT(like_id) >= 5 THEN 'Medium Liked'
        ELSE 'Low Liked'
    END AS like_category
FROM likes
GROUP BY post_id
ORDER BY post_id;

-- Categorize the users based on the number of comments they have made

SELECT
    user_id,
    COUNT(comment_id) AS total_comments,
    CASE
        WHEN COUNT(comment_id) >= 10 THEN 'High Comments'
        WHEN COUNT(comment_id) >= 5 THEN 'Medium Comments'
        ELSE 'Low Comments'
    END AS comment_category
FROM comments
GROUP BY user_id
ORDER BY user_id;

-- Categorize the posts based on their age

SELECT
    post_id,
    EXTRACT(DAY FROM age(CURRENT_TIMESTAMP, created_at)) AS post_age_days,
    CASE
        WHEN EXTRACT(DAY FROM age(CURRENT_TIMESTAMP, created_at)) >= 10 THEN '10 days or older'
        WHEN EXTRACT(DAY FROM age(CURRENT_TIMESTAMP, created_at)) >= 5 THEN '5 to 9 days old'
        ELSE CONCAT(EXTRACT(DAY FROM age(CURRENT_TIMESTAMP, created_at)), ' days old')
    END AS post_age_category
FROM posts
ORDER BY post_id;