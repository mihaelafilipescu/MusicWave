# MusicWave Database Project

A comprehensive relational database system developed in **Oracle Database (19c)** using **PL/SQL** to manage a modern online music and streaming platform.

## About the Project
**MusicWave** models a complete music streaming and e-commerce platform. The system handles full music production pipelines, artist collaborations, user profiles, playlist creation, secure addressing, promotional coupon campaigns, and content reviews. 

The core relational structure centers around artist management, album production, individual and album tracks, and user interactions.

## Key Features & Architecture
* **Relational Schema:** Designed and implemented 19 interconnected tables enforcing primary/foreign keys and business check constraints (covering artists, solo artists, bands, genres, producers, albums, tracks, playlists, users, addresses, coupons, orders, and reviews).
* **Advanced PL/SQL Programming:**
  * **Collections:** Independent procedures leveraging all 3 collection types (VARRAY, Nested Tables, Associative Arrays) for data reporting.
  * **Cursors:** Complex reporting blocks using parametrized and dependent cursors.
  * **Exception Handling:** Robust pre-defined and custom-defined exceptions handling edge cases (e.g., `NO_DATA_FOUND`, `TOO_MANY_ROWS`, custom application rules).
* **Automated Triggers (LMD & LDD):**
  * **DML (LMD) Triggers:** Row-level audit logging tables tracking all insertions, updates, and deletions on critical entities with user and timestamp tracking. Command-level triggers enforcing operational time/day business logic rules.
  * **DDL (LDD) Triggers:** Schema-level monitoring system recording structural changes (CREATE, ALTER, DROP) made to database objects.

## Tech Stack
* **Database Management System:** Oracle Database 19c
* **Language:** SQL, PL/SQL
* **Development Environment:** DataGrip
* **Platform:** Windows (Local Instance)

## Database Schema Overview
The underlying architecture manages:
* **Cataloging:** Songs, albums, music genres, and producers.
* **Artists:** Differentiation between solo artists and bands, tracked via an `ISA` relationship hierarchy alongside collaboration mappings.
* **Users & E-commerce:** User registration, multi-address management, orders, and discount coupon tracking.
* **Social & Curation:** Custom user-generated playlists and song reviews with scoring constraints.
