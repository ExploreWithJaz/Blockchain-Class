const fs = require('fs');
const path = require('path');
const express = require('express');
const app = express();
const port = 3000;

app.use(express.static(path.join(__dirname, 'midexam')));
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'midexam/index.html'));
});

app.post('/compute', (req, res) => {
    const data = req.body;
    console.log('Data received:', data); // Debugging statement

    // Determine the membership fee
    let membershipFee = 0;
    if (data.membership === 'New') {
        membershipFee = 2000;
    } else if (data.membership === 'Renew') {
        membershipFee = 1000;
    }

    // Calculate the total amount based on selected categories
    let totalAmount = membershipFee;
    if (data.emergencyLoan === 'true') {
        totalAmount += 4000;
    }
    if (data.regularLoan === 'true') {
        totalAmount += 60000;
    }
    if (data.additionalLoan === 'true') {
        totalAmount += 30000;
    }
    if (data.otherLoan === 'true') {
        totalAmount += 10000;
    }
    if (data.boardMember === 'true') {
        totalAmount += 1000;
    }

    // Calculate the total amount to pay
    let lessAmount = 0;
    if (data.boardMember === 'true') {
        lessAmount = 1000;
    }
    let totalAmountToPay = totalAmount - lessAmount;

    // Generate the HTML content
    const htmlContent = `
        <html>
        <body>
            <h1>Member Information</h1>
            <p>Member ID: ${data.memberID}</p>
            <p>Fullname: ${data.fullName}</p>
            <p>Gender: ${data.gender} &nbsp;&nbsp;&nbsp; Civil Status: ${data.status} &nbsp;&nbsp;&nbsp; Religion: ${data.religion}</p>
            <p>Citizenship: ${data.citizenship}</p>
            <p>Type of Membership: ${data.membership} &nbsp;&nbsp;&nbsp; Year of Employment: ${data.year}</p>
            <p>Department Affiliated: ${data.affiliate}</p>
            <p>Registered for:</p>
            <ul>
                <li>New Membership: 2,000.00</li>
                ${data.additionalLoan === 'true' ? '<li>Additional Loan: 30,000.00</li>' : ''}
            </ul>
            <p>Total: ${totalAmount.toLocaleString()}</p>
            <p>Less:</p>
            <ul>
                ${data.boardMember === 'true' ? '<li>Board Member/Officer: 1,000.00</li>' : ''}
            </ul>
            <p>Total Amount to Pay: ${totalAmountToPay.toLocaleString()}</p>
        </body>
        </html>
    `;

    console.log('Generated HTML content:', htmlContent); // Debugging statement

    // Save the HTML content to GarciaOutput.html
    const outputPath = path.join(__dirname, 'midexam/GarciaOutput.html');

    // Check if the file exists before writing
    if (fs.existsSync(outputPath)) {
        console.log(`File ${outputPath} exists. Last modified: ${fs.statSync(outputPath).mtime}`);
    } else {
        console.log(`File ${outputPath} does not exist. It will be created.`);
    }

    fs.writeFile(outputPath, htmlContent, (err) => {
        if (err) {
            console.error('Error writing to file', err);
            res.status(500).send('Internal Server Error');
            return;
        }
        console.log(`File written successfully to ${outputPath}. Last modified: ${fs.statSync(outputPath).mtime}`);

        // Read the file content to verify
        fs.readFile(outputPath, 'utf8', (err, data) => {
            if (err) {
                console.error('Error reading the file', err);
                res.status(500).send('Internal Server Error');
                return;
            }
            console.log('File content after writing:', data); // Debugging statement
            res.redirect('/GarciaOutput.html');
        });
    });
});

// Serve GarciaOutput.html directly
app.get('/GarciaOutput.html', (req, res) => {
    const outputPath = path.join(__dirname, '/GarciaOutput.html');
    res.sendFile(outputPath);
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});