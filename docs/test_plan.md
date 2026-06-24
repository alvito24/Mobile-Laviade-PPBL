# Test Plan — Laviade Studio Mobile

## 1. Test Plan Overview

Test plan ini disiapkan untuk final QA Laviade Studio Mobile — Local Commerce Simulation. Fokus test adalah memastikan baseline Assessment 2 tetap aman dan extension Tugas Besar dapat didemokan secara local-first.

## 2. Test Scope

Scope test:

- Assessment 2 regression.
- Wishlist CRUD lokal.
- Product Note CRUD lokal.
- Order Simulation CRUD lokal.
- Insight Statistics lokal.
- SQLite persistence.
- SharedPreferences persistence.
- Provider state refresh.
- fl_chart rendering.
- CustomPainter/Gesture `OrderStatusStepper`.
- Navigation dan forbidden feature check.

## 3. Out of Scope

- Backend/API production test.
- Login/register production test.
- Payment/checkout test.
- Shipping/address/courier test.
- Maps/geolocation test.
- Product size/variant/material/fit/care test.
- Load/performance enterprise test.

## 4. Test Environment

| Item | Value |
|---|---|
| Platform | Flutter Android app |
| Storage | SQLite local database |
| Preferences | SharedPreferences |
| Target device | Android emulator/device |
| Verification | `flutter analyze`, `flutter run`, manual test |

## 5. Feature Test Matrix

| Area | Coverage |
|---|---|
| A2 baseline | Splash, Home, Detail, Cart, Manage, Settings |
| SQLite | 7 tables final |
| SharedPreferences | 6 key existing |
| CRUD | 6 CRUD final |
| Provider | Wishlist, Order, Product Note, Insight |
| Chart | fl_chart local bar chart |
| Custom drawing | OrderStatusStepper CustomPainter |
| Forbidden features | No Maps/payment/backend/shipping |

## 6. Assessment 2 Regression Test

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| A2-001 | Splash | App starts | App installed | Open app | Splash appears then app shell opens | Not executed | Pending | Manual device validation required |
| A2-002 | Home Catalog | View catalog | Seed/products exist | Open Home | Product catalog appears | Not executed | Pending |  |
| A2-003 | Product Detail | Open detail | Product exists | Tap product | Product detail opens | Not executed | Pending |  |
| A2-004 | Add to Cart | Add product | Product exists | Tap Add to Cart | Product added to cart | Not executed | Pending |  |
| A2-005 | Cart Update | Update quantity | Cart has item | Tap + / - | Quantity updates | Not executed | Pending |  |
| A2-006 | Cart Delete | Delete item | Cart has item | Tap delete and confirm | Item removed | Not executed | Pending |  |
| A2-007 | Product Create | Add product | Category exists | Manage Product → Add | Product saved | Not executed | Pending |  |
| A2-008 | Product Edit | Edit product | Product exists | Manage Product → Edit | Product updated | Not executed | Pending |  |
| A2-009 | Product Delete | Delete product | Product exists | Manage Product → Delete | Product removed safely | Not executed | Pending | Check relation behavior |
| A2-010 | Category Create | Add category | App open | Manage Category → Add | Category saved | Not executed | Pending |  |
| A2-011 | Category Edit | Edit category | Category exists | Manage Category → Edit | Category updated | Not executed | Pending |  |
| A2-012 | Category Delete | Delete category | Category unused | Manage Category → Delete | Category removed | Not executed | Pending | Used category should be blocked |
| A2-013 | Settings Name | Save user name | Settings open | Change name and save | Name persists | Not executed | Pending | SharedPreferences |
| A2-014 | Settings Theme | Toggle dark mode | Settings open | Toggle theme | Theme preference persists | Not executed | Pending |  |
| A2-015 | Home Preferences | Sort/filter/view | Products exist | Change category/sort/view | Preference persists | Not executed | Pending |  |

