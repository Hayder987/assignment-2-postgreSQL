
# Assignment-5 PostgreSQL

### 1. What is PostgreSQL?
- PostgreSQL কী?
- PostgreSQL একটি শক্তিশালী, ওপেন-সোর্স রিলেশনাল ডাটাবেজ ম্যানেজমেন্ট সিস্টেম। এটি SQL ব্যবহার করে ডাটা সংরক্ষণ, অনুসন্ধান, আপডেট ও মুছে ফেলার জন্য ব্যবহৃত হয়। PostgreSQL ACID properties ফলো করে, যার মানে এটি reliable এবং safe ডাটা হ্যান্ডল করে। এটি complex query, indexing, triggers, stored procedures এবং JSON ডেটার সাপোর্ট দেয়।

উদাহরণ: আমরা যদি একটি ওয়াইল্ডলাইফ কনজারভেশন প্রজেক্টে কাজ করি, তাহলে PostgreSQL দিয়ে আমরা species, rangers ও sightings এর মতো টেবিল তৈরি করতে পারি।

### 2. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
- Primary Key ও Foreign Key কী?
- Primary Key হল একটি টেবিলের এমন একটি কলাম বা কলামগুলোর কম্বিনেশন যা প্রতিটি রো (row) কে ইউনিকভাবে শনাক্ত করে।

Foreign Key হল এমন একটি কলাম যা অন্য একটি টেবিলের primary key এর সাথে সংযুক্ত থাকে। এটি দুইটি টেবিলের মধ্যে relationship তৈরি করে।

উদাহরণ: rangers টেবিলে ranger_id হল primary key, এবং sightings টেবিলে ranger_id একটি foreign key যা rangers টেবিলের সাথে সংযুক্ত।


### 3. What is the purpose of a database schema in PostgreSQL?
- PostgreSQL-এ Schema-এর কাজ কী?
- একটি schema হল ডাটাবেজের মধ্যে একটি logical container বা structure, যেখানে টেবিল, ভিউ, ফাংশন ইত্যাদি থাকে। একাধিক স্কিমা একই ডাটাবেজে থাকতে পারে, এবং এগুলো আলাদা আলাদা ভাবে সংগঠিত থাকে।

উদাহরণ: আমরা যদি একই ডাটাবেজে “admin” ও “user” এর জন্য আলাদা টেবিল রাখতে চাই, তাহলে দুইটি schema ব্যবহার করতে পারি — একটিতে admin data, আরেকটিতে user data।

### 4. How can you modify data using UPDATE statements?
- কিভাবে UPDATE স্টেটমেন্ট ব্যবহার করে ডেটা পরিবর্তন করা যায়?
- UPDATE স্টেটমেন্ট ব্যবহার করে আমরা ডাটাবেজের একটি নির্দিষ্ট টেবিলে থাকা তথ্য পরিবর্তন করতে পারি। এটি মূলত একটি টেবিলের এক বা একাধিক রো'র ডেটা আপডেট করার জন্য ব্যবহৃত হয়।

সাধারণ গঠন (Syntax):
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;

- SET দিয়ে আমরা কোন কলামগুলো আপডেট করতে চাই তা নির্ধারণ করি,
- WHERE ক্লজ দিয়ে আমরা কোন রো গুলো পরিবর্তন করবো তা নির্ধারণ করি।

উদাহরণ:

ধরি আমাদের species টেবিলে কিছু প্রাচীন প্রজাতি আছে যাদের আবিষ্কারের তারিখ ১৮০০ সালের আগে। আমরা চাই তাদের conservation_status আপডেট করে 'Historic' করে দিতে।
- code:

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

এই কোডটি যেসব প্রজাতি ১৮০০ সালের আগে আবিষ্কৃত হয়েছে তাদের সবার স্ট্যাটাস 'Historic' করে দেবে।

### 5. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
- PostgreSQL-এ COUNT(), SUM(), এবং AVG() এর মতো Aggregate Function ব্যবহার
- Aggregate function গুলো PostgreSQL-এ ব্যবহার করা হয় অনেকগুলো রো (row) এর উপর গণনা করার জন্য। এগুলোর মাধ্যমে আমরা মোট সংখ্যা, যোগফল, গড় ইত্যাদি সহজেই বের করতে পারি।

1. COUNT() → মোট কতটি রো আছে তা গণনা করে
   - SELECT COUNT(*) FROM sightings;
   উদাহরণ: আমাদের sightings টেবিলে মোট কতগুলো sighting আছে তা বের করবে।

2. SUM() → কোনো সংখ্যার যোগফল করে
 - SELECT SUM(population) FROM species;
 উদাহরণ: ধরুন species টেবিলে population নামে একটি কলাম আছে, তাহলে এই কোয়েরি সব প্রজাতির মোট জনসংখ্যা দেখাবে।

3. AVG() → গড় বের করে
  - SELECT AVG(age) FROM rangers;
উদাহরণ: যদি rangers টেবিলে age নামের একটি কলাম থাকে, তাহলে এই কোয়েরি রেঞ্জারদের গড় বয়স দেখাবে।

Aggregate functions আমাদের বিশ্লেষণমূলক কাজ সহজ করে দেয়। PostgreSQL-এ এগুলো খুবই গুরুত্বপূর্ণ ও শক্তিশালী টুল।