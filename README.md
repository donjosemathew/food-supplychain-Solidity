<img src="/logo.svg"/>

 # AgriChain
 1.2 Project Description

AgriChain aims to leverage the power of blockchain technology to increase transparency in the agri-food supply chain. By creating an immutable and secure ledger of all transactions and events throughout the supply chain, we can help to ensure that consumers have access to accurate and trustworthy information about the origins and quality of the food they consume. Through this project, hope is to promote greater accountability and sustainability in the agri-food industry, ultimately leading to a safer, healthier, and more transparent food supply for everyone.

1.3 Scope

Currently agri-food supply chain faces challenges related to the lack of visibility and traceability, making it difficult for stakeholders to monitor the movement and condition of products. Interference and fraud can also occur in the supply chain, impacting the quality and safety of products.

By incorporating Blockchain technology, AgriChain promises improved food safety, increased transparency and trust, better Supply Chain Management, compliance with regulations by providing an immutable record of all transactions and events in the supply chain.

2 System Overview

1. Data collection: The system collects data from various sources along the agri-food supply chain, including farmers, suppliers, distributors, retailers, and consumers.
2. Data verification and validation: The data collected is verified and validated using a consensus mechanism, such as proof-of-work or proof-of-stake, to ensure its
3. accuracy and integrity.
4. Data storage: The validated data is stored on a blockchain network, which provides an immutable and transparent ledger of all transactions and events in the supply chain.
5. Data access: The stakeholders in the agri-food supply chain can access the blockchain network to view the information relevant to their role, such as the origin, quality, and safety of the food products.
6. Smart contracts: The system uses smart contracts to automate certain supply chain processes, such as quality control, inventory management etc.
7. Analytics and reporting: The system provides analytics and reporting tools to help stakeholders in the agri-food industry make informed decisions based on the data collected and stored on the blockchain network.



<img src="/arch (1).png"/>

**Verification**

In the agriculture supply chain, blockchain technology has revolutionized the way participants interact with each other. The participants use web portals to launch their smart contracts, which are designed to ensure that all parties involved in the supply chain follow the rules and regulations that have been set up.

As the smart contracts are launched, the participants' details, including their name, location, and system time, are automatically added to the blockchain. These details cannot be edited by the participants, as they are set up beforehand to ensure transparency and prevent tampering.

Moreover, the technology verifies the current location of the participant when they deploy a smart contract. This ensures that the goods are being transported to the right place and there are no unnecessary delays or detours. The time and date of production of the goods are also verified, ensuring that everything is within the set timeline.

**Smart Contract Generation**

Blockchain technology has revolutionized the agriculture supply chain by using smart contracts to indicate each stage, including adding relevant details and contract addresses. An "isLastStage" variable is used to indicate the final stage, and important information such as location, time, and participant details are added automatically. The use of blockchain has increased transparency, minimized fraud, reduced costs, and improved efficiency.

**QR code Generation**

Blockchain technology generates a QR code after each stage in the agricultural supply chain, which allows participants of the next stage to verify details and consumers to identify origin and production time. This increases transparency, security, and efficiency in the supply chain.

<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/59858506/248524049-a11f336c-8b2b-4cf1-a7fb-756757fa90e5.png"/>


QR-Prod that stores the details of the product and is affixed to the packaging after deploying contract. At other locations the QR-Trans is generated for uploading to the blockchain. This code need not be fixed to the product and can be scanned of the screen. If any of the QR-Trans is missing, then the blockchain would have an incomplete record and the supply chain trace would be broken. The QR labels also can’t be forged easily because they are generated by a physically secure computer with a locked in private keys. We could have a case whereby a merchant trying to claim the origin of a product by affixing a QR-Prod in the middle of the supply chain (Fig. 5, Case 1 and Case 2). However, it needs to have the QR-Trans to upload the location but since the vendor can’t alter the location in the QR, he can’t claim a different origin. The QR-Prod also can’t be re-used because it has a timestamp in it. Suppose now the produce originator duplicates the product QR-Prod and affixed it multiple products using the same code (Fig. 5, Case 3). This will cause confusion because the same batch-id would be used in the blockchain. This would not be advantageous to the primary or original producer. We assume that the primary producer is sincere and trustworthy because making fraudulent claims would not help the sales of the produce. In another scenario, the middleman duplicates a QR-Prod and affix it to a produce from a different source of origin (Fig. 5, Case 4). A double transaction would have been created for the product where the QR-Prod was duplicated. This could be detected by the blockchain tracking software easily. Instead of duplicating the QR-Prod, the label could be transferred and fraudulently affixed on another product (Fig. 6, Case 5). Now we a batch of genuine produce and a batch of fraudulently labelled produce. The re-seller (or distributor) would have more quantity (including the dubious items) to sell than he had received from the genuine source. He would have to convince buyers why some are tracked, and some are not, and may get away with it in isolated markets. In the long run this may not be sustainable maintaining the deception.
