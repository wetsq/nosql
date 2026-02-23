INSERT INTO employees (name, position, supervisor_id)
VALUES ('John Doe', 'Fire Chief', NULL),
       ('Jane Smith', 'Paramedic Supervisor', NULL);

INSERT INTO employees (name, position, supervisor_id)
VALUES ('John Smith', 'Firefighter', 1),
       ('Jane Doe', 'Paramedic', 2),
       ('Jack Doe', 'Firefighter', 1),
       ('Jack Jackson', 'Paramedic', 2),
       ('Allison Lipsum', 'Student Paramedic', 2),
       ('Bob Brown', 'Senior Firefighter', 1),
       ('Charlie Green', 'Senior Firefighter', 1),
       ('Diana Blue', 'Paramedic', 2);


INSERT INTO units (name, type, capabilities, status, location)
VALUES ('Engine 1', 'Fire Engine', ARRAY['Firefighting', 'Rescue'], 'On Call', '"x"=>"10", "y"=>"20"'),
       ('Ambulance 1', 'Ambulance', ARRAY['Medical'], 'On Call', '"x"=>"15", "y"=>"25"'),
       ('Ladder 1', 'Ladder Truck', ARRAY['Firefighting', 'Rescue'], 'On Call', '"x"=>"10", "y"=>"20"'),
       ('Rescue 1', 'Rescue Vehicle', ARRAY['Rescue'], 'Available', '"x"=>"20", "y"=>"35"'),
      ('Ambulance 2', 'Ambulance', ARRAY['Medical'], 'On Call', '"x"=>"15", "y"=>"25"'),
      ('Engine 2', 'Fire Engine', ARRAY['Firefighting', 'Rescue'], 'On Call', '"x"=>"10", "y"=>"20"'),
      ('Ladder 2', 'Ladder Truck', ARRAY['Firefighting', 'Rescue'], 'Available', '"x"=>"10", "y"=>"20"'),
      ('Rescue 2', 'Rescue Vehicle', ARRAY['Rescue'], 'Available', '"x"=>"20", "y"=>"35"'),
      ('Fire Supervisor 1', 'Fire Supervisor Vehicle', ARRAY['Firefighting', 'Supervisor'], 'Available', '"x"=>"10", "y"=>"20"'),
      ('Paramedic Supervisor 1', 'Paramedic Supervisor Vehicle', ARRAY['Medical', 'Supervisor'], 'Available', '"x"=>"15", "y"=>"25"');


INSERT INTO missions (code, description, status, address, location, units, created_at, updated_at)
VALUES ('"type"=>"401", "urgency"=>"B"', 'Fire at 123 Main St', 'Completed', '123 Main St', '"x"=>"10", "y"=>"20"', ARRAY['Engine 1'], '2026-01-01 14:00:00', '2026-01-01 14:30:00'),
       ('"type"=>"700", "urgency"=>"B"', 'Medical emergency at 456 Elm St', 'Completed', '456 Elm St', '"x"=>"15", "y"=>"25"', ARRAY['Ambulance 1'], '2026-01-01 14:00:00', '2026-01-01 15:00:00'),
       ('"type"=>"402", "urgency"=>"A"', 'Rescue operation at 789 Oak St', 'Completed', '789 Oak St', '"x"=>"20", "y"=>"35"', ARRAY['Fire Supervisor 1', 'Rescue 1', 'Engine 1', 'Engine 2'], '2026-02-15 10:00:00', '2026-02-15 16:00:00'),
        ('"type"=>"701", "urgency"=>"A"', 'Medical emergency at 321 Pine St', 'Completed', '321 Pine St', '"x"=>"15", "y"=>"25"', ARRAY['Paramedic Supervisor 1', 'Ambulance 1', 'Ambulance 2'], '2026-02-15 10:00:00', '2026-02-15 11:00:00'),
        ('"type"=>"431", "urgency"=>"C"', 'Brush fire at 555 Maple St', 'Completed', '555 Maple St', '"x"=>"10", "y"=>"20"', ARRAY['Engine 1'], '2026-02-20 18:00:00', '2026-02-20 19:00:00'),
        ('"type"=>"401", "urgency"=>"B"', 'Fire at 12 Main St', 'Completed', '12 Main St', '"x"=>"10", "y"=>"20"', ARRAY['Engine 1'], '2026-01-15 14:00:00', '2026-01-15 14:30:00'),
       ('"type"=>"700", "urgency"=>"B"', 'Medical emergency at 454 Elm St', 'Completed', '454 Elm St', '"x"=>"15", "y"=>"25"', ARRAY['Ambulance 1'], '2026-01-26 14:00:00', '2026-01-26 15:00:00'),
       ('"type"=>"401", "urgency"=>"B"', 'Rescue operation at 7890 Oak St', 'Ongoing', '7890 Oak St', '"x"=>"20", "y"=>"35"', ARRAY['Engine 1', 'Engine 2'], NOW(), NULL),
        ('"type"=>"701", "urgency"=>"A"', 'Medical emergency at 3210 Pine St', 'Ongoing', '3210 Pine St', '"x"=>"15", "y"=>"25"', ARRAY['Paramedic Supervisor 1', 'Ambulance 1', 'Ambulance 2'], NOW(), NULL),
        ('"type"=>"431", "urgency"=>"C"', 'Brush fire at 5550 Maple St', 'Ongoing', '5550 Maple St', '"x"=>"10", "y"=>"20"', ARRAY['Ladder 1'], NOW(), NULL);


INSERT INTO employee_on_unit (employee_id, unit_id, start_time, end_time)
VALUES (1, 10, '2026-01-01 14:00:00', '2026-01-01 14:30:00'),
       (2, 11, '2026-01-01 14:00:00', '2026-01-01 15:00:00'),
       (3, 1, '2026-02-15 10:00:00', '2026-02-15 16:00:00'),
       (4, 2, '2026-02-15 10:00:00', '2026-02-15 11:00:00'),
       (5, 2, '2026-02-15 10:00:00', '2026-02-15 11:00:00'),
       (6, 1, '2026-02-20 18:00:00', '2026-02-20 19:00:00'),
       (7, 1, '2026-01-15 14:00:00', '2026-01-15 14:30:00'),
       (8, 2, '2026-01-26 14:00:00', '2026-01-26 15:00:00'),
       (9, 1, NOW(), NULL),
       (10, 10, NOW(), NULL),
       (11, 11, NOW(), NULL);

