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

👉 `VARCHAR` ব্যবহার করলে স্টোরেজ সাশ্রয় হয়, যেখানে `CHAR` পারফরম্যান্স বুস্ট করে নির্দিষ্ট দৈর্ঘ্যের জন্য।

---
