const main = async () => {
  try {
    const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    let txn = await nftContract.makeAnEpicNFT();
    txn.wait();

    txn = await nftContract.makeAnEpicNFT();
    txn.wait();
  } catch (error) {
    console.error(error);
  }
};

main();
