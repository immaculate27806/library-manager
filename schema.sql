CREATE TABLE tool_category (
  category_id NUMBER PRIMARY KEY,
  name VARCHAR2(100)
);

CREATE TABLE tools (
  tool_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  category_id NUMBER REFERENCES tool_category(category_id),
  total_qty NUMBER DEFAULT 1,
  available_qty NUMBER DEFAULT 1,
  last_maintenance DATE
);

CREATE TABLE transactions (
  trans_id NUMBER PRIMARY KEY,
  tool_id NUMBER REFERENCES tools(tool_id),
  member_name VARCHAR2(100),
  trans_type VARCHAR2(10), -- BORROW or RETURN
  trans_date DATE,
  due_date DATE
);

CREATE SEQUENCE seq_tool START WITH 1000;
CREATE SEQUENCE seq_trans START WITH 5000;
