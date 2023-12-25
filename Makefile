-include .env


deploy:; forge script script/DeployFirstNFTCollection.s.sol --rpc-url $(MUMBAI_RPC_URL) --broadcast --private-key $(PRIVATE_KEY) --verify --etherscan-api-key $(API_KEY) -vvv
mintNft:; forge script script/Interactions.s.sol:MintFirstNFT --rpc-url $(MUMBAI_RPC_URL) --broadcast --private-key $(PRIVATE_KEY)
getTokenUri:; forge script script/Interactions.s.sol:GetTokenURI --rpc-url $(MUMBAI_RPC_URL) --broadcast --private-key $(PRIVATE_KEY)