-- PostgreSQL database schema

CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    supervisor_id INT REFERENCES employees(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS missions (
    id SERIAL PRIMARY KEY,
    code HSTORE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT NULL,
    units VARCHAR(255)[],
    status VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    location HSTORE
);

CREATE TABLE IF NOT EXISTS units (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    capabilities VARCHAR(255)[],
    status VARCHAR(50) NOT NULL,
    location HSTORE
);

CREATE TABLE IF NOT EXISTS employee_on_unit (
    employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
    unit_id INT REFERENCES units(id) ON DELETE CASCADE,
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP default NULL,
    PRIMARY KEY (employee_id, start_time)
);

-- indexes

CREATE INDEX units_name_idx ON units(name);
CREATE INDEX units_location_idx ON units USING GIN (location);

CREATE INDEX employees_name_idx ON employees(name);

CREATE INDEX employee_on_unit_start_time_idx ON employee_on_unit(start_time DESC);
CREATE INDEX missions_created_at_idx ON missions(created_at DESC);