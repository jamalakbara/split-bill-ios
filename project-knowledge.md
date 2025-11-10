# Split Bill App - Project Knowledge

## Overview
Split Bill is a SwiftUI-based mobile application for managing shared expenses, bills, and payments between friends and groups. The app features comprehensive bill splitting, group management, achievement tracking, and notification systems.

## Architecture
- **Platform**: iOS (SwiftUI)
- **Navigation**: Sheet-based navigation with state management
- **Architecture**: Component-based with reusable UI elements
- **Styling**: Centralized design constants for consistency

## Key Components

### Header System
- **ScreenContainer**: Main wrapper component with optional header and scrollable content
- **HeaderView**: Reusable header with back/edit buttons and title support
- **HeaderContentView**: Flexible header content for different header types
- **HeaderType Enum**: `.simple`, `.detail`, `.custom` for different header configurations

### Reusable Components
- **StandardCard**: Consistent card styling with borders and shadows
- **CircularIconButton**: Round button for header actions
- **PrimaryButton**: Main action button with customizable styling
- **BaseCard**: Foundation card component

### Navigation Flow
App uses sheet-based navigation with @State bindings for view management:
- Login → SignUp → Onboarding → MainScreen
- Settings, Notifications, Achievements accessible via sheets
- UserProfile, Friends, Groups, GroupDetail accessible via sheets

## Recent Development

### Global Bottom Navigation Refactoring (Latest Session)
**Major Architecture Overhaul**: Transformed app from individual bottom navigation implementations to unified global tab-based navigation system.

#### **1. Navigation System Transformation**
- **Problem Identified**: Each view (MainScreen, Groups, Friends, Settings) had duplicate bottom navigation code with inconsistent state management
- **Solution Implemented**: Single `GlobalBottomNavigation` component with centralized tab state management
- **Result**: Native mobile UX with persistent tab bar, no code duplication, consistent active states

#### **2. New Navigation Components Created**
- **`AppTab.swift`**: Enum defining 4 main tabs (Home, Groups, People, Settings) with icons and titles
- **`GlobalBottomNavigation.swift`**: Reusable bottom navigation component with floating + button, proper active state highlighting
- **`ContentView.swift`**: Completely refactored to use tab-based navigation with ZStack structure

#### **3. Individual Views Simplified**
- **MainScreenView**: Reduced from 7 parameters to 3 (`showViewBill`, `selectedBill`, `showNotifications`), removed duplicate bottom nav
- **GroupsView**: Reduced from 7 parameters to 2 (`showGroupDetail`, `selectedGroup`), removed duplicate bottom nav
- **FriendsView**: Reduced from 6 parameters to 2 (`showUserProfile`, `selectedUserProfile`), removed duplicate bottom nav
- **SettingsView**: Reduced from 5 parameters to 1 (`showAchievements`), simplified navigation handling

#### **4. Navigation Flow Modernized**
- **Before**: Sheet-based navigation for main sections (showGroups, showFriends, showSettings)
- **After**: Direct tab switching with `selectedTab: AppTab` state
- **Maintained**: Modal sheets for detail views (UserProfile, Notifications, Achievements, GroupDetail)

#### **5. Technical Benefits Achieved**
- **Single Source of Truth**: All navigation state managed in ContentView
- **No Code Duplication**: One global bottom navigation component
- **Parameter Simplification**: Average 65% reduction in parameters per view
- **Consistent Active States**: Proper tab highlighting across all views
- **Easy Extensibility**: Adding new tabs requires minimal changes

### Previous Session: AchievementsView Enhancements
1. **Header Title Fix**: Modified HeaderView to display titles for both `.simple` and `.custom` header types
2. **StandardCard Refactoring**: Replaced custom card styling with StandardCard component for consistency
3. **Notification Button**: Added notification bell button to AchievementsView header
4. **Layout Optimization**: Fixed stats cards overlapping header buttons by adjusting spacing and header height

#### **Previous Changes Made:**
- **HeaderView.swift**: Changed title display condition from `headerType == .simple` to `(headerType == .simple || headerType == .custom)`
- **AchievementsView.swift**:
  - Refactored achievementCard() to use StandardCard
  - Added notification button with proper binding
  - Fixed header spacing issues (80px top padding, 280px header height)
  - Maintained custom stats cards within header content

### ScreenContainer Integration
The app uses ScreenContainer for consistent page layouts with:
- Automatic header generation based on type
- Scrollable content area
- Consistent styling and spacing
- Support for custom header content

## Design System

### Color Palette
- **Primary**: #003049 (Dark blue)
- **Secondary**: #f77f00 (Orange)
- **Accent**: #fcbf49 (Yellow)
- **Background**: #eae2b7 (Light yellow)
- **Text**: Various opacities of primary color
- **White**: #ffffff

### Typography
- **Roboto font family** throughout
- Standardized sizes: Title1, Headline, Body, Callout, Caption
- Consistent weight usage: Heavy, Bold, Semibold, Medium

### Layout Constants
- **Corner Radius**: Card (16px), Large (24px), Button (28px)
- **Border Width**: Card (4px)
- **Shadow**: Standardized offsets and radius
- **Spacing**: Consistent padding and margins

## Data Models

### Core Models
- **UserProfile**: User information and settings
- **GroupModel**: Group management with members and expenses
- **Bill**: Individual bill details and splitting logic
- **Achievement**: Gamification system with progress tracking
- **AppNotification**: In-app notification system

### Mock Data
Comprehensive mock data systems for development and previews, including Achievement.mockAchievements for the achievements system.

## Current State
- Fully functional navigation system
- Complete settings and profile management
- Comprehensive achievements system with stats cards
- Group and bill management capabilities
- Notification system with sheet presentation
- Consistent design system implementation

## Development Notes
- All views use consistent ScreenContainer pattern
- Custom header content properly integrated with header button layout
- StandardCard component ensures UI consistency across all card elements
- Navigation state managed through @State bindings in ContentView