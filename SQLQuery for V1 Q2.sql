Declare @tblCustomer Table
(
	CustomerId	Int identity(1,1),
	CustomerName NVarChar(80)
)

Declare @tblInvoice Table
(
	InvoiceId Int identity(1,1), 
	InvoiceNumber nvarchar(80),
	InvoiceDate DateTime,
	InvoiceAmount Decimal(12,2),
	CustomerId Int

)

Insert Into @tblCustomer(CustomerName) Values('Simon')
Insert Into @tblCustomer(CustomerName) Values('William')
Insert Into @tblCustomer(CustomerName) Values('David')
Insert Into @tblCustomer(CustomerName) Values('Steve')
Insert Into @tblCustomer(CustomerName) Values('Pauline')

Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV001', '01/01/2020', 450000.00, 1)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV002', '01/02/2020', 150000.00, 1)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV003', '01/11/2025', 50000.00, 1)

Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV004', '01/01/2020', 450000.00, 2)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV005', '01/02/2020', 150000.00, 2)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV006', '01/12/2025', 50000.00, 2)

Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV007', '01/01/2020', 550000.00, 3)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV008', '01/02/2020', 250000.00, 3)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV009', '01/03/2025', 100000.00, 3)

Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV010', '01/01/2020', 450000.00, 4)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV011', '01/02/2020', 150000.00, 4)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV012', '01/01/2025', 50000.00, 4)

Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV013', '01/01/2020', 120000.00, 5)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV014', '01/02/2020',570000.00, 5)
Insert Into @tblInvoice(InvoiceNumber, InvoiceDate, InvoiceAmount, CustomerId)
Values('INV015', '01/10/2025', 550000.00,5)

--Select * From @tblCustomer
--Select *From @tblInvoice order by CustomerId

SELECT CustomerName, 
InvoiceDate, 
InvoiceNumber, 
InvoiceAmount 
FROM @tblInvoice Inv Inner Join @tblCustomer Cus ON Inv.CustomerId = Cus.CustomerId
WHERE YEAR(Inv.InvoiceDate) = YEAR(GETDATE()) AND MONTH(Inv.InvoiceDate) = MONTH(GETDATE()) ORDER BY Inv.InvoiceNumber;

