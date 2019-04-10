# FOSSEE
Digital Identity - KYC


README
****************************************************************************************************************************************************************************
Ellipticle curve algorithm may be incorporated to generate public and private key pair for digital signature of citizens data.
Inter Planetary  File system is used to store citizens photograph. 
Citizen---->
   *Full Name
   *Aadhar number
   *Permanent Account Number
   *Mobile Number
   *Hash Generated after photograph image upload on ipfs.
   *Date of Birth

Organisation-->
    *Organisation name
    *Ether Adderess
    *Unique registered Number

Request-->
    *User Name
    *Bank Number
    *After verification checks kyc status


functions ------>
Add User :
     Citizen registration by giving following credentials:
    *Name
    *Aadhar no.
    *User ethereum ID
    *Permanent Account Number
    *Mobile Number
    *Hash Generated after photograph image upload on ipfs.
    *Date of Birth


Add Bank :
    Bank registration by giving following credentials:
    *Organisation name
    *Ether Adderess
    *Unique registered Number

 After all the required citizen and bank organisation is registered 
 Now user get added to by organisation 
addRequest() 
    function is called which map 
   
user name------>bankAddress

allowBank() function will allow the user to finally get verify to the last stage of know your customer by specifing :
--------------------
Uname: string
bank_ethereum_Address: address
ifallowed: bool
--------------------

if ifallowed status is given true, users kyc will be verified and validated.


