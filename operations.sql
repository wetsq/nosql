-- Queries for 10 use cases with psycopg style parameters

-- 1. Get current employees on a unit

SELECT e.id, e.name, e.position
FROM employees e
JOIN employee_on_unit eu ON e.id = eu.employee_id
WHERE eu.unit_id = %s AND eu.end_time IS NULL;

-- 2. Create a new mission with units

INSERT INTO missions (code, description, status, address, location, units)
VALUES (%s, %s, %s, %s, %s, %s);

-- 3. Start shift on an employee on unit

INSERT INTO employee_on_unit (employee_id, unit_id)
VALUES (%s, %s);

-- 4. End shift on an employee on unit

UPDATE employee_on_unit
SET end_time = CURRENT_TIMESTAMP
WHERE employee_id = %s AND unit_id = %s AND end_time IS NULL;

-- 5. Get status of all units assigned to a mission

SELECT u.name, u.status
FROM units u
JOIN missions m ON u.name = ANY(m.units)
WHERE m.id = %s;

-- 6. Change mission code

UPDATE missions
SET code = %s
WHERE id = %s;

-- 7. Add a unit to an existing mission

UPDATE missions
SET units = array_append(units, %s)
WHERE id = %s;

-- 8. Get all 1st level subordinates of an employee

SELECT e.name, e.position
FROM employees e
JOIN employees s ON e.supervisor_id = s.id
WHERE s.id = %s;

-- 9. Get employees of a given unit at the time of a given mission

SELECT e.name, e.position
FROM employees e
JOIN employee_on_unit eu ON e.id = eu.employee_id
JOIN units u ON eu.unit_id = u.id
JOIN missions m ON u.name = ANY(m.units)
WHERE m.id = %s AND eu.start_time <= m.created_at AND (eu.end_time IS NULL OR eu.end_time >= m.created_at);

-- 10. Set mission as completed and set all unit's status as available

UPDATE missions
SET status = 'completed'
WHERE id = %s;

UPDATE units
SET status = 'available'
WHERE id = ANY((SELECT units FROM missions WHERE id = %s));