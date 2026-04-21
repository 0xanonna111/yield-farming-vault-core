// Web3 logic for triggering the harvest and compound function
const { ethers } = require("ethers");

async function harvestRewards(strategyContract, signer) {
    console.log("Initiating compounding sequence...");
    try {
        const tx = await strategyContract.connect(signer).harvest();
        const receipt = await tx.wait();
        console.log("Harvest successful. Gas used:", receipt.gasUsed.toString());
    } catch (error) {
        console.error("Harvest failed:", error.message);
    }
}

module.exports = { harvestRewards };
