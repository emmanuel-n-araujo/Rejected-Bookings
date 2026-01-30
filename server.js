const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3000;
const EXCEL_PATH = path.join(__dirname, 'data.xlsx');

const mimeTypes = {
    '.html': 'text/html',
    '.js': 'application/javascript',
    '.css': 'text/css',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
};

const server = http.createServer((req, res) => {
    console.log(`Request: ${req.url}`);

    // CORS headers
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET');

    // API endpoint to get the Excel file
    if (req.url === '/api/data') {
        console.log('Serving Excel file from:', EXCEL_PATH);

        if (!fs.existsSync(EXCEL_PATH)) {
            console.error('Excel file not found at:', EXCEL_PATH);
            res.writeHead(404, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ error: 'Excel file not found', path: EXCEL_PATH }));
            return;
        }

        try {
            const fileBuffer = fs.readFileSync(EXCEL_PATH);
            res.writeHead(200, {
                'Content-Type': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                'Content-Length': fileBuffer.length
            });
            res.end(fileBuffer);
            console.log('Excel file served successfully!');
        } catch (err) {
            console.error('Error reading file:', err);
            res.writeHead(500, { 'Content-Type': 'application/json' });
            res.end(JSON.stringify({ error: err.message }));
        }
        return;
    }

    // Serve static files
    let filePath = req.url === '/' ? '/dashboard.html' : req.url;
    filePath = path.join(__dirname, filePath);

    const ext = path.extname(filePath).toLowerCase();
    const contentType = mimeTypes[ext] || 'application/octet-stream';

    fs.readFile(filePath, (err, content) => {
        if (err) {
            if (err.code === 'ENOENT') {
                res.writeHead(404);
                res.end('File not found');
            } else {
                res.writeHead(500);
                res.end('Server error: ' + err.code);
            }
        } else {
            // Add Cache-Control to prevent caching issues
            res.writeHead(200, {
                'Content-Type': contentType,
                'Cache-Control': 'no-store, no-cache, must-revalidate, proxy-revalidate',
                'Pragma': 'no-cache',
                'Expires': '0',
            });
            res.end(content);
        }
    });
});

server.listen(PORT, () => {
    console.log('');
    console.log('========================================');
    console.log('  Rejected Bookings Dashboard Server');
    console.log('========================================');
    console.log(`  Open: http://localhost:${PORT}`);
    console.log(`  Excel: ${EXCEL_PATH}`);
    console.log('========================================');
    console.log('');
});
