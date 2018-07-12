/* SQL Queries */

/* 2.1 SELECT */
/* Task – Select all records from the Employee table. Task – Select all records from the Employee table where last name is King. */
SELECT * FROM EMPLOYEE
WHERE LASTNAME = 'King';

/* Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL. */
SELECT * FROM EMPLOYEE
WHERE FIRSTNAME = 'Andrew' AND REPORTSTO IS NULL;

/* 2.2 ORDER BY */
/* Task – Select all albums in Album table and sort result set in descending order by title. */
SELECT * FROM ALBUM
ORDER BY TITLE DESC;

/* Task – Select first name from Customer and sort result set in ascending order by city */
SELECT FIRSTNAME FROM CUSTOMER
ORDER BY CITY ASC;

/* 2.3 INSERT INTO */
/* Task – Insert two new records into Genre table */
INSERT INTO GENRE(GENREID, NAME) VALUES (26, 'Slow Jam');
INSERT INTO GENRE(GENREID, NAME) VALUES (27, 'Pop Funk');


/* Task – Insert two new records into Employee table */
INSERT INTO Employee (EmployeeId, LastName, FirstName, Title, ReportsTo, BirthDate, HireDate, Address, City, State, Country, PostalCode, Phone, Fax, Email) VALUES (9, 'Kimble', 'James', 'Entertainer', 1, TO_DATE('1920-02-08 00:00:00','yyyy-mm-dd hh24:mi:ss'), TO_DATE('2002-6-15 00:00:00','yyyy-mm-dd hh24:mi:ss'), '12300 Fake Street', 'Nowhere', 'OT', 'Canada', 'T2P 2T3', '+1 (403) 555-5555', '+1 (403) 555-4859', 'kimble@chinookcorp.com');
INSERT INTO Employee (EmployeeId, LastName, FirstName, Title, ReportsTo, BirthDate, HireDate, Address, City, State, Country, PostalCode, Phone, Fax, Email) VALUES (10, 'Howards', 'Annie', 'Assistant to the Sales Manager', 1, TO_DATE('1975-05-30 00:00:00','yyyy-mm-dd hh24:mi:ss'), TO_DATE('2010-10-12 00:00:00','yyyy-mm-dd hh24:mi:ss'), '458 False Ave', 'Jokers', 'OT', 'Canada', 'T2P 2T3', '+1 (403) 555-2134', '+1 (403) 555-4567', 'annie@chinookcorp.com');

/* Task – Insert two new records into Customer table */
INSERT INTO CUSTOMER (CUSTOMERID, FIRSTNAME, LASTNAME, EMAIL) VALUES (60, 'Josh', 'Flanagan', 'jflan@gmail.com');
INSERT INTO CUSTOMER (CUSTOMERID, FIRSTNAME, LASTNAME, EMAIL) VALUES (61, 'Jake', 'Flanagan', 'flanjake@gmail.com');

/* 2.4 UPDATE */
/* Task – Update Aaron Mitchell in Customer table to Robert Walter  */
UPDATE CUSTOMER
    SET FIRSTNAME = 'Robert', LASTNAME = 'Walter'
    WHERE FIRSTNAME = 'Aaron' AND LASTNAME = 'Mitchell';
    
/* Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR” */
UPDATE ARTIST
    SET NAME = 'CCR'
    WHERE NAME = 'Creedence Clearwater Revival';
    
/* 2.5 LIKE */
/* Task – Select all invoices with a billing address like “T%” */
SELECT * FROM INVOICE
    WHERE BILLINGADDRESS LIKE 'T%';
    
/* 2.6 BETWEEN */
/* Task – Select all invoices that have a total between 15 and 50 */
SELECT * FROM INVOICE
    WHERE TOTAL BETWEEN 15 AND 50;
    
/* Task – Select all employees hired between 1st of June 2003 and 1st of March 2004 */
SELECT * FROM EMPLOYEE
    WHERE HIREDATE BETWEEN TO_DATE('2003/06/01', 'yyyy/mm/dd')  AND TO_DATE('2004-04-01', 'yyyy/mm/dd');
    
/* 2.7 DELETE */
/* Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them). */
    
ALTER TABLE INVOICE 
    DROP CONSTRAINT FK_INVOICECUSTOMERID;
    
ALTER TABLE Invoice ADD CONSTRAINT FK_InvoiceCustomerId
    FOREIGN KEY (CustomerId) REFERENCES Customer (CustomerId)
    ON DELETE CASCADE;
    
ALTER TABLE INVOICELINE 
    DROP CONSTRAINT FK_INVOICELINEINVOICEID;
    
ALTER TABLE InvoiceLine ADD CONSTRAINT FK_InvoiceLineInvoiceId
    FOREIGN KEY (InvoiceId) REFERENCES Invoice (InvoiceId)
    ON DELETE CASCADE;    
    
DELETE CUSTOMER
    WHERE FIRSTNAME = 'Robert' AND LASTNAME = 'Walter';
    
/* 3 SQL FUNCTIONS */
/* 3.1 System Defined Functions */
/* Task – Create a function that returns the current time. */
SELECT CURRENT_TIMESTAMP FROM SYS.dual;

/* 3.2 System Defined Aggregate Functions */
/* Task – create a function that returns the length of a mediatype from the mediatype table */
SELECT NAME, LENGTH(NAME) FROM MEDIATYPE;

/*  Task – Create a function that returns the most expensive track */
SELECT NAME, UNITPRICE FROM TRACK
    WHERE UNITPRICE = (SELECT MAX(UNITPRICE) FROM TRACK)
    AND ROWNUM <= 1;

/* 3.3 User Defined Scalar Functions */
/* User Defined Scalar Functions */
/* Task – Create a function that returns the average price of invoiceline items in the invoiceline table */




/* 7. JOIN */
/* 7.1 INNER */
/* Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId. */
SELECT CUSTOMER.LASTNAME || ', ' || CUSTOMER.FIRSTNAME AS NAME, INVOICEID FROM CUSTOMER INNER JOIN INVOICE
ON CUSTOMER.CUSTOMERID = INVOICE.CUSTOMERID;

/* 7.2 OUTER */
/* Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total. */
SELECT CUSTOMER.CUSTOMERID, CUSTOMER.FIRSTNAME, CUSTOMER.LASTNAME, INVOICEID, TOTAL FROM CUSTOMER FULL OUTER JOIN INVOICE
ON CUSTOMER.CUSTOMERID = INVOICE.CUSTOMERID;

/* 7.3 RIGHT */
/* Task – Create a right join that joins album and artist specifying artist name and title. */
SELECT ARTIST.NAME, ALBUM.TITLE FROM ARTIST RIGHT OUTER JOIN ALBUM
ON ARTIST.ARTISTID = ALBUM.ARTISTID;

/* 7.4 CROSS */
/* Task – Create a cross join that joins album and artist and sorts by artist name in ascending order. */
SELECT * FROM ARTIST CROSS JOIN ALBUM
ORDER BY ARTIST.NAME;

/* 7.5 SELF */
/* Task – Perform a self-join on the employee table, joining on the reportsto column. */
SELECT supervised.FIRSTNAME || ' ' || supervised.LASTNAME AS EMPLOYEE, supervisor.FIRSTNAME || ' ' || supervisor.LASTNAME AS REPORTSTO  FROM EMPLOYEE supervised, EMPLOYEE supervisor
WHERE supervised.REPORTSTO = supervisor.EMPLOYEEID;