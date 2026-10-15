from web3 import Web3, HTTPProvider


blockchain_address = 'http://127.0.0.1:7545'
web3 = Web3(HTTPProvider(blockchain_address))
web3.eth.defaultAccount = web3.eth.accounts[0]


amount = 1


toaddress = "0x417cc7a4Bbc6e8FA58563FcB944aE85Cb482807A"

abcd = web3.from_wei(int(amount), 'ether')
print(abcd)

nonce = web3.eth._get_transaction_count("0x07eD3Ca5923b998410C309aD0d9987a9885cBcFD")

tx = {
    'nonce': nonce,
    'to': toaddress,
    'value': web3.to_wei(amount, 'ether'),
    'gas': 200000,
    'gasPrice': web3.to_wei('50', 'gwei')
}
signedtx = web3.eth.account.sign_transaction(tx,private_key="0xc95c9b7a5bf4217f2839e427bd4b309cc55bd3453f311e8ffc689237a03aacb0")
hashx = web3.eth.send_raw_transaction(signedtx.raw_transaction)

print("okkkk")

