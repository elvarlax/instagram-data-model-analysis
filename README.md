# Instagram Data Model and Analysis

This repository hosts the data model and analysis scripts for an application similar to Instagram, implemented using PostgreSQL.

## Entity-Relationship (ER) Model
![Entity-Relationship (ER) Model](https://github.com/elvarlax/instagram-data-model-analysis/blob/main/er_model.jpg)

## Data Model

The data model for this Instagram-like application consists of the following tables:

- `users`: Stores information about the users of the application.
- `posts`: Contains data about the posts made by users.
- `comments`: Stores comments made on posts.
- `likes`: Records likes given to posts by users.
- `followers`: Tracks the followers of users.

```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE
);

CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    caption TEXT,
    image_url VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE comments (
    comment_id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts (post_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE likes (
    like_id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts (post_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE followers (
    follower_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    follower_user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (follower_user_id) REFERENCES users (user_id)
);
```

This data model enables the representation of users, their posts, comments on those posts, likes received by posts, and follower relationships between users.

## Practice Questions

### JOINS

- Which users have liked post_id 2?
- Which posts have no comments?
- Which posts were created by users who have no followers?

### Aggregation

- How many likes does each post have?
- What is the average number of likes per post?
- Which user has the most followers?

### Window Function

- Rank the users by the number of posts they have created.
- Rank the posts based on the number of likes.
- Find the cumulative number of likes for each post.

### Common Table Expression (CTE)

- Find all the comments and their users using a CTE.
- Find all the followers and their follower users using a CTE.
- Find all the posts and their comments using a CTE.

### Case Statement

- Categorize the posts based on the number of likes.
- Categorize the users based on the number of comments they have made.
- Categorize the posts based on their age.

[Click here to access my solution to the practice questions](https://github.com/elvarlax/instagram-data-model-analysis/blob/main/practice_questions.sql)
