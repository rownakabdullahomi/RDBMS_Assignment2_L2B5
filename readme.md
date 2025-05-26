<!-- ![PostgreSQL Logo](https://cdn.worldvectorlogo.com/logos/postgresql.svg) -->
![PostgreSQL Logo](https://i.ibb.co/21qfSFSj/postgresql.png)

# 🐘 PostgreSQL Explained in Bangla: Dive into the Core Concepts

এই গাইডটি PostgreSQL-এর গুরুত্বপূর্ণ ধারণাগুলোর উপর একটি বিস্তারিত ও সুগঠিত আলোচনা উপস্থাপন করে। আপনি যদি ডেটাবেইস শেখা শুরু করে থাকেন, PostgreSQL নিয়ে কাজ করতে চান, অথবা বর্তমানে একটি ডেটাবেইস-ভিত্তিক অ্যাপ্লিকেশন তৈরি করছেন — তাহলে এই README আপনার জন্য একদম উপযুক্ত। এটি আপনাকে PostgreSQL সম্পর্কে মৌলিক থেকে শুরু করে প্রয়োজনীয় বিষয়গুলো বাস্তব উদাহরণসহ শিখতে সাহায্য করবে।

---

## 📋 Table of Contents

* [PostgreSQL কী?](#-postgresql-কি)
* [ডেটাবেস স্কিমা কী এবং কেন দরকার?](#-ডেটাবেস-স্কিমা-কি-এবং-কেন-দরকার)
* [Primary Key ও Foreign Key ব্যাখ্যা](#-primary-key-ও-foreign-key-ব্যাখ্যা)
* [VARCHAR বনাম CHAR ডেটা টাইপ](#-varchar-বনাম-char-ডেটা-টাইপ)
* [WHERE ক্লজের উদ্দেশ্য](#-where-ক্লজের-উদ্দেশ্য)
* [LIMIT এবং OFFSET ব্যাখ্যা](#-limit-এবং-offset-ব্যাখ্যা)
* [UPDATE দিয়ে ডেটা পরিবর্তন](#-update-দিয়ে-ডেটা-পরিবর্তন)
* [JOIN অপারেশন ও এর গুরুত্ব](#-join-অপারেশন-ও-এর-গুরুত্ব)
* [GROUP BY এবং Aggregation](#-group-by-এবং-aggregation)
* [Aggregate ফাংশন: COUNT, SUM, AVG](#-aggregate-ফাংশন-count-sum-avg)
* [📌 Final Thoughts](#-final-thoughts)

---

## 🐘 PostgreSQL কী?

**PostgreSQL** একটি শক্তিশালী, ওপেন সোর্স, অবজেক্ট-রিলেশনাল ডেটাবেইস ম্যানেজমেন্ট সিস্টেম (ORDBMS)। এটি দীর্ঘদিন ধরেই বিশ্বাসযোগ্যতা, স্থায়ীত্ব এবং উন্নত ফিচারের জন্য জনপ্রিয়। PostgreSQL ANSI SQL স্ট্যান্ডার্ড ফলো করে এবং JSON, indexing, full-text search, stored procedures ইত্যাদি সমর্থন করে।

---

## 🏗️ ডেটাবেস স্কিমা কী এবং কেন দরকার?

**স্কিমা (Schema)** হচ্ছে একটি container যা ডেটাবেইস অবজেক্ট যেমন table, view, function ইত্যাদি ধারণ করে। এটি ডেটার সুশৃঙ্খল ব্যবস্থাপনায় সাহায্য করে।

### ✳️ সুবিধাসমূহ:

* একই ডেটাবেইসে ভিন্ন স্কিমা ব্যবহার করে আলাদা মডিউল বা ইউজার ম্যানেজ করা যায়।
* ডেটা কনফ্লিক্ট কমায়।
* সিকিউরিটি ও পারফরম্যান্স উন্নত করে।

```sql
CREATE SCHEMA accounting;

CREATE TABLE accounting.invoices (
  id SERIAL PRIMARY KEY,
  amount DECIMAL,
  paid BOOLEAN
);
```

---

## 🗝️ Primary Key ও Foreign Key ব্যাখ্যা

### 🔐 Primary Key:

একটি টেবিলের এমন একটি কলাম যা প্রতিটি রেকর্ডকে ইউনিকভাবে চিহ্নিত করে। এটি কখনো `NULL` বা ডুপ্লিকেট হতে পারে না।

```sql
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name TEXT
);
```

### 🔗 Foreign Key:

একটি টেবিলের এমন কলাম যা অন্য টেবিলের Primary Key-এর সাথে সম্পর্ক তৈরি করে।

```sql
CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  name TEXT,
  student_id INTEGER REFERENCES students(id)
);
```

✅ এটি ডেটার সম্পর্ক বজায় রাখে এবং ইনটিগ্রিটি নিশ্চিত করে।

---

## 🔤 VARCHAR বনাম CHAR ডেটা টাইপ

| বৈশিষ্ট্য      | VARCHAR     | CHAR                       |
| -------------- | ----------- | -------------------------- |
| দৈর্ঘ্য        | পরিবর্তনশীল | নির্দিষ্ট                  |
| ব্যবহারযোগ্যতা | বেশি নমনীয়  | দ্রুত পারফরম্যান্স         |
| জায়গা          | কম নেয়      | সবসময় নির্দিষ্ট পরিমাণ নেয় |

```sql
CREATE TABLE users (
  username VARCHAR(50),
  code CHAR(5)
);
```

👉 `VARCHAR` ব্যবহার করলে ডেটা স্টোরেজে সাশ্রয় হয় কারণ এটি প্রয়োজন অনুযায়ী জায়গা ব্যবহার করে, অন্যদিকে `CHAR` নির্দিষ্ট দৈর্ঘ্যের ফিক্সড স্পেস সংরক্ষণ করে, যা নির্দিষ্ট দৈর্ঘ্যের ডেটার ক্ষেত্রে দ্রুত অ্যাক্সেসের মাধ্যমে কিছুটা পারফরম্যান্স বুস্ট করে।

---
## ❓ WHERE ক্লজের উদ্দেশ্য

`WHERE` ক্লজ ব্যবহার করে নির্দিষ্ট শর্ত অনুযায়ী ডেটা ফিল্টার করা যায়।

```sql
SELECT * FROM employees WHERE department = 'HR';
```

➡️ এটি শুধুমাত্র শর্ত মেনে চলা রেকর্ড রিটার্ন করে।

---

## 🔽 LIMIT এবং OFFSET ব্যাখ্যা

* **LIMIT**: কতটি রেকর্ড রিটার্ন করতে হবে সেটি নির্ধারণ করে।
* **OFFSET**: কতগুলি রেকর্ড স্কিপ করতে হবে সেটি বলে দেয়।

```sql
SELECT * FROM orders LIMIT 10 OFFSET 20;
```

➡️ এটি ২০টি স্কিপ করে পরবর্তী ১০টি রেকর্ড দেখাবে। Pagination-এর জন্য খুবই উপকারী।

---

## 🔧 UPDATE দিয়ে ডেটা পরিবর্তন

`UPDATE` statement দিয়ে বিদ্যমান ডেটা পরিবর্তন করা যায়।

```sql
UPDATE employees SET salary = 75000 WHERE id = 5;
```

⚠️ **WHERE ক্লজ ছাড়া UPDATE করলে পুরো টেবিল পরিবর্তিত হয়ে যেতে পারে!**

---

## 🔄 JOIN অপারেশন ও এর গুরুত্ব

`JOIN` ব্যবহার করে একাধিক টেবিলের সম্পর্কযুক্ত ডেটা একত্রে আনা যায়। এটি রিলেশনাল ডেটাবেইসের অন্যতম শক্তিশালী ফিচার। যখন টেবিলগুলোর মধ্যে কোনো ফিল্ডে সম্পর্ক থাকে (যেমন `foreign key`), তখন `JOIN` অপারেশন ব্যবহার করে আমরা সেই সম্পর্ক ব্যবহার করে তথ্য একত্রিত করতে পারি।

---

### ✅ ১. `INNER JOIN`

`INNER JOIN` শুধু তখনই রেকর্ড রিটার্ন করে যখন দুই টেবিলেই সম্পর্কযুক্ত ডেটা পাওয়া যায়।

```sql
SELECT orders.id, customers.name
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;
```

🧩 এটি `orders` ও `customers` টেবিলের সেইসব রেকর্ড দেখাবে যেগুলোর `customer_id` এবং `id` মিলে যায়।

---

### ✅ ২. `LEFT JOIN` (বা `LEFT OUTER JOIN`)

`LEFT JOIN` সবসময় বামপাশের (প্রথম) টেবিলের সব রেকর্ড রিটার্ন করে। ডান পাশে মেলেনি এমন ক্ষেত্রে `NULL` রিটার্ন করে।

```sql
SELECT orders.id, customers.name
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;
```

🧩 এতে `orders` টেবিলের সব রেকর্ড দেখাবে, এমনকি যদি কোনো অর্ডারের `customer_id` `customers` টেবিলে না-ও থাকে।

---

### ✅ ৩. `RIGHT JOIN` (বা `RIGHT OUTER JOIN`)

`RIGHT JOIN` ডানপাশের (দ্বিতীয়) টেবিলের সব রেকর্ড রিটার্ন করে। বাম পাশে মেলেনি এমন ক্ষেত্রে `NULL` রিটার্ন করে।

```sql
SELECT orders.id, customers.name
FROM orders
RIGHT JOIN customers ON orders.customer_id = customers.id;
```

🧩 এতে `customers` টেবিলের সব রেকর্ড দেখাবে, এমনকি কোনো কাস্টমার যদি কোনো অর্ডার না দিয়ে থাকে তবুও।

---

### ✅ ৪. `FULL JOIN` (বা `FULL OUTER JOIN`)

`FULL JOIN` উভয় টেবিলের সব রেকর্ড রিটার্ন করে। যেখানে মিল নেই, সেখানে `NULL` দিয়ে পূরণ করে।

```sql
SELECT orders.id, customers.name
FROM orders
FULL JOIN customers ON orders.customer_id = customers.id;
```

🧩 এটি এমন সব অর্ডার দেখাবে যেগুলোর কাস্টমার পাওয়া গেছে বা পাওয়া যায়নি এবং এমন কাস্টমারও দেখাবে যাদের কোনো অর্ডার নেই।

---

### ✅ ৫. `CROSS JOIN`

`CROSS JOIN` প্রতিটি রেকর্ডের সাথে অপর টেবিলের প্রতিটি রেকর্ডের **কার্টেশিয়ান প্রোডাক্ট** তৈরি করে। সাধারণত যেখানে দুই টেবিলের সব কম্বিনেশন দরকার হয়, সেখানে ব্যবহৃত হয়।

```sql
SELECT products.name, categories.name
FROM products
CROSS JOIN categories;
```

🧩 প্রতিটি প্রোডাক্টের জন্য প্রতিটি ক্যাটাগরির কম্বিনেশন দেখাবে। যদি 5 প্রোডাক্ট ও 3 ক্যাটাগরি থাকে, তাহলে ১৫টি রেকর্ড রিটার্ন হবে।

---

### ✅ ৬. `SELF JOIN`

`SELF JOIN` একই টেবিলকে নিজেই `JOIN` করে, অর্থাৎ টেবিলের ভেতরেই সম্পর্ক খোঁজা হয়।

```sql
SELECT a.name AS employee, b.name AS manager
FROM employees a
JOIN employees b ON a.manager_id = b.id;
```

🧩 এখানে `employees` টেবিলকে দুইবার ব্যবহার করা হয়েছে, যেখানে একজন এমপ্লয়ির ম্যানেজারের নাম বের করা হয়েছে।

---

### 🧠 উপসংহার

`JOIN` অপারেশন ডেটাবেইসে সম্পর্কযুক্ত তথ্য বিশ্লেষণ এবং রিপোর্ট তৈরি করার জন্য অপরিহার্য। সঠিক `JOIN` নির্বাচন করলে ডেটা আরও কার্যকরভাবে উপস্থাপন করা যায় এবং প্রাসঙ্গিক ইনসাইট পাওয়া যায়।

---

## 📊 GROUP BY এবং Aggregation

`GROUP BY` ব্যবহার করে আমরা ডেটাকে নির্দিষ্ট একটি বা একাধিক কলামের ভিত্তিতে **গ্রুপ** করতে পারি। এটি তখনই সবচেয়ে কার্যকর হয় যখন আমরা প্রতিটি গ্রুপের উপর অ্যাগ্রিগেট (aggregation) ফাংশন চালাতে চাই।

### 🧮 Aggregation কী?

Aggregation ফাংশনের মাধ্যমে আমরা গ্রুপকৃত ডেটার উপর সারাংশ হিসেব করতে পারি—যেমন:

* `COUNT()` — মোট কতটি রেকর্ড
* `SUM()` — মোট যোগফল
* `AVG()` — গড় মান
* `MIN()` — সর্বনিম্ন মান
* `MAX()` — সর্বোচ্চ মান

### 🎯 উদাহরণ:

```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department;
```

📊 এটি প্রতিটি ডিপার্টমেন্টে কয়জন কর্মী কাজ করেন তা দেখায়।

---

আরও একটি উদাহরণ:

```sql
SELECT department, AVG(salary)
FROM employees
GROUP BY department;
```

📉 এটি প্রতিটি ডিপার্টমেন্টের গড় বেতন নির্ণয় করে।

---

### 📝 মনে রাখবেন:

* `GROUP BY` এর পর যেসব কলাম থাকবে, সেগুলো `SELECT` স্টেটমেন্টে অবশ্যই থাকতে হবে (অথবা অ্যাগ্রিগেট ফাংশনের মধ্যে থাকতে হবে)।

* Aggregation এর পরে `HAVING` ক্লজ ব্যবহার করে আমরা গ্রুপকৃত ডেটার উপর শর্ত প্রয়োগ করতে পারি।

```sql
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department
HAVING COUNT(*) > 5;
```

🔍 এটি শুধুমাত্র সেই ডিপার্টমেন্টগুলো দেখাবে যেখানে ৫ জনের বেশি কর্মী রয়েছে।

---

## ✨ HAVING ক্লজের ব্যবহার

`HAVING` ক্লজ ব্যবহার করা হয় **গ্রুপকৃত ডেটার উপর শর্ত (condition)** প্রয়োগ করার জন্য। এটি অনেকটা `WHERE` ক্লজের মতোই কাজ করে, কিন্তু পার্থক্য হলো:

### ⚠️ পার্থক্য: `WHERE` vs `HAVING`

| বিষয়    | WHERE                    | HAVING                            |
| ------- | ------------------------ | --------------------------------- |
| কাজ করে | ডেটা গ্রুপ হওয়ার **আগে** | ডেটা গ্রুপ হওয়ার **পরে**          |
| ব্যবহার | সাধারণ রো ফিল্টার করতে   | অ্যাগ্রিগেট ফাংশনের উপর শর্ত দিতে |

---

### 🧠 কেন প্রয়োজন?

`GROUP BY` দিয়ে যখন ডেটা গ্রুপ করা হয়, তখন আমরা চাইতে পারি শুধুমাত্র **নির্দিষ্ট শর্তে মিল থাকা গ্রুপগুলো** রেজাল্টে আসুক। এই কাজটি করতে `HAVING` ব্যবহার করা হয়।

---

### 🎯 উদাহরণ:

ধরুন, আমাদের একটি `employees` টেবিল আছে যেখানে বিভিন্ন ডিপার্টমেন্টে কর্মীরা কাজ করছেন। এখন আমরা শুধুমাত্র সেই ডিপার্টমেন্টগুলোর তথ্য চাই যেসব ডিপার্টমেন্টে **৫ জনের বেশি কর্মী** রয়েছে।

```sql
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;
```

🔍 এই কোয়েরিতে:

* প্রথমে `GROUP BY` দিয়ে `department` অনুযায়ী ডেটা গ্রুপ করে।
* তারপর `HAVING` দিয়ে শুধু সেই ডিপার্টমেন্টগুলো দেখায় যেখানে `COUNT(*) > 5` অর্থাৎ কর্মীর সংখ্যা ৫-এর বেশি।

---

### 🧪 আরেকটি উদাহরণ (SUM এর ক্ষেত্রে):

```sql
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 100000;
```

🎯 এটি দেখাবে সেইসব ডিপার্টমেন্ট যাদের সম্মিলিত বেতন ১ লাখের বেশি।

---

### ✅ উপসংহার:

* `HAVING` ব্যবহার করতে হয় **Aggregation এর পরের শর্ত** ফিল্টার করার জন্য।
* এটি `GROUP BY` এর সাথে **জোড়ায়** কাজ করে।
* সরাসরি `COUNT()`, `SUM()`, `AVG()` ইত্যাদি ফাংশনের উপর ভিত্তি করে রেজাল্ট ফিল্টার করা যায়।

---

## 🔢 Aggregate ফাংশন: COUNT, SUM, AVG

| ফাংশন     | কাজ               |
| --------- | ----------------- |
| `COUNT()` | মোট রেকর্ড গণনা   |
| `SUM()`   | সংখ্যাগুলোর যোগফল |
| `AVG()`   | গড় মান বের করে    |

```sql
SELECT COUNT(*) FROM orders;
SELECT SUM(price) FROM products;
SELECT AVG(salary) FROM employees;
```

✅ এই ফাংশনগুলো রিপোর্টিং ও বিশ্লেষণের জন্য গুরুত্বপূর্ণ।

---

### ➕ অন্যান্য Aggregate ফাংশন:

| ফাংশন          | কাজ                                                                     |
| -------------- | ----------------------------------------------------------------------- |
| `MIN()`        | কোনো কলামের সর্বনিম্ন মান নির্ধারণ করে                                  |
| `MAX()`        | কোনো কলামের সর্বোচ্চ মান নির্ধারণ করে                                   |
| `STRING_AGG()` | একাধিক টেক্সট ভ্যালু একত্রে স্ট্রিং আকারে যোগ করে (PostgreSQL-specific) |
| `BOOL_AND()`   | সমস্ত রেকর্ডে Boolean মান `TRUE` কিনা যাচাই করে                         |
| `BOOL_OR()`    | কোনো রেকর্ডে Boolean মান `TRUE` আছে কিনা যাচাই করে                      |

```sql
SELECT MIN(price) FROM products;
SELECT MAX(salary) FROM employees;
SELECT STRING_AGG(name, ', ') FROM customers;
SELECT BOOL_AND(is_active) FROM users;
SELECT BOOL_OR(is_admin) FROM users;
```

📊 এই অতিরিক্ত ফাংশনগুলো ডেটা বিশ্লেষণ ও জটিল রিপোর্ট তৈরিতে বিশেষভাবে সহায়ক।

---
