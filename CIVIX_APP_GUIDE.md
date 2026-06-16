# CitiFix (Civix) - Comprehensive App Guide

## 🚀 Overview
**CitiFix** is a high-performance, cross-platform mobile application designed to bridge the gap between citizens
and urban maintenance departments. It streamlines the process of reporting public infrastructure issues and managing
the workforce responsible for fixing them.

---

## 🏗️ Core Features

### 👤 Dual-Role Ecosystem
The app provides specialized experiences for two distinct user types:
- **Citizens:** Empowered to report issues and track their resolution.
- **Workers:** Equipped with tools to receive, navigate to, and document task completion.

### 🛡️ Secure Authentication & Verification
- **Multi-Factor Auth:** OTP-based registration and password recovery.
- **Identity Verification:** Robust worker verification process requiring National ID and identity documents (Front/Back) to ensure only qualified professionals handle city tasks.
- **Secure Sessions:** Encrypted storage for authentication tokens and sensitive data.

### 📢 Citizen Reporting System
- **Rich Media Reports:** Citizens can report issues (water leaks, potholes, waste accumulation) with titles, detailed descriptions,
- and high-quality images/videos.
- **Categorization:** Automatic and manual tagging by category (Electricity, Plumbing, Roads, etc.) and Area (Zones).
- **Status Transparency:** Real-time tracking from "Pending" to "In Progress" and finally "Resolved."
- **Community Interaction:** A built-in commenting system for direct communication between reporters and the maintenance team.

### 🛠️ Worker Task Management
- **Intelligent Dashboard:** Overview of total reports, progress tracking, and urgent alerts.
- **Precision Navigation:** Real-time map integration with:
    - Distance-to-task calculation.
    - Route plotting (OSRM integration).
    - Geofencing (alerts when inside/outside the work zone).
- **Proof of Work:** Workers must provide notes and "Completion Photos" to finish a task, ensuring accountability.
- **Dynamic Updates:** Ability to edit and update completion data (add/delete images, modify notes) if feedback is received before final resolution.

---

## 💎 Powerful Capabilities

- **PDF Documentation:** One-click "Print to PDF" feature that captures the entire task lifecycle (original report + worker completion) into a professional document for archiving or administrative review.
- **Advanced Mapping:** Uses Flutter Map with OSRM for accurate routing without the high costs of proprietary APIs, supporting community-driven data (OpenStreetMap).
- **Localization:** Fully localized in **Arabic and English**, including RTL support, making it accessible to a wide demographic.
- **Modern Architecture:** Built using **Clean Architecture** principles with **BLoC/Cubit** for state management, ensuring the app is scalable, testable, and maintainable.

---

## 🧩 Problems Solved

1. **Slow Communication:** Replaces slow, paper-based or phone-call reporting with instant digital submissions.
2. **Lack of Accountability:** Workers must prove their location and provide photographic evidence of the fix before a task can be marked as complete.
3. **Information Silos:** Provides a single source of truth for citizens, workers, and administrators.
4. **Infrastructure Decay:** Enables faster identification and resolution of urban issues, preventing small leaks or potholes from becoming major disasters.

---

## 📈 Recent Improvements

- **Full-Page PDF Engine:** Upgraded from simple screen capture to a full-content capture system for comprehensive reporting.

---

**CitiFix** is more than just a reporting tool; it's a digital infrastructure management platform that brings transparency, speed, and reliability to city maintenance.