## 7. Tugas Besar Feature Test

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| TB-WL-001 | Wishlist | Add wishlist | Product exists | Product Detail → Simpan ke Wishlist | Product saved in wishlist | Not executed | Pending | SQLite local |
| TB-WL-002 | Wishlist | Read wishlist | Wishlist has data | Manage → Wishlist Lokal | Items appear | Not executed | Pending |  |
| TB-WL-003 | Wishlist | Remove wishlist | Wishlist has data | Tap remove | Item removed | Not executed | Pending |  |
| TB-WL-004 | Wishlist | Empty state | Wishlist empty | Open Wishlist | Empty state appears | Not executed | Pending |  |
| TB-WL-005 | Wishlist | Persistence | Wishlist has data | Restart app | Data remains | Not executed | Pending |  |
| TB-PN-001 | Product Note | Create note | Product exists | Detail → Catatan Produk → save note | Note saved | Not executed | Pending |  |
| TB-PN-002 | Product Note | Read note | Note exists | Open Product Note | Note appears | Not executed | Pending |  |
| TB-PN-003 | Product Note | Edit note | Note exists | Tap Edit → Update | Note updated | Not executed | Pending |  |
| TB-PN-004 | Product Note | Delete note | Note exists | Tap Hapus | Note removed | Not executed | Pending |  |
| TB-PN-005 | Product Note | Empty validation | Product Note open | Save empty note | Validation snackbar appears | Not executed | Pending |  |
| TB-PN-006 | Product Note | Persistence | Note exists | Restart app | Note remains | Not executed | Pending |  |
| TB-OR-001 | Order | Empty cart blocked | Cart empty | Open Cart | Create CTA absent/blocked | Not executed | Pending |  |
| TB-OR-002 | Order | Create from cart | Cart has item | Tap Buat Simulasi Order Lokal | Order created | Not executed | Pending | Cart not auto-cleared |
| TB-OR-003 | Order | Read list | Order exists | Manage → Simulasi Order Lokal | Order appears | Not executed | Pending |  |
| TB-OR-004 | Order | Open detail | Order exists | Tap order | Detail opens | Not executed | Pending |  |
| TB-OR-005 | Order | Update status | Detail open | Tap status stepper | Status updates locally | Not executed | Pending |  |
| TB-OR-006 | Order | Delete order | Order exists | Tap delete | Order removed | Not executed | Pending |  |
| TB-OR-007 | Order | Persistence | Order exists | Restart app | Order remains | Not executed | Pending |  |
| TB-OR-008 | Order | Forbidden copy | Order screens open | Inspect screen | No payment/shipping/address | Not executed | Pending |  |

## 8. SQLite Persistence Test

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| DB-001 | SQLite | Tables exist | Fresh/updated app | Run app | Version 2 DB opens | Not executed | Pending |  |
| DB-002 | SQLite | Data persists | Add product/cart/wishlist/order/note | Restart app | Data remains | Not executed | Pending |  |
| DB-003 | SQLite | Migration | Existing v1 database | Update app | New tables created without data loss | Not executed | Pending | Manual migration scenario |

## 9. SharedPreferences Test

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| PREF-001 | Preferences | User name | Settings open | Save name | `user_name` persists | Not executed | Pending |  |
| PREF-002 | Preferences | Dark mode | Settings open | Toggle dark mode | `is_dark_mode` persists | Not executed | Pending |  |
| PREF-003 | Preferences | Product sort | Home open | Change sort | `product_sort_type` persists | Not executed | Pending |  |
| PREF-004 | Preferences | View mode | Home open | Toggle view | `preferred_view_mode` persists | Not executed | Pending |  |
| PREF-005 | Preferences | Last category | Home open | Select category | `last_selected_category_id` persists | Not executed | Pending |  |
| PREF-006 | Preferences | Cart last opened | Open Cart | Close/reopen app | `cart_last_opened` stored | Not executed | Pending |  |

