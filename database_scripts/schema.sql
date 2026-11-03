CREATE DATABASE media_vault;
USE media_vault;

CREATE TABLE IF NOT EXISTS user (
	-- Primary key
	user_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	
	-- attributes
	username VARCHAR(35) NOT NULL UNIQUE,
	password_hash VARCHAR(256) NOT NULL,
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() on UPDATE CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS title (
	-- Primary key
	title_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	
	-- Foreign key(s)
	user_id INT,
	
	-- Attributes
	-- {Genre}
	-- {author}
	title_name VARCHAR(255) NOT NULL,
	origin_country VARCHAR(3),  -- uses ISO 3166-1 alpha 3
	show_or_movie_duration TIME,
	release_date DATE,
	is_series BOOLEAN,
	num_seasons SMALLINT,
	num_episodes SMALLINT,
	series_end_date DATE,
	description VARCHAR(500),
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_title_user FOREIGN KEY(user_id) REFERENCES user(user_id) ON DELETE SET NULL
);


CREATE TABLE IF NOT EXISTS review (
	-- Primary key
	review_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	
	-- Foreign key(s)
	user_id INT,
	title_id INT NOT NULL,
	
	-- Attributes
	personal_rating ENUM('1', '2', '3', '4', '5'),
	viewing_method VARCHAR(255),
	favorite_quote VARCHAR(500),
	review_or_summary TEXT NOT NULL, -- BLOB
	
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_review_user FOREIGN KEY(user_id) REFERENCES user(user_id) ON DELETE SET NULL,
	CONSTRAINT fk_review_tile FOREIGN KEY(title_id) REFERENCES title(title_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS title_report (
	-- Primary key
	report_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	
	-- Foreign key(s)
	title_id INT NOT NULL,
	user_id INT,
	
	-- Attributes
	is_error BOOLEAN,
	error_field VARCHAR(255) NOT NULL,
	status ENUM ('IN_PROGEESS', 'RESOLVED', 'NOT_RESOLVED', 'VIEWED'), -- RESOLVED > IN_PROGRESS > VIEWED > NOT_RESOLVED
	reason VARCHAR(500),
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_title_report_user FOREIGN KEY(user_id) REFERENCES user(user_id) ON DELETE SET NULL,
	CONSTRAINT fk_title_report_title FOREIGN KEY(title_id) REFERENCES title(title_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_title_watchlist (
	-- Primary & Foreign key(s)
	user_id INT  NOT NULL,
	title_id INT NOT NULL,
	PRIMARY KEY(user_id, title_id),
	
	-- Attributes
	watch_status ENUM('WATCHED', 'NOT_WATCHED', 'PARTIALLY_WATCHED', 'CURRENTLY_WATCHING'),
	watched_date DATE,
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_watchlist_user FOREIGN KEY(user_id) REFERENCES user(user_id) ON DELETE CASCADE,
	CONSTRAINT fk_watchlist_title FOREIGN KEY(title_id) REFERENCES title(title_id) ON DELETE CASCADE
);


CREATE TABLE  IF NOT EXISTS author (
	-- Primary key
	author_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	
	-- Attributes
	first_name VARCHAR(50) NOT NULL,
	middle_name VARCHAR(50),
	last_name VARCHAR(50),
	nationality VARCHAR(50),
	date_of_birth DATE,
	date_of_death DATE,
	bio TEXT,
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
);


CREATE TABLE IF NOT EXISTS genre (
	-- Primary key
	genre_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	
	-- Attributes
	genre_name VARCHAR(50),
	description VARCHAR(350),
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
);

CREATE TABLE IF NOT EXISTS title_author (
	-- Primary & Foreign key
	title_id INT NOT NULL,
	author_id INT NOT NULL,
	PRIMARY KEY(title_id, author_id),
	
	-- Attributes
	contribution_role VARCHAR(100),
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_ta_title FOREIGN KEY(title_id) REFERENCES title(title_id)  ON DELETE CASCADE,
	CONSTRAINT fk_ta_author FOREIGN KEY(author_id) REFERENCES author(author_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS title_genre (
	-- Primary Foreign key
	title_id INT NOT NULL,
	genre_id INT NOT NULL,
	PRIMARY KEY(title_id, genre_id),
	
	-- Attributes/Metadata 
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_tg_title FOREIGN KEY(title_id) REFERENCES title(title_id)  ON DELETE CASCADE,
	CONSTRAINT fk_tg_genre FOREIGN KEY(genre_id) REFERENCES genre(genre_id) ON DELETE CASCADE
	
);


CREATE TABLE IF NOT EXISTS `group` (
	-- Primary key
	group_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	
	-- Attributes
	group_name VARCHAR(255),
	description VARCHAR(500),
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
	
);

CREATE TABLE IF NOT EXISTS permission (
	-- Primary key
	permission_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	
	-- Attributes
	permission_name VARCHAR(255),
	description VARCHAR(500),
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP()
	
);


CREATE TABLE IF NOT EXISTS user_group (
	-- Primary key
	user_id INT NOT NULL,
	group_id INT NOT NULL,
	PRIMARY KEY(user_id, group_id),
	
	-- Attributes
	note VARCHAR(500),
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_ug_user FOREIGN KEY(user_id) REFERENCES user(user_id)  ON DELETE CASCADE,
	CONSTRAINT fk_ug_group FOREIGN KEY(group_id) REFERENCES `group`(group_id) ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS group_permission (
	-- Primary key
	group_id INT NOT NULL,
	permission_id INT NOT NULL,
	PRIMARY KEY(group_id, permission_id),
	
	-- Attributes
	note VARCHAR(500),
	permission_expiration_time TIMESTAMP,
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_gp_group FOREIGN KEY(group_id) REFERENCES `group`(group_id) ON DELETE CASCADE,
	CONSTRAINT fk_gp_permission FOREIGN KEY(permission_id) REFERENCES permission(permission_id) ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS user_permission (
	-- Primary key
	user_id INT NOT NULL,
	permission_id INT NOT NULL,
	PRIMARY KEY(user_id, permission_id),
	
	-- Attributes
	note VARCHAR(500),
	permission_expiration_time TIMESTAMP,
	
	-- Metadata
	create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	
	-- Constraints
	CONSTRAINT fk_up_user FOREIGN KEY(user_id) REFERENCES user(user_id)  ON DELETE CASCADE,
	CONSTRAINT fk_up_permission FOREIGN KEY(permission_id) REFERENCES permission(permission_id) ON DELETE CASCADE

);


-- 