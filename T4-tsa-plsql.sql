--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-tsa-plsql.sql

--Student ID: 32509987
--Student Name: Raunak Koirala
--Unit Code: FIT3171
--Applied Class No: A02

/* Comments for your marker:

*/

SET SERVEROUTPUT ON

--4(a) 
-- Create a sequence for REVIEW PK

DROP SEQUENCE reviewpk_seq;

CREATE SEQUENCE reviewpk_seq START WITH 1 INCREMENT BY 1;


-- Complete the procedure below
CREATE OR REPLACE PROCEDURE prc_insert_review (
    p_member_id      IN NUMBER,
    p_poi_id         IN NUMBER,
    p_review_comment IN VARCHAR2,
    p_review_rating  IN NUMBER,
    p_output         OUT VARCHAR2
) AS
  v_member_count NUMBER;
  v_poi_count    NUMBER;
BEGIN
  -- Check if member id is valid
  SELECT COUNT(*)
  INTO v_member_count
  FROM member
  WHERE member_id = p_member_id;

  IF v_member_count = 0 THEN
    p_output := 'Invalid member id.';
    RETURN;
  END IF;

  -- Check if poi id is valid
  SELECT COUNT(*)
  INTO v_poi_count
  FROM point_of_interest
  WHERE poi_id = p_poi_id;

  IF v_poi_count = 0 THEN
    p_output := 'Invalid poi id.';
    RETURN;
  END IF;

  -- Insert review
  INSERT INTO review (review_id, member_id, review_date_time, review_comment, review_rating, poi_id)
  VALUES (reviewpk_seq.NEXTVAL, p_member_id, SYSDATE, p_review_comment, p_review_rating, p_poi_id);

  p_output := 'Review inserted successfully.';
END;
/


-- Write Test Harness for 4(a)

DECLARE
  v_output VARCHAR2(100);
BEGIN
  prc_insert_review(1001, 2001, 'Good place to stay for holidays!!', 5, v_output);
  DBMS_OUTPUT.PUT_LINE(v_output);
END;
/


--4(b) 
--Write your trigger statement, 
--finish it with a slash(/) followed by a blank line

CREATE OR REPLACE TRIGGER trg_member_registration
BEFORE INSERT ON member
FOR EACH ROW
DECLARE
  v_rec_member_id NUMBER;
  v_rec_resort_id NUMBER;
BEGIN
  SELECT member_id_recby, resort_id
  INTO v_rec_member_id, v_rec_resort_id
  FROM member
  WHERE member_id = :NEW.member_id_recby;

  IF v_rec_member_id IS NULL OR v_rec_resort_id IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'Invalid recommending member.');
  END IF;

  IF v_rec_resort_id <> :NEW.resort_id THEN
    RAISE_APPLICATION_ERROR(-20002, 'Recommending member and new member must belong to the same resort.');
  END IF;

  UPDATE member
  SET member_points = member_points + 10
  WHERE member_id = v_rec_member_id;
END;
/


-- Write Test Harness for 4(b)


DECLARE
  v_output VARCHAR2(100);
BEGIN
  -- Inserting a new member recommended by a member from the same resort
  BEGIN
    INSERT INTO member (member_id, resort_id, member_no, member_gname, member_fname, member_haddress, member_email, member_phone, member_date_joined, member_points, member_id_recby)
    VALUES (2004, 1, 1111, 'Sam', 'Jack', '123 Main St', 'sam.jack@gmail.com', '1234567890', SYSDATE, 0, 1002);
    
    DBMS_OUTPUT.PUT_LINE('Member inserted successfully.');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: cannot insert member from different resort');
  END;

  -- Inserting a new member recommended by a member from a different resort
  BEGIN
    INSERT INTO member (member_id, resort_id, member_no, member_gname, member_fname, member_haddress, member_email, member_phone, member_date_joined, member_points, member_id_recby)
    VALUES (2005, 1, 2222, 'John', 'Kent', '456 Uni St', 'john.kent@gmail.com', '9876543210', SYSDATE, 0, 1003);
    
    DBMS_OUTPUT.PUT_LINE('Member inserted successfully.');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: cannot insert member from different resort');
  END;
END;
/


