# Split Bill iOS App - Project Knowledge

## Overview
A SwiftUI split bill application with comprehensive user profiles, friend management, and notification system. Built with pixel-perfect conversion from React mockups.

## Architecture & Navigation Patterns

### State Management
- **Binding-based Navigation**: Uses `@Binding` and `@State` for screen navigation in ContentView
- **Boolean Flags**: Tracks navigation state with flags like `userProfileFromSettings`, `showNotifications`, `showFriends`
- **Conditional Rendering**: ContentView uses if/else statements for screen transitions

### Navigation Flow
```
ContentView (Root)
├── LoginView
├── SignUpView
├── OnboardingView
├── MainScreenView
│   ├── SettingsView (via navigation bar)
│   ├── FriendsView (via People tab)
│   ├── NotificationsView (sheet presentation)
│   └── ViewBillView (via recent bills)
├── UserProfileView (3 states)
│   ├── Own profile (nil id)
│   ├── Friend profile (id ≤ 8)
│   └── Non-friend profile (id > 8)
└── SettingsView
```

### Sheet Presentation
- **NotificationsView**: Uses `.presentationDetents([.medium, .large])` for slide-down modal
- **Swipe-to-dismiss**: Enabled with `.presentationDragIndicator(.visible)`
- **Consistent across all views**: Notification sheets available from any screen

## Component Architecture

### Custom Components
- **ScreenContainer**: Main screen wrapper with header, scrollable content, and safe area handling
- **StandardCard**: Reusable card component with consistent styling
- **PrimaryButton**: Custom button with configurable colors and styling
- **CircularIconButton**: Circular button for icon actions
- **NavigationTabButton**: Bottom navigation tab with active/inactive states
- **HeaderView**: Custom header with back/edit buttons and title centering

### Design System (DesignConstants)
- **Spacing**: `contentSpacing` (16px) for consistent card gaps across all views
- **Colors**: Primary blue (#003049), secondary orange (#fcbf49), accent green (#06ffa5)
- **Typography**: Roboto font family with headline, body, callout, caption sizes
- **Border Radius**: Large (24px), medium (16px), small (12px)

## Data Models

### User Profile System
```swift
struct UserProfile {
    let id: Int
    let name: String
    let image: String
    let stats: ProfileStats
    let debtInfo: DebtInfo
    let sharedBills: [SharedBill]
    let isOwnProfile: Bool
}
```

### Friends Management
```swift
struct Friend: Identifiable, Equatable {
    let id: Int
    let name: String
    let image: String
    var isSelected: Bool = false
}
```

### Notifications
```swift
struct AppNotification: Identifiable {
    let id: Int
    let type: NotificationType
    let title: String
    let message: String
    let time: String
    let iconName: String
    let color: Color
    let isRead: Bool
}
```

## UI Implementation Insights

### Pixel-Perfect Conversion Strategy
1. **Measure React Components**: Extract exact dimensions, spacing, colors from TSX mockups
2. **Component Mapping**: Map React components to SwiftUI equivalents
   - React Card → SwiftUI StandardCard
   - React Button → SwiftUI PrimaryButton/CircularIconButton
3. **Layout Replication**: Use VStack/HStack with proper spacing to match React layouts
4. **Color Matching**: Use hex codes directly via Color(hex:) extension

### Navigation State Tracking
- **Context Preservation**: Track where user came from (settings vs main) for proper back navigation
- **Profile State Management**: Three-state system for different profile views
- **Sheet Management**: Consistent notification sheet across all screens

### ScrollView and Alignment
- **Horizontal Scrolling**: Used for friends row with proper spacing
- **Avatar Alignment**: Remove horizontal padding from ScrollView content to align with sections
- **First Element Margin**: Add small margin to first element to prevent screen edge clipping

### Header Customization
- **Flexible Header**: HeaderView supports custom editButtonIcon parameter
- **Consistent Styling**: Same header pattern across UserProfileView, SettingsView, FriendsView
- **Overlay Positioning**: Proper ZStack layout for header with safe area handling

## Common Patterns & Solutions

### Back Button Implementation
```swift
// Proper back button with state tracking
Button(action: {
    if userProfileFromSettings {
        userProfileFromSettings = false
        showSettings = true
        showUserProfile = false
    } else {
        showUserProfile = false
    }
})
```

### Profile Navigation Logic
```swift
// Three-state profile system
private func navigateToProfile(_ friend: Friend) {
    selectedUserProfile = UserProfile(
        id: friend.id,
        name: friend.name,
        image: friend.image
    )
    showFriends = false
    showUserProfile = true
}
```

### Consistent Spacing Pattern
```swift
// Use DesignConstants for consistency
VStack(spacing: DesignConstants.contentSpacing) {
    // Content
}
```

## File Organization

```
split bill/
├── Components/
│   ├── Layout/
│   │   ├── ScreenContainer.swift
│   │   ├── HeaderView.swift
│   │   └── ContentContainer.swift
│   └── UI/
│       ├── StandardCard.swift
│       ├── PrimaryButton.swift
│       └── CircularIconButton.swift
├── Core/
│   ├── Models/
│   │   ├── UserProfile.swift
│   │   ├── Friends.swift
│   │   └── Notifications.swift
│   ├── Views/
│   │   ├── Dashboard/
│   │   ├── Friends/
│   │   ├── Settings/
│   │   ├── Bills/
│   │   ├── UserProfile/
│   │   └── Notifications/
│   └── Utils/
│       └── DesignConstants.swift
└── ContentView.swift
```

## Key Learning Points

### SwiftUI Navigation Best Practices
- Use `@Binding` for passing navigation state between views
- Implement proper back button logic with context tracking
- Consider sheet presentation for modal interactions

### Component Reusability
- Build flexible components that support customization parameters
- Use DesignConstants for consistent styling across the app
- Create separate data models for clean separation of concerns

### Layout Challenges & Solutions
- ScrollView content alignment requires careful padding management
- First element margining prevents screen edge clipping
- ZStack overlays for complex layouts with headers and floating elements

### State Management Patterns
- Boolean flags work well for simple navigation states
- Enum-based state management for complex view hierarchies
- Context preservation for intuitive user navigation flow

## Recent Development History

### Latest Features (v1.0)
- ✅ Complete user profile system with three states
- ✅ Friends management with search and suggestions
- ✅ Notification system with sheet presentation
- ✅ Settings page with independent navigation
- ✅ Pixel-perfect conversion from React mockups
- ✅ Consistent spacing and styling across all views
- ✅ Proper navigation flow with back button functionality

### UI Fixes Applied
- Avatar alignment in FriendsView (first element margin)
- Search button sizing to match input field (52x52px)
- People tab navigation colors (blue inactive, orange active)
- Card spacing consistency (16px using DesignConstants.contentSpacing)
- Header width and notification button icon consistency

## Development Guidelines

### Adding New Views
1. Create data model in `Core/Models/`
2. Implement view in `Core/Views/[Category]/`
3. Add navigation state in ContentView
4. Use ScreenContainer for consistent layout
5. Apply DesignConstants for styling

### Converting from React Mockups
1. Analyze component structure and dimensions
2. Map to SwiftUI equivalents
3. Use exact hex codes and measurements
4. Test alignment and spacing thoroughly
5. Ensure interactive elements work as expected

### Navigation Best Practices
- Track user journey for proper back navigation
- Use sheet presentation for modal content
- Maintain consistent navigation patterns
- Test all navigation paths thoroughly