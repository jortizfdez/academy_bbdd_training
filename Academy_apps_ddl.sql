-- academy.companies definition
CREATE TABLE academy.companies (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(300) NOT NULL,
	deleted BOOL NOT NULL DEFAULT false,
	UNIQUE KEY companies_name_key (name)
);

-- academy.users definition
CREATE TABLE academy.users (
	id INT AUTO_INCREMENT PRIMARY KEY,
	client_identifier VARCHAR(255) NOT NULL,
	created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modified_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	deleted BOOLEAN NOT NULL DEFAULT false,
	email VARCHAR(255) NULL,
	id_santanderid INT NULL,
	company_id INT NULL,
	CONSTRAINT users_client_identifier_key UNIQUE (client_identifier),
	CONSTRAINT users_santanderid_key UNIQUE (id_santanderid),
	CONSTRAINT users_company_id_foreign FOREIGN KEY (company_id) REFERENCES academy.companies (id)
);

-- academy.apps definition
CREATE TABLE academy.apps (
	id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	geography VARCHAR(255) NOT NULL,
	acronym VARCHAR(10) NOT NULL,
	link VARCHAR(25) NOT NULL,
	icon VARCHAR(25) NULL,
	active BOOL NOT NULL DEFAULT true,
	created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modified_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- academy.user_apps definition
CREATE TABLE academy.user_apps (
    user_id int NOT NULL,
    app_id int NOT NULL,
    CONSTRAINT user_apps_user_id_fk FOREIGN KEY (user_id) REFERENCES academy.users (id),
    CONSTRAINT user_apps_app_id_fk FOREIGN KEY (app_id) REFERENCES academy.apps (id),
    CONSTRAINT user_apps_pk PRIMARY KEY (user_id, app_id)
);