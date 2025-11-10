INSERT INTO tool_category VALUES (1, 'Garden');
INSERT INTO tool_category VALUES (2, 'Power');
INSERT INTO tool_category VALUES (3, 'Hand');
INSERT INTO tool_category VALUES (4, 'Electronics');

INSERT INTO tools VALUES (1000, 'Cordless Drill', 2, 5, 3, TO_DATE('2025-02-01','YYYY-MM-DD'));
INSERT INTO tools VALUES (1001, 'Lawn Mower', 1, 2, 0, TO_DATE('2024-05-15','YYYY-MM-DD'));
INSERT INTO tools VALUES (1002, 'Hammer', 3, 10, 10, TO_DATE('2023-11-01','YYYY-MM-DD'));
INSERT INTO tools VALUES (1003, 'Multimeter', 4, 4, 2, TO_DATE('2022-01-10','YYYY-MM-DD'));

COMMIT;
