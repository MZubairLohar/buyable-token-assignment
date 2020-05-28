Create a token based on ERC20 which is buyable. Following features should present;

1. Any one can get the token by paying against ether
2. Add fallback payable method to Issue token based on Ether received. Say 1 Ether = 100 token.
3. Owner on creation of token will decide the Value based on ether.
4. There should be an additional method to adjustPrice that allow owner to adjust price.
5. Limit the buyer that it should be the EOA.
6, The buyer can buy token even against 1 wei.