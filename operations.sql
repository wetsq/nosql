-- 1. Get current employees on a unit

SELECT e.id, e.name, e.position
FROM employees e
JOIN employee_on_unit eu ON e.id = eu.employee_id
WHERE eu.unit_id = $1 AND eu.end_time IS NULL;