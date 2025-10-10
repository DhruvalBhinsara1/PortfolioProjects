# SQLite 3 Notes

This folder contains comprehensive notes on SQLite 3 database usage with Python. Each notebook covers a specific aspect of working with SQLite databases.

## Notebooks Overview

### 01_Introduction_to_SQLite.ipynb

- What is SQLite and why use it
- Importing sqlite3 module
- Basic concepts (database, table, row, column, cursor)
- Data types in SQLite

### 02_Connecting_to_SQLite_Database.ipynb

- Creating database connections
- In-memory databases
- Connection properties and settings
- Checking connection status
- Error handling for connections
- Proper connection closing

### 03_Creating_Tables.ipynb

- Basic table creation syntax
- SQLite data types
- Table constraints (PRIMARY KEY, NOT NULL, UNIQUE, DEFAULT, CHECK, FOREIGN KEY)
- Auto-incrementing primary keys
- Verifying table creation
- Dropping tables

### 04_Inserting_Data.ipynb

- Single row inserts
- Multiple row inserts with executemany()
- Using named parameters
- Inserting with default values
- Handling duplicate data (INSERT OR IGNORE, INSERT OR REPLACE)
- Verifying insert operations

### 05_Querying_Data.ipynb

- Basic SELECT queries
- Filtering with WHERE clause
- Sorting results with ORDER BY
- Limiting results with LIMIT and OFFSET
- Aggregate functions (COUNT, SUM, AVG, MIN, MAX)
- GROUP BY and HAVING clauses
- Joining tables
- Using parameters in queries

### 06_Updating_Data.ipynb

- Basic UPDATE syntax
- Updating multiple columns
- Conditional updates
- Using parameters in updates
- Updating with subqueries
- Checking update results
- Best practices for safe updates

### 07_Deleting_Data.ipynb

- Basic DELETE syntax
- Conditional deletes
- Using parameters in deletes
- DELETE with subqueries and LIMIT
- Verifying delete results
- Safe delete practices
- TRUNCATE vs DELETE

### 08_Using_Placeholders.ipynb

- SQL injection vulnerabilities
- Using positional placeholders (?)
- Using named placeholders (:name)
- Placeholders with executemany()
- Dynamic queries with placeholders
- Common SQL injection attack vectors
- Best practices for security

### 09_Transactions.ipynb

- What are transactions and ACID properties
- Auto-commit vs explicit transactions
- Money transfer example
- Rollback on errors
- Using context managers
- Transaction isolation levels
- Savepoints for partial rollbacks
- Best practices for transactions

### 10_Error_Handling.ipynb

- SQLite exception hierarchy
- Handling constraint violations
- Operational error handling
- Connection errors
- Transaction error handling
- Using context managers for errors
- Custom error classes
- Logging errors
- Best practices for error handling

### 11_Best_Practices.ipynb

- Connection management with context managers
- Parameterized queries for security
- Proper transaction handling
- Specific error handling
- Database schema management with migrations
- Connection pooling
- Performance optimization (indexing, batch operations)
- Security considerations
- Backup and recovery procedures
- Monitoring and logging

## Prerequisites

- Python 3.x
- sqlite3 module (built-in with Python)

## Getting Started

1. Start with `01_Introduction_to_SQLite.ipynb` to understand the basics
2. Follow the notebooks in numerical order for a complete learning path
3. Each notebook contains practical examples and code snippets
4. Run the code cells to see SQLite in action

## Key Concepts Covered

- Database connections and cursors
- SQL commands (CREATE, INSERT, SELECT, UPDATE, DELETE)
- Data types and constraints
- Transactions and ACID properties
- Error handling and exceptions
- Security best practices (preventing SQL injection)
- Performance optimization
- Database design principles

## Resources

- [SQLite Official Documentation](https://www.sqlite.org/docs.html)
- [Python sqlite3 Documentation](https://docs.python.org/3/library/sqlite3.html)
- [SQL Tutorial](https://www.w3schools.com/sql/)

## Tips

- Always use parameterized queries to prevent SQL injection
- Use transactions for related database operations
- Handle exceptions properly with try-except blocks
- Close database connections when done
- Consider using context managers for automatic resource management
- Create appropriate indexes for better performance
- Regularly backup your databases

Happy learning! 🚀
