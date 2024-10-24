# Event Orchestrator

An **Event Orchestrator** application is designed to manage and coordinate various aspects of organizing events, ensuring smooth execution from planning to post-event activities. This application is built using Flutter and Dart, with AppWrite for backend services and Stripe for payment processing.

## Features

### General Features

#### 1. Event Creation and Management

- Create new events with details such as name, date, time, location, description, and categories.
- Edit and update event information as needed.
- Set event status (e.g., draft, published, canceled).

#### 2. Participant Management

- Allow participants to register online.
- Manage attendee lists, registrations, and check-in status.
- Generate attendee badges and QR codes.

#### 3. Ticketing and Payments

- Online ticket sales with multiple ticket types (e.g., general admission, VIP).
- Integration with Stripe for secure transactions.
- Manage refunds, discounts, and promotional codes.

## Future Implementations

### 1. Task and Workflow Management

- Assign tasks to team members or volunteers.
- Set deadlines, priorities, and task dependencies.
- Workflow automation for task notifications, reminders, and approvals.

### 2. Venue and Resource Management

- Manage venue bookings, layouts, and seating arrangements.
- Coordinate with vendors (e.g., catering, audio-visual) and track vendor contracts.
- Inventory management for event supplies and materials.

### Screenshots

<img src='login.jpg' width='200'/>  <img src='register.jpg' width='200'/>  <img src='home_screen.jpg' width='200'/>  <img src='free_event.jpg' width='200'/>  <img src='paid_event.jpg' width='200'/>  <img src='create_event.jpg' width='200'/>

**Note:** If you encounter any issues or have suggestions for improvement, please feel free to [create an issue](https://github.com/VaibhavCodeClub/learn/issues/new/choose) on our GitHub repository. We appreciate your feedback!

## Tech Stack

- **Frontend:** Flutter, Dart
- **Backend:** AppWrite
- **Payments:** Stripe

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Dart](https://dart.dev/get-dart) (comes with Flutter)
- [AppWrite](https://appwrite.io/docs/installation) (self-hosted or cloud)
- [Stripe](https://stripe.com/docs) account for payment processing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/event-orchestrator.git
   ```
2. Navigate to the project directory:
   ```bash
   cd odoohackathon24
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Set up your environment variables (create a .env file):
   ```bash
   STRIPE_PUBLISH_KEY=<your_publish_key>
   STRIPE_SECRET_KEY=<your_publish_key>
   ```

### Running the Application

- Start the application:
  ```bash
  flutter run
  ```
