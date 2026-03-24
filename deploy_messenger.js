const hre = require("hardhat");

async function main() {
  // Example: LayerZero Endpoint for Polygon Mumbai
  const LZ_ENDPOINT = "0xf69186df50aed11e42a7d7d29cce2b33ee203d41"; 

  const Messenger = await hre.ethers.getContractFactory("CrossChainMessenger");
  const messenger = await Messenger.deploy(LZ_ENDPOINT);

  await messenger.waitForDeployment();
  console.log(`CrossChainMessenger deployed to: ${await messenger.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
