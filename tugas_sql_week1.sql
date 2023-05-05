-- Tugas Assessment SQL Week #1
-- Name : Mohammad Iqbal
-- --------------------------


-- ## QUERYING DATA

-- Get semua karyawan
select * from employees e;

-- Get semua produk dengan beberapa kolom
select productName, productLine, productDescription, quantityInStock, buyPrice from products p ;

-- Get lokasi customer
select customerName, addressLine1, city, state, country, postalCode from customers o ;


-- ## SORTING DATA

-- Get lokasi customer dengan mengurutkan negaranya
select customerName, addressLine1, city, state, country, postalCode from customers o order by country;

-- Get produk yang stoknya dibawah 500 unit
select productName, quantityInStock from products p where quantityInStock < 500 order by productName;
	

-- ## FILTERING DATA

-- Get jenis jenis jabatan
select distinct jobTitle from employees e order by jobTitle;

-- Get negara negara customer
select distinct country from customers c order by country;

-- Get kantor yang hanya berada di amerika
select * from offices o where country = 'USA';

-- Get produk yang harganya lebih dari 100 dollar
select productName, productVendor, productDescription, buyPrice from products p where buyPrice > 100;

-- Get karyawan yang memiliki nama depan A
select firstName, lastName, email from employees e where firstName LIKE 'a%';

-- Get order terbaru dengan status shipped
select * from orders o where status = 'Shipped' order by orderDate desc limit 1;


-- ## JOIN

-- Get customer yang memesan dalam jumlah banyak
select customerName, o.*
	from orderdetails o 
	join orders o2 on o.orderNumber = o2.orderNumber 
	join customers c on o2.customerNumber = c.customerNumber 
	order by quantityOrdered desc;

-- Get 5 customer yang melakukan pembayaran terbesar
select customerName, checkNumber, paymentDate, amount 
	from payments p 
	join customers c on c.customerNumber = p.customerNumber 
	order by amount desc
	limit 5;

-- Get karyawan yang bekerja di Perancis
select e.firstName, e.lastName, e.email, e.jobTitle, o.country from employees e 
	join offices o on e.officeCode = o.officeCode 
	where o.country = 'France';

-- Get order dari customer di luar Amerika dan Inggris
select c.customerName, c.country, o.* from orders o
	inner join customers c on o.customerNumber = c.customerNumber 
	where c.country not in ('USA', 'UK')
	order by country;


-- ## AGREGATE

-- Get total order pada tahun 2004
select count(orderNumber) from orders o3 where YEAR(orderDate) = '2004';

-- Get nama lengkap karyawan dan jabatannya
select CONCAT(firstName, ' ', lastName) as employeeName, jobTitle 
	from employees e order by employeeName; 

-- Get lokasi karyawan bekerja
select CONCAT(firstName, ' ', lastName) as employeeName, addressLine1, city 
	from employees e 
	join offices o on e.officeCode = o.officeCode 
	order by employeeName; 
	
-- Get rata rata pembayaran per customer
select c.customerName, avg(p.amount) from payments p 
	inner join customers c on p.customerNumber = c.customerNumber
	group by c.customerName;
	
-- Get jumlah setiap produk yang berhasil terjual di tahun 2005
select p.productName, sum(o.quantityOrdered) from products p 
	join orderdetails o on p.productCode = o.productCode 
	join orders o2 on o.orderNumber = o2.orderNumber 
	where year(o2.orderDate) = '2005'
	group by p.productName;


-- ## ANOTHER DML

-- Insert kantor baru
insert into offices
values(8, 'Bandung', '+62 821 1713 3380', 'Buah Batu Regency', 'No 9-10A', 'Jawa Barat', 'Indonesia', '40247', 'NA');

select * from offices o ;

-- Update harga produk Ferrari Enzo
update products set buyPrice = 100.25 where productName = '2001 Ferrari Enzo';

select productName, buyPrice from products p where productName = '2001 Ferrari Enzo';

-- Hapus kantor bandung
delete from offices where city = 'Bandung';

select * from offices o ;


-- ## DDL

-- Create tabel salary
create table salary
(
	salaryId int primary key,
	salary int,
	employeeId int
);

show tables;

-- Alter tambah kolom tabel salary
alter table salary 
add(grade varchar(5));

desc salary;

-- Hapus tabel salary
drop table salary;

show tables;


-- ## INDEX

-- create index
create index country_name
on customers(country);

explain
select * from customers c where country = 'USA';

-- Hapus index
drop index country_name on customers;