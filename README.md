# Relational and Non-Relational Database Query and PL/SQL

## Task 1: Relational Database Design (SQL)

**Description:** Task 1 required the design of a relational database to manage a specific dataset. Below are the key aspects of this task:

- **Database Schema:** I created a well-structured database schema to represent the data entities and their relationships. The schema included tables for various data types, such as users, products, orders, etc.

- **SQL Queries:** To interact with the relational database, I wrote a series of SQL queries. These queries included:
  - **Data Retrieval:** I wrote SELECT statements to retrieve specific data from the database based on various criteria. For example, querying customer information or product inventory levels.
  - **Data Modification:** I used UPDATE and INSERT statements to modify and add new records to the database, ensuring data accuracy.
  - **Transactions:** Transactions were implemented using BEGIN, COMMIT, and ROLLBACK statements to ensure data integrity during complex operations.
  
- **Normalization:** To optimize the database structure, I applied normalization techniques to reduce data redundancy and improve overall data integrity.

**Skills Demonstrated:**
- Database schema design
- SQL query writing and optimization
- Database normalization
- Transaction management

## Task 2: MongoDB Implementation

**Description:** Task 2 involved the implementation of a NoSQL database using MongoDB. Here's a summary of what I accomplished in this task:

- **MongoDB Database:** I created a MongoDB database and collections to store data in a document-oriented format.

- **Data Insertion:** I inserted data into MongoDB collections, representing it as JSON-like documents. This included data related to users, products, and orders.

- **Data Queries:** Using MongoDB's query language, I executed queries to retrieve specific information from the database. This task highlighted the flexibility of NoSQL databases for unstructured or semi-structured data.

**Skills Demonstrated:**
- MongoDB database creation
- Data insertion and retrieval in MongoDB
- Understanding of NoSQL database concepts

## Task 3: PL/SQL Development

**Description:** Task 3 centered on PL/SQL development to enhance database functionality. Here's a summary of this task:

- **Stored Procedures:** I developed stored procedures to encapsulate complex database operations. These procedures facilitated actions such as calculating aggregate values, generating reports, or automating routine tasks.

- **Triggers:** Triggers were implemented to respond to specific database events. For instance, I created triggers to enforce data validation rules, ensuring data consistency.

**Skills Demonstrated:**
- PL/SQL stored procedure development
- Trigger creation and usage

## Task 4: PL/SQL

**Description:**
Task 4 involves PL/SQL development within the context of a simplified TSA (Transportation Security Administration) data model. This task comprises two subparts:

**(a) Stored Procedure prc_insert_review**

- **Objective:** Create a stored procedure named prc_insert_review to facilitate the insertion of new reviews for specific points of interest (POIs).
- **Input Arguments:** The procedure takes four input arguments: p_member_id, p_poi_id, p_review_comment, and p_review_rating.
- **Output Argument:** The procedure includes an output argument, p_output.
- **Functionality:** The procedure validates the provided member ID and POI ID, generates primary key values for the REVIEW table using a sequence, records the review date and time, and handles the necessary data manipulation statements for impacted tables.
- **Restrictions:** The structure of the procedure, including parameter names and order, must not be altered.

**(b) Trigger for Member Recommendations**

- **Objective:** Create a trigger to enforce new business rules related to member recommendations within the TSA system.
- **Rules Enforced:**
  - New members can only be recommended by existing members within the same resort.
  - Existing members who recommend new members receive an additional 10 member points per recommendation.
- **Functionality:** The trigger enforces these rules and performs any necessary actions to maintain data integrity in affected tables.
- **Test Harness:** SQL commands to test the trigger's successful operation are provided as part of the answer.
