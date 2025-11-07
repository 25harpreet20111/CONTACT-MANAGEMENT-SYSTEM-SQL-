Contact Management System

A simple MySQL-based Contact Management System to manage personal and professional contacts, organize them into groups, log communications, and set reminders with automatic follow-ups.

Features

Contact Management: Store contact info (name, phone, email, age, gender, city).

Group Management: Organize contacts into groups (Family, Friends, Work).

Communication Log: Track interactions with contacts.

Reminders: Schedule reminders for tasks or events.

Automatic Follow-up Logging: Trigger-based logging of completed reminders.

Database Schema
Tables

contact – Stores contact details.

contact_group – Stores groups for contacts.

contact_group_mapping – Maps contacts to groups.

communication_log – Logs communications.

reminder – Stores reminders for contacts.

Trigger

log_after_reminder_completion – Automatically logs follow-up communications when a reminder is marked as completed.

Sample Data

Contacts: Ravi Kumar, Sneha Patel, Amit Singh, Neha Verma

Groups: Family, Friends, Work

Reminders: Call regarding meeting, Wish HAPPY BIRTHDAY, Revision of SURPRISE TEST

Setup Instructions

Install MySQL and start the server.

Create a database:

CREATE DATABASE contact_management;
USE contact_management;


Run the provided SQL script to create tables, triggers, and insert sample data.

Test the trigger:

UPDATE reminder SET status='Completed' WHERE reminder_id=1;
SELECT * FROM communication_log;

Usage

Add new contacts, groups, and reminders via INSERT.

Update reminders to log follow-up communications automatically.

Query communication logs or group mappings as needed.

Future Enhancements

Web or desktop interface for easier management.

Search and filter contacts by name, city, or group.

Notifications for upcoming reminders.

Extended communication types (call, email, meeting).

License

This project is open-source and free for personal and educational use.
