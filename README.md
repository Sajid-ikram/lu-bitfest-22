# Welcome to Bitfest Hackathon 2022

Before you start working, know that we strive for quality. It means you can use any language, tools, third-party
services/API, any architecture to show your skills. We will provide requirements that you have to meet to pass, but you
can code extra features if you want. Keep in mind, don't overdo it for its sake. Prefer high-quality mandatory
requirements over many optional features with lower quality.

We ask you to write a README in Markdown Format and create a presentation of your work to check your communication
skills, but also as a chance for you to reason about your implementation decisions.

> :fire: Do you wish to provide a non-requirement feature or take a different project?
> We can deal with that, as long as you explain the idea.
> And if that's a good idea, you can start implementing it when it is accepted by the judging panel.

We hope everything about the task is clear; if not, we are sorry for that and are more than happy to clarify anything
you did not understand. Let us know, and we will get back to you as soon as we can! We wish you good luck!

## Judge Panel

- [ ] Shafkat Kibria, Assistant Professor @[Leading University](https://www.lus.ac.bd/author/shafkat/)
- [ ] Md Shahjahan, Founder & Managing Director @[Authlab](https://authlab.io/)
- [ ] Ershadur Rahman Talukder, CTO & Co-Founder @[Inverse.AI](https://inverseai.com/)
- [ ] Syed Rezwanul Haque Rubel, Co-Founder & Managing Director @[Technext Limited](https://technext.it/)
- [ ] Sayed Al Mahdi, Lead Software Engineer @[LII Lab](https://liilab.com/)
- [ ] Shahriar Arefin Zummon, Lecturer @[Leading University](https://www.lus.ac.bd/author/shahriar/)

## Marking Criteria **[Total 150 points]**

- [ ] Features - **[100 points]**
- [ ] UI/UX - **[25 points]**
- [ ] Presentation + Q&A - **[25 points]**

## Instructions

- [ ] Fork this repository
- [ ] For each major feature create a **branch**
- [ ] After completing each task
    - [ ] Mark the task as done in the requirement section of the **README.md** file by changing the markdown
      syntax: `- [ ]` to `- [x]`
    - [ ] Create a **commit** and **push** it to your forked repository

## Problem Statement

Resource scarcity has always been a part of our day-to-day life. The Transport sector faces this incident the most for
using the resources in a nonoptimal manner. Local transport usually doesn’t know the demands at any particular time or
route. That’s why we often see many vehicles with vacant seats or pedestrians waiting for them. We aim to build a
platform that solves this problem for a particular segment - University Transport. We are going to develop a strategy
that helps us to allocate the transport at any university in the most optimal way possible. Our target is to satisfy the
demand for transit for the maximum number of consumers.

## Requirements

1. **As a Transport Dept. official/staff ability to -**
    - [x] Open an account with the following information **[Mandatory feature | 5 points]**
        - [x] Full name
        - [x] Contact number
        - [ ] ~~Account must be confirmed by the Higher Official or Support Team to access the portal~~
        - [x] An official/staff can log in to their portal by **any** of the following:
            - [ ] Combination of username & password
            - [x] Mobile number with OTP verification
        - [x] Update Bus inventory with the following information **[Mandatory feature | 5 points]**
            - [x] License number
            - [ x Codename (ie: to uniquely identify)
            - [x] Capacity
            - [x] Driver info.
                - [x] Full Name
                - [x] Contact Number
            - [ x Is Active (ie: a bus could be in maintenance)
        - [x] Create/Update routes with the following information **[Mandatory | 5 points]**
            - [x] Route number
            - [x] Start location
                - [x] Label
                - [x] Latitude & Longitude
            - [x] Start time
        - [x] Create/Update stoppages with the following information **[Nice to have | 2 points]**
            - [x] Route number
            - [x] Label
            - [x] Latitude & Longitude
        - [x] Input the transport demands manually for a specific route & timeslot for the following
            - [ ] groups **[Mandatory feature | 6 points]**
            - [ ] Students
            - [ ] Teachers
            - [ ] Staff or officials
            - [ ] Others (ie: in case of any events)
        - [x] Automated transport demand calculation **[Nice to have | 10 points]**
            - [x] Upload and store schedules (ie: class routine, exam routine)
            - [x] [A sample routine can be downloaded from this link]
                - [x] [Class Routine](https://docs.google.com/spreadsheets/d/1kGY1XLjjdDOeFdTLzxgmQYZtLyKaBOshsJ_6pq0TrwU/edit#gid=712672084)
                - [ ] [Exam Routine](https://docs.google.com/spreadsheets/d/1_E9bvZpGL41k3m40PBvWd9l3NCgR0RQn/edit#gid=329530890)
            - [x] Calculate the demand in a specific route & timeslot based on the schedules
        - [x] Get an optimal suggestion of the following **[Mandatory feature | 20 points]**
            - [x] Estimated number of passengers (ie: students, teachers, staff) in a specific route & timeslot
            - [x] Which buses to allocated in a specific route & timeslot
            - [x] How many extra buses are required (If applicable)

2. **As a Consumer (ie: student, teacher, staff) ability to -**
    - [x] Open an account with the following information **[Mandatory feature | 5 points]**
        - [x] Full name
        - [x] ID number
        - [x] Contact number
        - [x] Select option for role
            - [x] Student
            - [x] Teacher
            - [x] Staff
        - [ ] Select option for pickup stoppage
        - [ ] ~~Account must be confirmed by the Higher Official or Support Team to access the portal~~
        - [x] A consumer can log in to their portal by **any** of the following:
            - [ ] Combination of username & password
            - [x] Mobile number with OTP verification
    - [x] Update profile information (for students) **[Mandatory feature | 2.5 points]**
        - [x] Full name
        - [x] Batch number
        - [x] Section
    - [x] Update profile information (for teachers) **[Mandatory feature | 2.5 points]**
        - [x] Department
        - [x] Code name (ie: XYZ) [It is used in the routine]
        - [x] Designation
    - [x] Request seat in a specific route and timeslot **[Mandatory feature | 5 points]**
        - [x] A consumer can manually request a seat
        - [x] If the requested time is out of schedule, a mandatory Note to mention the reason must be provided
    - [ ] Automated seat allocation **[Nice to have | 5 points]**
        - [ ] For students, teachers, and staff a request will be applied automatically according to their
          routine/schedule
        - [] [A sample routine can be downloaded from this link]
            - [ ] [Class Routine](https://docs.google.com/spreadsheets/d/1kGY1XLjjdDOeFdTLzxgmQYZtLyKaBOshsJ_6pq0TrwU/edit#gid=712672084)
            - [ ] [Exam Routine](https://docs.google.com/spreadsheets/d/1_E9bvZpGL41k3m40PBvWd9l3NCgR0RQn/edit#gid=329530890)
    - [x] Ability to view the location of a bus with estimated arrival time **[Nice to have | 15 points]**
    - [x] View information about the transport **[Mandatory feature | 5 points]**
        - [x] Which buses are allocated in a specific route & timeslot
        - [x] Codename or sequence of the buses

3. Prepare a dummy dataset with the following requirements **[Mandatory feature | 7 points]**
    - [x] 4 transport routes
    - [x] 10 buses
        - [x] Capacity: 50; Quantity: 5
        - [x] Capacity: 35; Quantity: 10
    - [x] 10K students distributed into
        - [x] 7 departments
            - [x] CSE
            - [ ] EEE
            - [ ] Civil
            - [ ] Architecture
            - [ ] BBA
            - [ ] English
            - [ ] Law
        - [ ] 56 batches
            - [ ] 8 batches per department
            - [ ] 2 - 5 sections per batch
    - [ ] 100 teachers distributed into the 7 departments (mentioned above)
    - [ ] 50 staffs
