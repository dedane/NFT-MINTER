const { hexStripZeros } = require("ethers/lib/utils")

const main = async() => {
        const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNft');
        const nftContract = await nftContractFactory.deploy();
        await nftContract.deployed();
        console.log("Contract deployed to:", nftContract.address);

        //Call the fuction
        let txn = await nftContract.makeAnEpicNFT();

        //Wait for it to be mined
        await txn.wait();

        //Mint another nft for fun
        txn = await nftContract.makeAnEpicNFT();

        //wait for it to be mined
        await txn.wait();
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