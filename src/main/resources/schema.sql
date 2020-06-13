CREATE TABLE IF NOT EXISTS persistent_logins (
    username varchar(255) NOT NULL,
    series varchar(255) NOT NULL,
    token varchar(255) NOT NULL,
    last_used TIMESTAMP NOT NULL,
    PRIMARY KEY (series)
);