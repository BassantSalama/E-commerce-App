# 🛍️ Just a Girl — Scalable E-commerce iOS App

**Just a Girl** is a modern, scalable e-commerce iOS application built with **UIKit**, **Combine**, and a **Clean Architecture** approach using **MVVMC (Model–View–ViewModel–Coordinator)**.  
The app allows users to explore and shop a variety of products — such as **bags, accessories, and makeup** — and is designed to be fully extendable for future features and product categories.

---

## ✨ Features

-  **Home Screen:** Dynamic banners and categorized product sections.  
-  **Search:** Smart product search experience.  
-  **Product Details:** High-quality product views with details and images.  
-  **Wishlist:** Add and remove favorite products.  
-  **Categories:** Organized navigation by product type.  
-  **Authentication:** Firebase integration for sign-in, sign-up, and logout.  
-  **Cart & Checkout:** Add products to cart, review items, and complete purchases through a seamless checkout experience.  

---

## 🧠 Architecture

The project follows **Clean Architecture** principles with **MVVMC**, ensuring clear separation of concerns, scalability, and testability.


### 🧩 Highlights

- **MVVMC (Model–View–ViewModel–Coordinator):** Clean and modular navigation structure.  
- **Combine:** Handles reactive data flow between ViewModels and UI.  
- **Dependency Injection (DI):** Each feature has its own DI Container responsible for constructing and injecting dependencies (Repository, UseCase, ViewModel), enabling modularity and easy testing. 
- **Custom Network Layer:** Built from scratch 
- **Shopify API:** Provides backend product data and updates.  
- **Firebase Authentication:** Handles secure user sign-in and sign-up.  
- **Scalable Design:** Business logic is UI-independent → ready for a future **SwiftUI** interface.  

---

## 🧩 Technologies Used

| Layer | Technologies |
|-------|---------------|
| UI | UIKit, Combine, UICollectionViewCompositionalLayout |
| Architecture | Clean Architecture, MVVMC, Coordinator, Dependency Injection |
| Networking |  Network Layer (URLSession) |
| Authentication | Firebase |
| Backend | Shopify API |


---

## 🚀 Future Plans

-  **Order Tracking:** Real-time order status updates and history.  
-  **Discounts & Promo Codes:** Apply offers and promo codes at checkout.  
-  **Push Notifications:** For offers, new arrivals, and order updates.  
-  **TDD Integration:** Expand unit and UI test coverage.  
-  **SwiftUI Version:** Build a SwiftUI interface using the same Combine-driven logic.  

---





