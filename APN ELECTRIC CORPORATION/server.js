const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public/index.html'));
});

app.post('/calculate', (req, res) => {
    const { previousConsumption, presentConsumption, classification, region } = req.body;

    const totalConsumption = parseFloat(presentConsumption) - parseFloat(previousConsumption);

    const rates = {
        "NCR": { "Residential": 10.26, "Commercial": 10.81, "Industrial": 9.69 },
        "Luzon": { "Residential": 10.13, "Commercial": 10.52, "Industrial": 9.55 },
        "Visayas": { "Residential": 9.57, "Commercial": 8.71, "Industrial": 8.78 },
        "Mindanao": { "Residential": 7.04, "Commercial": 6.59, "Industrial": 6.55 },
        "Other regions": { "Residential": 9.77, "Commercial": 10.08, "Industrial": 8.93 }
    };

    const rate = rates[region][classification];
    const totalBill = totalConsumption * rate;

    const generationCharge = totalBill * 0.55;
    const transmissionCharge = totalBill * 0.101;
    const distributionCharge = totalBill * 0.175;
    const taxes = totalBill * 0.117;
    const otherTaxes = totalBill * 0.057;

    res.json({
        totalConsumption,
        generationCharge,
        transmissionCharge,
        distributionCharge,
        taxes,
        otherTaxes,
        totalBill
    });
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});