# Rejected Bookings Dashboard

An intelligent analytics dashboard for tracking and analyzing rejected bookings in real estate operations.

## Features

- **Date Parsing Intelligence**: Handles multiple Excel date formats including serial numbers, space-separated dates, and 2-digit years
- **Smart Filtering**: Filter by month and project with real-time statistics updates
- **KPI Cards**: Track key metrics including rejected bookings, refunds, swaps, payments, and revenue
- **Top 5 Reasons**: Visual breakdown of the most common rejection reasons
- **Detailed Table**: Comprehensive booking details with sortable columns
- **Dark/Light Mode**: Toggle between themes for comfortable viewing
- **Auto-Load**: Optionally auto-load Excel files from a specified path

## Installation

### Prerequisites
- Node.js (v14 or higher)
- npm (comes with Node.js)

### Setup

1. Clone this repository:
```bash
git clone https://github.com/emmanuel-n-araujo/Rejected-Bookings.git
cd Rejected-Bookings
```

2. Install dependencies:
```bash
npm install
```

3. Place your Excel file in the project directory or configure the auto-load path in `server.js`

## Usage

### Quick Start

Simply double-click `Start Dashboard.bat` to launch the dashboard automatically.

### Manual Start

```bash
node server.js
```

Then open your browser to: http://localhost:3000

## Configuration

### Auto-Load Excel File

Edit `server.js` and set the `AUTO_LOAD_PATH` variable:

```javascript
const AUTO_LOAD_PATH = 'path/to/your/excel/file.xlsx';
```

### Port Configuration

The default port is 3000. To change it, modify `server.js`:

```javascript
const PORT = 3000; // Change to your preferred port
```

## Excel File Format

The dashboard expects the following columns:
- Rejected Date
- Booking ID
- Project Name
- Tower/Building
- Unit Number
- Customer Name
- Value (Sales Price)
- Paid Amount
- Refund Status
- Rejection Reason
- Sales Agent
- Agency

## Key Enhancements

### Date Parsing
- Handles Excel serial numbers (both numeric and string)
- Supports DD/MM/YYYY, DD-MM-YYYY, and DD MM YYYY formats
- Interprets 2-digit years (e.g., '26' → 2026)
- Fixes xlsx library timezone offset bugs

### UI Refinements
- Increased font sizes for better readability
- Center-aligned table headers
- Enhanced card headers with consistent styling
- "Total Amount Refunded" card
- Renamed labels for clarity

## Technologies Used

- **Frontend**: React, Tailwind CSS
- **Backend**: Node.js, Express
- **Data Processing**: xlsx library
- **Styling**: Custom CSS with glassmorphism effects

## Browser Compatibility

- Chrome (recommended)
- Firefox
- Edge
- Safari

## License

Proprietary - One Development

## Support

For issues or questions, please contact the development team.

---

**Developed by the One Development Team**
*Inspired By You*
