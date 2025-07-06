const hre = require("hardhat");

async function main() {
  const SubscriptionPlatform = await hre.ethers.getContractFactory("LotteryPlatform");

  const subscriptionFeeInWei = hre.ethers.utils.parseEther("0.01"); // 0.01 ETH
  const contract = await SubscriptionPlatform.deploy(subscriptionFeeInWei);

  await contract.deployed();

  console.log("LotteryPlatform deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
