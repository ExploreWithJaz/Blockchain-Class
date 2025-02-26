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
        "NCR": { "Residential": 10.26, "Low-Commercial": 10.81, "Low-Industrial": 9.69, "High-Commercial": 8.37, "High-Industrial": 11.25 },
        "Luzon": { "Residential": 10.13, "Low-Commercial": 10.52, "Low-Industrial": 9.55, "High-Commercial": 8.33, "High-Industrial": 11.26 },
        "Visayas": { "Residential": 9.57, "Low-Commercial": 8.71, "Low-Industrial": 8.78, "High-Commercial": 8.66, "High-Industrial": 10.65 },
        "Mindanao": { "Residential": 7.04, "Low-Commercial": 6.59, "Low-Industrial": 6.55, "High-Commercial": 6.19, "High-Industrial": 7.85 },
        "Other regions": { "Residential": 9.77, "Low-Commercial": 10.08, "Low-Industrial": 8.93, "High-Commercial": 8.08, "High-Industrial": 9.01 }
    };

    const rate = rates[region][classification];
    const consumptionBill = totalConsumption * rate;

    const generationCharge = consumptionBill * 0.55;
    const transmissionCharge = consumptionBill * 0.101;
    const distributionCharge = consumptionBill * 0.175;
    const taxes = consumptionBill * 0.117;
    const otherTaxes = consumptionBill * 0.057;

    const totalBill = consumptionBill + generationCharge + transmissionCharge + distributionCharge + taxes + otherTaxes;

    res.json({
        totalConsumption,
        rate,
        consumptionBill,
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