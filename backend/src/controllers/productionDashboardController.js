const ProductionDashboard = require("../models/ProductionDashboard");

// ================= DASHBOARD =================

exports.getDashboard = async (req, res) => {

    try {

        const { fromDate, toDate } = req.query;

        const data =
            await ProductionDashboard.getDashboard(
                fromDate,
                toDate
            );

        res.json({
            success: true,
            data
        });

    }
    catch (err) {

        console.error(err);

        res.status(500).json({
            success: false,
            message: err.message
        });

    }

};