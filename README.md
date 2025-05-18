# 🏆 Sports App (iOS - Swift)

An iOS application built using **Swift** that provides users with access to a variety of sports and leagues data fetched from [TheSportsDB API](https://allsportsapi.com/). The app is designed with an elegant UI, CoreData support, and robust architectural principles.

## 📱 Features

### 🏠 Main Interface
- **Tab 1 - Sports**
  - Displays all sports using a CollectionView.
  - 2 sports per row with proper spacing.
  - Each sport includes a thumbnail and name.
  - Navigation to `LeaguesViewController` on sport selection.

- **Tab 2 - Favorite Leagues**
  - CoreData integration for local persistence.
  - UI similar to `LeaguesViewController`.
  - If online: navigates to `LeagueDetailsViewController`.
  - If offline: shows an alert indicating no internet.

---

### 🏆 Leagues ViewController
- Implemented as a `UITableViewController`.
- Custom table cells include:
  - Circular league badge
  - League name
- Tapping a league opens the `LeagueDetailsViewController`.

---

### 📅 LeagueDetails ViewController
- Add/remove league from favorites.
- Divided into 3 sections:

#### 1. Upcoming Events (Horizontal CollectionView)
  - Event name, date, time
  - Teams' images

#### 2. Latest Events (Vertical CollectionView)
  - Home vs Away team
  - Scores, date, time
  - Teams' images

#### 3. Teams (Horizontal CollectionView)
  - Circular team images
  - Tapping leads to `TeamDetailsViewController`

---

### 👥 TeamDetails ViewController
- Displays elegant UI of selected team details.

---

## ⚙️ Tech Stack

- **Swift**
- **UIKit**
- **Alamofire** – Networking
- **CoreData** – Persistence
- **Design Patterns** – MVP + clean code architecture
- **Unit Testing**

---

## 💡 Extras
- Onboarding screen
- Localization support
- Dark mode UI

---

## 🧑‍💻 Team Members & Tasks


 *Mustafa Mahmoud*
 *Abdelrahman Ahmed* 
---

## 🗓️ Timeline

- **Start Date:** May 10, 2025  
- **Delivery Date:** May 22, 2025

---



