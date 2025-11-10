# 🧰 Urban Community Tool Library Manager
### PL/SQL Collections, Records, and GOTO Statements  
**Student Name:** Mutarutwa Immaculate  
**Student ID:** 27806  

---

## 🧩 Problem Definition

### Context:
A community organization manages a shared tool library where members borrow and return tools such as drills, hammers, and lawnmowers. The organization needs an automated system to track inventory, manage maintenance schedules, and identify under-maintained or overused tools.

### Business Requirements:

- Store and process information for multiple tools efficiently.  
- Record borrow and return transactions with accurate quantity updates.  
- Generate maintenance reports for tools that require inspection.  
- Categorize tools by maintenance priority.  
- Identify tools that need immediate servicing or replacement.  

### Technical Challenges:

- Managing heterogeneous data (categories, tools, transactions).  
- Processing multiple records and maintaining relationships between them.  
- Handling missing or inconsistent maintenance data.  
- Implementing structured and controlled flow logic using GOTO for error recovery.  

---

## 🧱 Solution Architecture

### Data Structures Used

#### **Collections**
- **VARRAY:**  
  Used to store a fixed number of tools (max 5) that are urgently due for maintenance.  
- **Nested Table:**  
  Holds dynamic sets of tool records fetched for maintenance processing.  
- **Associative Array:**  
  Stores maintenance counts per category (key = category ID, value = count).  

#### **Records**
- **User-Defined Record:**  
  Represents a complete tool profile including ID, name, category, quantity, and last maintenance date.  
- **Composite Record:**  
  Embeds the record type within a collection to handle multiple tools simultaneously.  

#### **GOTO Statements**
- Used for **controlled error recovery** and **label-based branching** in data validation logic.  
- Demonstrates PL/SQL’s label and retry flow handling.  

---

## 💡 Key Concepts Demonstrated

### 1. **VARRAY (Variable-Size Array)**
- Stores up to 5 urgent tools needing maintenance.  
- Demonstrates `.EXTEND` and index-based access.  
- Provides a controlled upper limit for critical tool processing.  

### 2. **Nested Table**
- Used to hold all tools due for maintenance dynamically.  
- Can grow or shrink as new data is fetched.  
- Demonstrates flexibility for real-time maintenance report generation.  

### 3. **Associative Array (Index-by Table)**
- Maps category IDs to maintenance counts.  
- Demonstrates `.EXISTS`, `.FIRST`, and `.NEXT` iteration techniques.  
- Efficiently stores summarized maintenance statistics.  

### 4. **User-Defined Records**
- Combines multiple attributes (ID, name, quantity, last maintenance date) into one logical structure.  
- Improves readability and manageability of tool-related data.  

### 5. **GOTO Statements**
- Demonstrates label-based branching (`<<retry_check>>`) for validating missing data.  
- Used to retry validation steps when encountering null or incorrect quantities.  
- Highlights old-style flow control still supported in Oracle PL/SQL.  

---

## ⚙️ Testing Instructions

### 1. Run Schema Setup
Execute the following scripts in order:
```sql
@schema.sql
@sample_data.sql
