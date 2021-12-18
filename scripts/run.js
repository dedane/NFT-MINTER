const { hexStripZeros } = require("ethers/lib/utils")

const main = async() => {
        const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNft');
        const nftContract = await nftContractFactory.deploy();
        await nftContract.deployed();
        console.log("Contract deployed to:", nftContract.address);
}

const runMain = async() => {

    try{
        await main();
        process.exit(0);

    } catch(e) {
        console.log(e);
        process.exit(1);

    }

}
runMain();