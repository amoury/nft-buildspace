const main = async () => {
  try {
    const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to ", nftContract.address);

    let txn = await nftContract.makeAnEpicNFT();
    await txn.wait();
    console.log("Minted NFT #1");

    txn = await nftContract.makeAnEpicNFT();
    await txn.wait();
    console.log("Minted NFT #2");
  } catch (error) {
    console.error(error);
  }
};

main();
