# Sri Lankan Restaurant Finder 🍽️

A modern web application that helps users find restaurants in Sri Lanka based on their taste preferences, cuisine type, budget, and location. Built with React for the frontend and Prolog for the intelligent recommendation system.

## 🌟 Features

- **Smart Filtering**: Find restaurants based on multiple criteria:
  - Taste preferences (Spicy, Sweet, Mild, Savory)
  - Cuisine types (Sri Lankan, Indian, Italian, Japanese, Chinese, etc.)
  - Budget levels (Low, Medium, High)
  - Cities (Colombo, Kandy, Galle, Negombo, Jaffna, Matara)
- **Real-time Results**: Instant restaurant recommendations
- **Modern UI**: Clean and responsive design built with Tailwind CSS
- **Intelligent Backend**: Prolog-based recommendation system

## 🚀 Technology Stack

- **Frontend**:
  - React
  - Tailwind CSS
  - Lucide React (for icons)
  - Vite (build tool)
- **Backend**:
  - SWI-Prolog
  - HTTP server for API endpoints

## 📋 Prerequisites

- Node.js (v14 or higher)
- SWI-Prolog
- Git

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone [your-repository-url]
   cd food-Recomandation-System-main
   ```

2. **Set up the Frontend**
   ```bash
   cd foodFinder
   npm install
   ```

3. **Set up the Backend**
   ```bash
   cd Backend
   # Make sure SWI-Prolog is installed and accessible from command line
   ```

## 🏃‍♂️ Running the Application

1. **Start the Backend Server**
   ```bash
   cd Backend
   swipl server.pl
   # The server will start on http://localhost:8080
   ```

2. **Start the Frontend Development Server**
   ```bash
   cd foodFinder
   npm run dev
   # The frontend will be available at http://localhost:5173
   ```

## 🎯 How to Use

1. Open the application in your web browser
2. Use the filter controls to specify your preferences:
   - Select your preferred taste
   - Choose a cuisine type
   - Set your budget level
   - Pick a city
3. Click "Find Restaurants" to get personalized recommendations
4. Browse through the recommended restaurants that match your criteria

## 📁 Project Structure

```
food-Recomandation-System-main/
├── Backend/
│   ├── restaurants.pl    # Restaurant database and rules
│   └── server.pl        # Prolog HTTP server
└── foodFinder/
    ├── src/
    │   ├── App.jsx      # Main application component
    │   ├── assets/      # Images and static files
    │   └── ...
    ├── index.html
    └── package.json
```

## 🤝 Contributing

Contributions are welcome! Feel free to:
1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Credits

Developed with ❤️ by FoodFinder

---

Feel free to star ⭐ this repository if you find it helpful!
