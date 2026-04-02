-include .env

.PHONY: all test clean deploy mint

# Default variables
DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# Logic to switch between Anvil (default) and Sepolia
# Usage: make deploy ARGS="--network sepolia"
ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
else
	NETWORK_ARGS := --rpc-url http://127.0.0.1:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast
endif

# Deployment Target
deploy:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(NETWORK_ARGS)

# Interaction Target (Minting)
mint:
	@forge script script/Interaction.s.sol:MintBasicNft $(NETWORK_ARGS)

# Helper for testing
test:
	forge test

mintMood:
	@forge script script/Interaction.s.sol:MintMoodNft $(NETWORK_ARGS)

deployMood:
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft $(NETWORK_ARGS)

TOKEN_ID ?= 0

flipMood:
		@forge script script/Interaction.s.sol:FlipMoodNft --sig "run(uint256)" $(TOKEN_ID) $(NETWORK_ARGS)