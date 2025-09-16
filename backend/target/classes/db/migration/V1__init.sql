CREATE TABLE poll (
    id SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE option (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    votes INT NOT NULL DEFAULT 0,
    poll_id INT NOT NULL REFERENCES poll(id) ON DELETE CASCADE
);

-- Sample data
INSERT INTO poll (question) VALUES ('What is your favorite programming language?');
INSERT INTO option (text, poll_id) VALUES 
    ('Java', 1),
    ('Python', 1),
    ('JavaScript', 1),
    ('TypeScript', 1);