## 10. Provider State Test

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| PROV-001 | WishlistProvider | Toggle refresh | Product exists | Toggle wishlist | UI state updates | Not executed | Pending |  |
| PROV-002 | ProductNoteProvider | CRUD refresh | Product exists | Add/edit/delete note | List refreshes | Not executed | Pending |  |
| PROV-003 | OrderProvider | Status refresh | Order exists | Update status | Detail/list refreshes | Not executed | Pending |  |
| PROV-004 | InsightProvider | Load insight | Data exists | Open Insight | Cards/chart load | Not executed | Pending |  |

## 11. fl_chart Statistics Test

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| CHART-001 | Insight | Empty state | No data | Open Insight | Empty message appears | Not executed | Pending |  |
| CHART-002 | Insight | Real data | Data exists | Open Insight | Stat cards show counts | Not executed | Pending |  |
| CHART-003 | fl_chart | Chart appears | Count data exists | Open Insight | Bar chart renders | Not executed | Pending |  |
| CHART-004 | Insight | Refresh | Insight open | Pull refresh | Data reloads | Not executed | Pending |  |
| CHART-005 | Insight | No online analytics | App offline | Open Insight | Still works locally | Not executed | Pending |  |

## 12. CustomPainter / Gesture Test

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| CP-001 | OrderStatusStepper | Render | Order exists | Open detail | Stepper appears | Not executed | Pending | CustomPainter |
| CP-002 | OrderStatusStepper | Status match | Order status known | Open detail | Active status matches DB | Not executed | Pending |  |
| CP-003 | OrderStatusStepper | Tap status | Detail open | Tap step | Status updates locally | Not executed | Pending | Gesture |
| CP-004 | OrderStatusStepper | Not tracking | Detail open | Inspect copy | No shipping/tracking real | Not executed | Pending |  |

## 13. Navigation Test

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| NAV-001 | Bottom nav | Four tabs | App open | Inspect nav | Home/Cart/Manage/Settings only | Not executed | Pending |  |
| NAV-002 | Sub-screens | AppBar back | Open any sub-screen | Tap back | Returns safely | Not executed | Pending |  |
| NAV-003 | Manage hub | Entry points | Manage open | Tap Product/Category/Wishlist/Order/Insight | Each screen opens | Not executed | Pending |  |
| NAV-004 | Product detail | Entries | Detail open | Tap wishlist/note/cart | Flows work | Not executed | Pending |  |

## 14. Forbidden Feature Check

| Test Case ID | Feature | Scenario | Precondition | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| FORB-001 | Maps | No Maps | App/source | Inspect UI/source | No Maps/geolocation | Not executed | Pending |  |
| FORB-002 | Backend/API | No API | App/source | Inspect UI/source | No production API/backend | Not executed | Pending |  |
| FORB-003 | Payment | No payment | Order flow | Inspect screens | No payment/checkout real | Not executed | Pending |  |
| FORB-004 | Shipping | No shipping | Order flow | Inspect screens | No address/courier/shipping | Not executed | Pending |  |
| FORB-005 | Product variants | No variants | Product screens | Inspect screens | No size/variant/material/fit/care | Not executed | Pending |  |

## 15. Final Demo Scenario

1. Demo A2 baseline.
2. Demo Wishlist.
3. Demo Product Note.
4. Demo Order Simulation.
5. Demo Insight Statistics.
6. Explain SQLite, SharedPreferences, Provider, fl_chart, CustomPainter, and guardrails.

## 16. Known Issues

- Existing `flutter analyze` info-level lint remains in seed data and Manage Category.
- Full manual emulator/device regression is pending.
- Last `flutter run` built and installed APK, but connection to device was lost after install.

## 17. Final QA Decision

**Ready with minor notes.**

Reason:

- Static analysis shows only existing info-level lint.
- Build/install via `flutter run` succeeded before device connection was lost.
- Manual test plan is prepared, but full device validation should be completed before presentation.
