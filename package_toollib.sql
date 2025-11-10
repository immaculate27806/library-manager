CREATE OR REPLACE PACKAGE toollib_pkg IS
  TYPE t_tool_rec IS RECORD (
    tool_id tools.tool_id%TYPE,
    name tools.name%TYPE,
    category_id tools.category_id%TYPE,
    total_qty tools.total_qty%TYPE,
    available_qty tools.available_qty%TYPE,
    last_maintenance tools.last_maintenance%TYPE
  );

  TYPE tt_tool_table IS TABLE OF t_tool_rec;
  TYPE ta_cat_count IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
  TYPE tv_urgent IS VARRAY(5) OF t_tool_rec;

  PROCEDURE generate_maintenance_report(p_days_since_maint IN NUMBER, p_top_n IN NUMBER := 5);
END toollib_pkg;
/
CREATE OR REPLACE PACKAGE BODY toollib_pkg IS
  PROCEDURE generate_maintenance_report(p_days_since_maint IN NUMBER, p_top_n IN NUMBER := 5) IS
    l_tools_due tt_tool_table;
    l_cat_counts ta_cat_count;
    l_urgent tv_urgent := tv_urgent();
    l_row t_tool_rec;
    idx PLS_INTEGER := 0;

    CURSOR c_old_tools IS
      SELECT * FROM tools
      WHERE NVL(last_maintenance, DATE '1900-01-01') <= SYSDATE - p_days_since_maint
      ORDER BY NVL(last_maintenance, DATE '1900-01-01');

  BEGIN
    OPEN c_old_tools;
    FETCH c_old_tools BULK COLLECT INTO l_tools_due;
    CLOSE c_old_tools;

    IF l_tools_due.COUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No tools due for maintenance.');
      RETURN;
    END IF;

    -- Count by category using associative array
    FOR i IN 1 .. l_tools_due.COUNT LOOP
      idx := l_tools_due(i).category_id;
      IF l_cat_counts.EXISTS(idx) THEN
        l_cat_counts(idx) := l_cat_counts(idx) + 1;
      ELSE
        l_cat_counts(idx) := 1;
      END IF;
    END LOOP;

    -- GOTO example (retry logic)
    FOR i IN 1 .. l_tools_due.COUNT LOOP
      l_row := l_tools_due(i);
      DECLARE
        tries NUMBER := 0;
        done BOOLEAN := FALSE;
      BEGIN
        retry_check:
          tries := tries + 1;
          IF l_row.available_qty IS NULL AND tries < 3 THEN
            GOTO retry_check;
          END IF;
          done := TRUE;
        IF done AND l_urgent.COUNT < LEAST(p_top_n, 5) THEN
          l_urgent.EXTEND;
          l_urgent(l_urgent.COUNT) := l_row;
        END IF;
      END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('=== Maintenance Summary ===');
    idx := l_cat_counts.FIRST;
    WHILE idx IS NOT NULL LOOP
      DBMS_OUTPUT.PUT_LINE('Category ' || idx || ' => ' || l_cat_counts(idx));
      idx := l_cat_counts.NEXT(idx);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Top urgent tools:');
    FOR i IN 1 .. l_urgent.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE('- ' || l_urgent(i).name || ' (' || TO_CHAR(l_urgent(i).last_maintenance, 'YYYY-MM-DD') || ')');
    END LOOP;
  END;
END toollib_pkg;
/
