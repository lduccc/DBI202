# DBI202 – Learning Center Management System

A database project designed to manage the core operations of a learning center.

| Details | Members |
| :--- | :--- |
| **Lecturer:** DO THI THU NGA <br> **Class:** AI2003 <br> **Group:** 2 | • **LE ANH DUC** \| `HE200666` <br> • **TRAN XUAN TUNG** \| `HE200683` <br> • **TRAN MINH DUNG** \| `HE200667` <br> • **NGUYEN TIEN DAT** \| `HE199203` <br> • **VU DUC MINH** \| `HE201162` |
---

## About The Project

This repository contains the complete SQL code for **EducateDB**, which is a database system for learning centers.

### The Problem

Many educational centers still rely on manual methods like spreadsheets and paper records to manage their operations. This often leads to scattered data, scheduling conflicts, inefficient financial tracking, and communication gaps between staff and students. As a center grows, these problems multiply, making it difficult to maintain accuracy and scale effectively.

### Our Solution: EducateDB

**EducateDB** is a centralized database system built to automate and streamline the management process. It aims to:
-   Reduce administrative workload and minimize human error.
-   Improve data accuracy for student records, grades, and finances.
-   Enhance the experience for students, teachers, and admins.
-   Provide a good foundation that can grow with the center.

---
## Setup

You have two options to set up the database.

### Option 1: Full Script

This is the fastest way to get the entire database up and running.

1.  Open the `Script_DB.sql` file.
2.  Copy its contents.
3.  Paste and execute the script in your SQL Server environment (like SSMS).

This single file will create the database, all tables, objects (views, functions, etc.), and populate it with a complete set of sample data.

> **Note:** This full script does not include the sample queries or the commented-out test cases for each individual object. If you'd like to see those, please use Option 2.

### Option 2: Individual Script

You should use this option if you want to test each component individually.

 The scripts in the `sql_scripts/` folder are numbered in the exact order they should be executed.

1.  Navigate to the `sql_scripts/` folder.
2.  Open and run the files one by one, following the numbered order:
    1.  `01_Create_Database.sql` - Creates all the tables and the database structure.
    2.  `02_Insert_Data.sql` - Populates the tables with sample data.
    3.  `03_Create_Views.sql` - Creates all the views.
    4.  `04_Create_Functions.sql` - Creates all the functions.
    5.  `05_Create_Procedures.sql` - Creates all the stored procedures.
    6.  `06_Create_Triggers.sql` - Creates all the triggers.
    7.  `07_Sample_Queries.sql` - Contains various queries to test.

Each file in this folder includes detailed comments and commented-out **test cases**, so you can easily run and test the functionality of each function, procedure, or trigger.

---

Thank you for visiting!