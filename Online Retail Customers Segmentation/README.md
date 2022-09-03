## Online-Retail-Customers-Segmentation
K-Means Clustering, Elbow Method, Silhouette Analysis, Hierarchical Clustering <br>

Data Source: https://archive.ics.uci.edu/ml/datasets/online+retail <br>

### Problem statement:
This is a transnational data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail. The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers.
<br>

### Business Goal:
To segment the Customers based on RFM so that the company can target its customers efficiently. <br>

### Approach:
* Feature Engineering, outliers removal, Standardization
* Used K-Means Clustering with 3 clusters based on Elbow Method and Silhouette Analysis
* Used Agglomerative and Divisive Hierarchical Clustering with 3 clusters based on Dendrogram
* Analyzed 3 customer segments on the basis of Recency, Frequency, and Monetary

##### Analysed the Customers based on RFM and created new attributes for same:

* R (Recency): Number of days since last purchase
* F (Frequency): Number of tracsactions
* M (Monetary): Total amount of transactions (revenue contributed)

### Variable description:
InvoiceNo: Invoice number. Nominal, a 6-digit integral number uniquely assigned to each transaction. If this code starts with letter 'c', it indicates a cancellation. <br>
StockCode: Product (item) code. Nominal, a 5-digit integral number uniquely assigned to each distinct product. <br>
Description: Product (item) name. Nominal. <br>
Quantity: The quantities of each product (item) per transaction. Numeric. <br>
InvoiceDate: Invice Date and time. Numeric, the day and time when each transaction was generated. <br>
UnitPrice: Unit price. Numeric, Product price per unit in sterling. <br>
CustomerID: Customer number. Nominal, a 5-digit integral number uniquely assigned to each customer. <br>
Country: Country name. Nominal, the name of the country where each customer resides. <br>
