# Library Management System (SQL Project)
![library_management_EER](https://github.com/user-attachments/assets/8c95b2d9-32bf-4f53-b68c-559c771cc6a3)


## 📌 Overview
This is a **Library Management System** built using **MySQL**. It manages books, publishers, and other related data efficiently using a structured database design.

## 🏗 Database Schema
- **Publisher Table**: Stores publisher details.
- **Books Table**: Stores book details, linked to publishers.

## 📜 SQL Features Used
✔ **Primary Keys & Foreign Keys**  
✔ **Auto Increment for Book ID**  
✔ **Joins for Data Relationships**  
✔ **Basic Queries & Data Retrieval**  

## 🔍 Sample Queries
**Get All Books with Publisher Details**  
```sql
SELECT Books.book_BookID, Books.book_Title, Publisher.publisher_PublisherName
FROM Books
JOIN Publisher ON Books.book_PublisherName = Publisher.publisher_PublisherName;
```

## 🚀 How to Run
1. **Import the Database**
   ```sql
   SOURCE libraryProject.sql;
   ```
2. **Run Queries**
   ```sql
   SELECT * FROM Books;
   ```

## 📂 File Structure
📁 `library_management_sql/`  
   ├── 📄 `libraryProject.sql` (Database Schema & Data)  
   ├── 📄 `README.md` (Project Documentation)  

## ✅ Next Steps
- Add **more tables for Members & Borrowing Records**
- Create **Stored Procedures & Triggers** for automation
- Optimize queries with **Indexes & Performance Tuning**

---
💡 **Contributions are welcome!** If you'd like to enhance this project, feel free to fork and submit a pull request. 🚀
