-- here create database : LibraryData
create database LibraryData;

-- using the database
use LibraryData;

-- creating publisher table
create table Publisher(
publisher_PublisherName varchar(200) primary key,
publisher_PublisherAddress varchar(200),
publisher_PublisherPhone varchar(50)
);

-- checking publisher table
select * from Publisher limit 5;

-- creating book table
create table Books(
book_BookID int auto_increment primary key,
book_Title varchar(200),
book_PublisherName varchar(200),
foreign key (book_PublisherName) references Publisher(publisher_PublisherName) ON DELETE CASCADE ON UPDATE CASCADE
);

-- checking book table
select * from Books limit 5;

-- creating table book author
create table Book_Author(
book_authors_BookID INT,
book_authors_AuthorID INT AUTO_INCREMENT PRIMARY KEY,
book_authors_AuthorName VARCHAR(255),
FOREIGN KEY (book_authors_BookID) REFERENCES Books(book_BookID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- checking author table
select * from Book_Author limit 5;


-- create table of book_copies
create table book_copies(
book_copies_BookID int,
book_copies_CopiesID int auto_increment primary key,
book_copies_BranchID int,
book_copies_No_Of_Copies int,
foreign key (book_copies_BookID) references Books(book_BookID) on delete cascade on update cascade,
foreign key (book_copies_BranchID) references library_branch(library_branch_BranchID) on delete cascade on update cascade
);

-- checking book_copies table
select * from book_copies limit 5;



-- creating borrower table
create table borrower(
borrower_CardNo int auto_increment primary key,
borrower_BorrowerName varchar(200),
borrower_BorrowerAddress varchar(200),
borrower_BorrowerPhone varchar(200)
);

-- checking borrower table
select * from borrower limit 5;

-- creating books_loan
create table book_loan(
book_loans_BookID int,
book_loan_LoansID int auto_increment primary key,
book_loans_BranchID int,
book_loans_CardNo int,
book_loans_DateOut date,
book_loans_DueDate date,
foreign key (book_loans_CardNo) references borrower(borrower_CardNo) on delete cascade on update cascade,
foreign key (book_loans_BranchID) references library_branch(library_branch_BranchID) on delete cascade on update cascade,
foreign key (book_loans_BookID) references Books(book_BookID) on delete cascade on update cascade
);


-- checking book_loan table
select * from book_loan limit 5;


-- creating table library branch
create table library_branch(
library_branch_BranchID int auto_increment primary key,
library_branch_BranchName varchar(200),
library_branch_BranchAddress varchar(200)
);

-- checking library_branch table
select * from library_branch limit 5;


-- 1.	How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
select book_copies_No_Of_Copies from book_copies join books on book_copies.book_copies_BookID = books.book_BookID
join library_branch on book_copies.book_copies_BranchID = library_branch.library_branch_BranchID
where books.book_title = 'The Lost Tribe'  and library_branch.library_branch_BranchName ='Sharpstown';



-- 2.	How many copies of the book titled "The Lost Tribe" are owned by each library branch?
select lb.library_branch_BranchName, sum(bc.book_copies_No_Of_Copies) from book_copies as bc
join books as b on bc.book_copies_BookID = b.book_BookID
join library_branch as lb on bc.book_copies_BranchID = lb.library_branch_BranchID
where b.book_title = 'The Lost Tribe'
group by lb.library_branch_BranchName;


-- 3.	Retrieve the names of all borrowers who do not have any books checked out.
select br.borrower_BorrowerName from borrower as br
left join book_loan bl on br.borrower_CardNo = bl.book_loans_CardNo
where bl.book_loans_CardNo is null;

-- 4.	For each book that is loaned out 
-- from the "Sharpstown" branch and whose DueDate is 2/3/18, 
-- retrieve the book title, the borrower's name, and the borrower's address. 
SELECT b.book_Title, br.borrower_BorrowerName, br.borrower_BorrowerAddress
FROM book_loan bl
JOIN books b ON bl.book_loans_BookID = b.book_BookID
JOIN borrower br ON bl.book_loans_CardNo = br.borrower_CardNo
JOIN library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
WHERE lb.library_branch_BranchName = 'Sharpstown'
AND bl.book_loans_DueDate = '2018-02-03';


-- 5.For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
select lb.library_branch_BranchName,count(bl.book_loans_BookID) AS total_books_loaned from book_loan bl
join library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
group by lb.library_branch_BranchName;


-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
SELECT br.borrower_BorrowerName, br.borrower_BorrowerAddress, COUNT(bl.book_loans_BookID) AS total_books_checked_out
FROM borrower br
JOIN book_loan bl ON br.borrower_CardNo = bl.book_loans_CardNo
GROUP BY br.borrower_BorrowerName, br.borrower_BorrowerAddress
HAVING COUNT(bl.book_loans_BookID) > 5;


-- 7.For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
SELECT b.book_Title, bc.book_copies_No_Of_Copies
FROM books b
JOIN book_author ba ON b.book_BookID = ba.book_authors_BookID
JOIN book_copies bc ON b.book_BookID = bc.book_copies_BookID
JOIN library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE ba.book_authors_AuthorName = 'Stephen King'
AND lb.library_branch_BranchName = 'Central';
